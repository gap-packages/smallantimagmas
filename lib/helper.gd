__SmallAntimagmaHelper := rec();

__SmallAntimagmaHelper.checkOrder := function(order)
        if not IsInt(order) then
            ErrorNoReturn("smallantimagmas: ", "<order> must be an integer");
        fi;

        if order < 2 then
            ErrorNoReturn("smallantimagmas:", "<order> must greater than or equal to 2");
        fi;
end;

__SmallAntimagmaHelper.checkId := function(id)
        if not IsInt(id) then
            ErrorNoReturn("smallantimagmas: ", "<id> must be an integer");
        fi;

        if id < 1 then
            ErrorNoReturn("smallantimagmas:", "<id> must greater than or equal to 1");
        fi;
end;

__SmallAntimagmaHelper.checkOrderId := function(order, id)
    __SmallAntimagmaHelper.checkOrder(order);
    __SmallAntimagmaHelper.checkOrder(id);
end;

__SmallAntimagmaHelper.getSmallAntimagmaMetadataDirectory := function(order)
    local result;
    __SmallAntimagmaHelper.checkOrder(order);
    result := DirectoriesPackageLibrary("smallantimagmas",
        Concatenation(["data", "/", "non-isomorphic", "/",
                        String(order)]));
    if Size(result) = 0 then
        ErrorNoReturn("smallantimagmas:", "<order> is not yet implemeneted");
    fi;
    if Size(result) > 1 then
        ErrorNoReturn("smallantimagmas:",
                       "metadata directory must not be ambigous");
    fi;
    return First(result);
end;

__SmallAntimagmaHelper.getSmallAntimagmaMetadata := function(order)
    local dir, files;
    dir := __SmallAntimagmaHelper.getSmallAntimagmaMetadataDirectory(order);
    files := SortedList(List(Filtered(DirectoryContents(dir), f -> f <> ".." and f <> "."), f -> Filename(dir, f)));
    return ReadAsFunction(First(files));
end;

__SmallAntimagmaHelper.getAllSmallAntimagmaMetadataDirectory :=
    function(order)
    local result;
    __SmallAntimagmaHelper.checkOrder(order);
    result := DirectoriesPackageLibrary("smallantimagmas",
        Concatenation(["data", "/", "all", "/", String(order)]));
    if Size(result) = 0 then
        ErrorNoReturn("smallantimagmas:", "<order> is not yet implemeneted");
    fi;
    if Size(result) > 1 then
        ErrorNoReturn("smallantimagmas:",
                       "metadata directory must not be ambigous");
    fi;
    return First(result);
end;

__SmallAntimagmaHelper.getAllSmallAntimagmaMetadata := function(order)
    local dir, files;
    dir := __SmallAntimagmaHelper.getAllSmallAntimagmaMetadataDirectory(order);
    files := SortedList(List(Filtered(DirectoryContents(dir), f -> f <> ".." and f <> "."), f -> Filename(dir, f)));
    return ReadAsFunction(First(files));
end;

__SmallAntimagmaHelper.EnumeratorOfTuplesWithCache :=
    (function()
        local enumerators;
        enumerators := [];
        return function(n)
            if not IsBound(enumerators[n]) then
                enumerators[n] := EnumeratorOfTuples([1 .. n], n);
            fi;
            return enumerators[n];
        end;
    end)();

__SmallAntimagmaHelper.MultiplicationTableConvert := function(T)
        local nrows, enum;
        nrows := NrRows(T);
        enum := __SmallAntimagmaHelper.EnumeratorOfTuplesWithCache(nrows);
        return List(T, row -> Position(enum, row));
end;

__SmallAntimagmaHelper.MultiplicationTableReverse := function(T)
        local ncols, enum;
        ncols := Size(T);
        enum := __SmallAntimagmaHelper.EnumeratorOfTuplesWithCache(ncols);
        return List(T, col -> enum[col]);
end;

# ====================================================================
# Precomputed powers cache: n^0, n^1, ..., n^(n-1)
# ====================================================================
__SmallAntimagmaHelper.PowersOfNWithCache :=
    (function()
        local cache;
        cache := [];
        return function(n)
            if not IsBound(cache[n]) then
                cache[n] := List([1 .. n], c -> n ^ (c - 1));
                MakeImmutable(cache[n]);
            fi;
            return cache[n];
        end;
    end)();

# ====================================================================
# Precomputed powers cache: (n^n)^0, (n^n)^1, ..., (n^n)^(n-1)
# ====================================================================
__SmallAntimagmaHelper.PowersOfNNWithCache :=
    (function()
        local cache;
        cache := [];
        return function(n)
            local nn;
            if not IsBound(cache[n]) then
                nn := n ^ n;
                cache[n] := List([1 .. n], r -> nn ^ (r - 1));
                MakeImmutable(cache[n]);
            fi;
            return cache[n];
        end;
    end)();

# ====================================================================
# Row dictionary cache: all n^n possible rows for order n
# GAP arrays are 1-indexed, so row ID 0 is stored at index 1.
# ====================================================================
__SmallAntimagmaHelper.RowDictWithCache :=
    (function()
        local cache;
        cache := [];
        return function(n)
            local nn, powers_n;
            if not IsBound(cache[n]) then
                nn := n ^ n;
                powers_n :=
                    __SmallAntimagmaHelper.PowersOfNWithCache(n);
                cache[n] := List([0 .. nn - 1], i ->
                    List([1 .. n],
                         c -> (QuoInt(i, powers_n[c]) mod n) + 1));
                MakeImmutable(cache[n]);
            fi;
            return cache[n];
        end;
    end)();

# ====================================================================
# Encode a multiplication table (list of lists, entries 1..n) to a
# single immediate integer using base-n^n packing.
# ====================================================================
__SmallAntimagmaHelper.MultiplicationTableEncode :=
    function(table)
    local n, encoded, r, c, row_id, powers_n, powers_nn;
    n := Length(table);
    powers_n := __SmallAntimagmaHelper.PowersOfNWithCache(n);
    powers_nn := __SmallAntimagmaHelper.PowersOfNNWithCache(n);
    encoded := 0;

    for r in [1 .. n] do
        row_id := 0;
        for c in [1 .. n] do
            row_id := row_id
                      + (table[r][c] - 1) * powers_n[c];
        od;
        encoded := encoded + row_id * powers_nn[r];
    od;

    return encoded;
end;

# ====================================================================
# Decode a single integer back to an n x n multiplication table.
# ====================================================================
__SmallAntimagmaHelper.MultiplicationTableDecode :=
    function(encoded, n)
    local powers_nn, nn, row_dict;
    powers_nn := __SmallAntimagmaHelper.PowersOfNNWithCache(n);
    nn := n ^ n;
    row_dict := __SmallAntimagmaHelper.RowDictWithCache(n);
    return List([1 .. n], function(r)
        local row_id;
        row_id := QuoInt(encoded, powers_nn[r]) mod nn;
        return row_dict[row_id + 1];
    end);
end;

# ====================================================================
# O(1) access to entry (r, c) of an encoded table.
# r and c are 1-indexed (1 to n).
# ====================================================================
__SmallAntimagmaHelper.MultiplicationTableGetEntry :=
    function(encoded, n, r, c)
    local row_id, powers_nn, nn, row_dict;
    powers_nn := __SmallAntimagmaHelper.PowersOfNNWithCache(n);
    nn := n ^ n;
    row_dict := __SmallAntimagmaHelper.RowDictWithCache(n);
    row_id := QuoInt(encoded, powers_nn[r]) mod nn;
    return row_dict[row_id + 1][c];
end;