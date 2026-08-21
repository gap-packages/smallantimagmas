__SmallAntimagmaHelper := rec();

# walks the numbers of a data file, a block at a time, without handing it to the
# parser and without ever holding the whole of it.
#
# the file is a single list literal, and a list literal is one expression: the
# parser builds a node per entry and refuses the whole function once that
# expression grows too large, which the 233701268 entries of order 5 do. the
# bytes are plain enough to scan directly, so this reads them in blocks and hands
# the numbers of each block to <process>, which returns false to stop the walk.
#
#     "local result;result:=[10];return result;"        -> [ 10 ]
#     "local result;result:=[6813,3366];return result;" -> [ 6813, 3366 ]
__SmallAntimagmaHelper.ForEachBlock := function(path, process)
    local stream, tail, chunk, piece, opened, closed, more, at, i;

    stream := InputTextFile(path);
    if stream = fail then
        ErrorNoReturn("smallantimagmas: ", "<path> could not be read");
    fi;

    tail := "";
    opened := false;
    closed := false;
    more := true;

    repeat
        chunk := ReadAll(stream, 2 ^ 22);
        if chunk = fail then
            chunk := "";
        fi;
        tail := Concatenation(tail, chunk);
        piece := "";

        if not opened then
            at := Position(tail, '[');
            if at <> fail then
                tail := tail{[at + 1 .. Length(tail)]};
                opened := true;
            fi;
        fi;

        if opened then
            at := Position(tail, ']');
            if at <> fail then
                piece := tail{[1 .. at - 1]};
                tail := "";
                closed := true;
            else
                # cut at the last comma, so that no number is split in two
                i := Length(tail);
                while i > 0 and tail[i] <> ',' do
                    i := i - 1;
                od;
                if i > 0 then
                    piece := tail{[1 .. i - 1]};
                    tail := tail{[i + 1 .. Length(tail)]};
                fi;
            fi;
        fi;

        if piece <> "" then
            more := process(List(SplitString(piece, ","), Int));
        fi;
    until closed or chunk = "" or not more;

    CloseStream(stream);

    if more and not closed then
        ErrorNoReturn("smallantimagmas: ", "<path> holds no complete list of tables");
    fi;
end;

# every delta of a data file.
__SmallAntimagmaHelper.ReadDeltas := function(path)
    local deltas;
    deltas := [];
    __SmallAntimagmaHelper.ForEachBlock(path, function(block)
        Append(deltas, block);
        return true;
    end);
    return deltas;
end;

# the key of entry <id> of a data file, or, with <id> = fail, how many it holds.
#
# the deltas are a prefix sum, so reaching an entry needs nothing but a running
# total: whole blocks are summed by the kernel and dropped again, and the walk
# stops the moment the entry is reached. memory is constant either way, and the
# cost grows with <id>, not with the size of the file.
__SmallAntimagmaHelper.ScanDeltas := function(path, id)
    local key, seen, found;

    key := 0;
    seen := 0;
    found := fail;

    __SmallAntimagmaHelper.ForEachBlock(path, function(block)
        if id <> fail and seen + Length(block) >= id then
            found := key + Sum(block{[1 .. id - seen]});
            return false;
        fi;
        key := key + Sum(block);
        seen := seen + Length(block);
        return true;
    end);

    if id = fail then
        return seen;
    fi;
    if found = fail then
        ErrorNoReturn("smallantimagmas: ", "<id> is larger than the number of antimagmas of that order");
    fi;
    return found;
end;

__SmallAntimagmaHelper.checkOrder := function(order)
        if not IsInt(order) then
            ErrorNoReturn("smallantimagmas: ", "<order> must be an integer");
        fi;

        if order < 2 then
            ErrorNoReturn("smallantimagmas:", "<order> must be greater than or equal to 2");
        fi;
end;

__SmallAntimagmaHelper.checkId := function(id)
        if not IsInt(id) then
            ErrorNoReturn("smallantimagmas: ", "<id> must be an integer");
        fi;

        if id < 1 then
            ErrorNoReturn("smallantimagmas:", "<id> must be greater than or equal to 1");
        fi;
end;

__SmallAntimagmaHelper.checkOrderId := function(order, id)
    __SmallAntimagmaHelper.checkOrder(order);
    __SmallAntimagmaHelper.checkOrder(id);
end;

__SmallAntimagmaHelper.getSmallAntimagmaMetadataDirectory := function(order)
    local result;
    __SmallAntimagmaHelper.checkOrder(order);
    result := DirectoriesPackageLibrary("smallantimagmas", Concatenation(["data", "/", String(order)]));
    if Size(result) = 0 then
        ErrorNoReturn("smallantimagmas:", "<order> is not yet implemented");
    fi;
    if Size(result) > 1 then
        ErrorNoReturn("smallantimagmas:", "metadata directory must not be ambiguous");
    fi;
    return First(result);
