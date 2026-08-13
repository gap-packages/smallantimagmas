__SmallAntimagmaHelper := rec();

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

# inverse of TablesEncode: prefix-sums the deltas, then reads every number as n
# digits in base n^n, each digit shifted by one.
#
#     2, [ 10 ]          -> [ [ 3, 3 ] ]
#     3, [ 6813, 3366 ]  -> [ [ 10, 10, 10 ], [ 14, 27, 1 ] ]
__SmallAntimagmaHelper.TablesDecode := function(order, deltas)
    local m, prev, result, d, N, t, i;
    m := order ^ order;
    prev := 0;
    result := [];
    for d in deltas do
        prev := prev + d;
        N := prev;
        t := [];
        for i in [1 .. order] do
            Add(t, RemInt(N, m) + 1);
            N := QuoInt(N, m);
        od;
        Add(result, Reversed(t));
    od;
    return result;
end;

__SmallAntimagmaHelper.getSmallAntimagmaMetadata := function(order)
    local dir, files, tables;
    dir := __SmallAntimagmaHelper.getSmallAntimagmaMetadataDirectory(order);
    files := SortedList(List(Filtered(DirectoryContents(dir), f -> f <> ".." and f <> "."), f -> Filename(dir, f)));
    tables := __SmallAntimagmaHelper.TablesDecode(order, ReadAsFunction(First(files))());
    return {} -> tables;
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