end;

# packs every row form into a base-(n^n) number, sorts them, and returns the
# successive differences, so a data file holds small deltas, not big integers.
#
#     2, [ [ 3, 3 ] ]                      -> [ 10 ]            (2 * 4 + 2)
#     3, [ [ 10, 10, 10 ], [ 14, 27, 1 ] ] -> [ 6813, 3366 ]
__SmallAntimagmaHelper.TablesEncode := function(order, tables)
    local m, numbers, deltas, prev, t, N, r;
    m := order ^ order;
    numbers := [];
    for t in tables do
        N := 0;
        for r in t do
            N := N * m + (r - 1);
        od;
        Add(numbers, N);
    od;
    Sort(numbers);
    deltas := [];
    prev := 0;
    for N in numbers do
        Add(deltas, N - prev);
        prev := N;
    od;
    return deltas;
end;

# one packed number read back as the row form of a table: n digits in base n^n,
# each digit shifted by one.
#
#     2, 10   -> [ 3, 3 ]
#     3, 6813 -> [ 10, 10, 10 ]
__SmallAntimagmaHelper.TableOfKey := function(order, key)
    local m, t, i;
    m := order ^ order;
    t := [];
    for i in [1 .. order] do
        Add(t, RemInt(key, m) + 1);
        key := QuoInt(key, m);
    od;
    return Reversed(t);
end;

# inverse of TablesEncode: prefix-sums the deltas, then reads every number as n
# digits in base n^n, each digit shifted by one.
#
#     2, [ 10 ]          -> [ [ 3, 3 ] ]
#     3, [ 6813, 3366 ]  -> [ [ 10, 10, 10 ], [ 14, 27, 1 ] ]
__SmallAntimagmaHelper.TablesDecode := function(order, deltas)
    local prev, result, d;
    prev := 0;
    result := [];
    for d in deltas do
        prev := prev + d;
        Add(result, __SmallAntimagmaHelper.TableOfKey(order, prev));
    od;
    return result;
end;

# the file holding the tables of one order.
__SmallAntimagmaHelper.getSmallAntimagmaMetadataFile := function(order)
    local dir, files;
    dir := __SmallAntimagmaHelper.getSmallAntimagmaMetadataDirectory(order);
    files := SortedList(List(Filtered(DirectoryContents(dir), f -> f <> ".." and f <> "."), f -> Filename(dir, f)));
    return First(files);
end;

__SmallAntimagmaHelper.getSmallAntimagmaMetadata := function(order)
    local tables;
    tables := __SmallAntimagmaHelper.TablesDecode(order,
        __SmallAntimagmaHelper.ReadDeltas(__SmallAntimagmaHelper.getSmallAntimagmaMetadataFile(order)));
    return {} -> tables;
end;

# the row form of the table of entry <id>, and of no other.
__SmallAntimagmaHelper.TableAt := function(order, id)
    return __SmallAntimagmaHelper.TableOfKey(order, __SmallAntimagmaHelper.ScanDeltas(
        __SmallAntimagmaHelper.getSmallAntimagmaMetadataFile(order), id));
end;

# how many tables the file of one order holds, without building any of them.
__SmallAntimagmaHelper.CountTables := function(order)
    return __SmallAntimagmaHelper.ScanDeltas(
        __SmallAntimagmaHelper.getSmallAntimagmaMetadataFile(order), fail);
end;

# encodes an n x n table into its row form: every row [ r_1, ..., r_n ] becomes
# its position in EnumeratorOfTuples([1 .. n], n), that is
# 1 + Sum_k (r_k - 1) * n^(n - k).
#
#     [ [ 2, 1 ], [ 2, 1 ] ]                    -> [ 3, 3 ]
#     [ [ 2, 2, 2 ], [ 3, 3, 3 ], [ 1, 1, 1 ] ] -> [ 14, 27, 1 ]
__SmallAntimagmaHelper.MultiplicationTableConvert := function(T)
        local nrows;
        nrows := NrRows(T);
        return List(T, row -> Position(EnumeratorOfTuples([1 .. nrows], nrows), row));
end;

# inverse of MultiplicationTableConvert: a row code c becomes the digits of c - 1
# in base n, every digit shifted by one.
#
#     [ 3, 3 ]      -> [ [ 2, 1 ], [ 2, 1 ] ]
#     [ 14, 27, 1 ] -> [ [ 2, 2, 2 ], [ 3, 3, 3 ], [ 1, 1, 1 ] ]
__SmallAntimagmaHelper.MultiplicationTableReverse := function(T)
        local ncols;
        ncols := Size(T);
        return List(T, col -> EnumeratorOfTuples([1 .. ncols], ncols)[col]);
end;
