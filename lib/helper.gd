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

__SmallAntimagmaHelper.checkNonnegativeIntegerList := function(values)
    if not IsList(values) then
        ErrorNoReturn("smallantimagmas: ", "<values> must be a list");
    fi;

    if not ForAll(values, value -> IsInt(value) and value >= 0) then
        ErrorNoReturn("smallantimagmas: ",
                      "<values> must contain only nonnegative integers");
    fi;
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
                       "metadata directory must not be ambiguous");
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
                       "metadata directory must not be ambiguous");
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

__SmallAntimagmaHelper.IntegerLog2Floor := function(n)
    local result;
    result := 0;

    while n >= 2 do
        n := QuoInt(n, 2);
        result := result + 1;
    od;

    return result;
end;

__SmallAntimagmaHelper.EliasFanoIndexOfSet := function(values)
    local set_values, size, universe, lower_bits_count,
          lower_base, lower_mask, lower_parts, upper_positions,
          i, high_part, result;

    __SmallAntimagmaHelper.checkNonnegativeIntegerList(values);

    set_values := Set(values);
    size := Length(set_values);

    if size = 0 then
        return rec(
            size := 0,
            universe := 0,
            lowerBitsCount := 0,
            lowerBase := 1,
            lowerMask := 0,
            lowerParts := [],
            upperPositions := []);
    fi;

    universe := Maximum(set_values) + 1;
    if universe <= size then
        lower_bits_count := 0;
    else
        lower_bits_count := __SmallAntimagmaHelper.IntegerLog2Floor(
            QuoInt(universe, size));
    fi;

    lower_base := 2 ^ lower_bits_count;
    lower_mask := lower_base - 1;
    lower_parts := List(set_values, value -> value mod lower_base);
    upper_positions := [];

    for i in [1 .. size] do
        high_part := QuoInt(set_values[i], lower_base);
        Add(upper_positions, high_part + i);
    od;

    MakeImmutable(lower_parts);
    MakeImmutable(upper_positions);

    result := rec(
        size := size,
        universe := universe,
        lowerBitsCount := lower_bits_count,
        lowerBase := lower_base,
        lowerMask := lower_mask,
        lowerParts := lower_parts,
        upperPositions := upper_positions);
    MakeImmutable(result);
    return result;
end;

__SmallAntimagmaHelper.EliasFanoIndexGet := function(index, position)
    local high_part;

    if not IsInt(position) or position < 1 or position > index.size then
        ErrorNoReturn("smallantimagmas: ",
                      "<position> must be an integer between 1 and index.size");
    fi;

    high_part := index.upperPositions[position] - position;
    return high_part * index.lowerBase + index.lowerParts[position];
end;

__SmallAntimagmaHelper.EliasFanoIndexDecode := function(index)
    return List([1 .. index.size],
                position -> __SmallAntimagmaHelper.EliasFanoIndexGet(
                    index, position));
end;

__SmallAntimagmaHelper.EliasFanoIndexContains := function(index, value)
    local left, right, middle, current;

    if not IsInt(value) or value < 0 then
        return false;
    fi;

    left := 1;
    right := index.size;

    while left <= right do
        middle := QuoInt(left + right, 2);
        current := __SmallAntimagmaHelper.EliasFanoIndexGet(index, middle);

        if current = value then
            return true;
        elif current < value then
            left := middle + 1;
        else
            right := middle - 1;
        fi;
    od;

    return false;
end;

__SmallAntimagmaHelper.EliasFanoIndexOfList := function(values)
    local sorted_values, positions, result;

    __SmallAntimagmaHelper.checkNonnegativeIntegerList(values);
    sorted_values := Set(values);
    positions := List(values,
                      value -> PositionSorted(sorted_values, value));
    MakeImmutable(positions);

    result := rec(
        size := Length(values),
        index := __SmallAntimagmaHelper.EliasFanoIndexOfSet(sorted_values),
        positions := positions);
    MakeImmutable(result);
    return result;
end;

__SmallAntimagmaHelper.EliasFanoIndexListGet := function(index, position)
    if not IsInt(position) or position < 1 or position > index.size then
        ErrorNoReturn("smallantimagmas: ",
                      "<position> must be an integer between 1 and index.size");
    fi;

    return __SmallAntimagmaHelper.EliasFanoIndexGet(index.index,
                                                    index.positions[position]);
end;

__SmallAntimagmaHelper.EliasFanoIndexListDecode := function(index)
    return List([1 .. index.size],
                position -> __SmallAntimagmaHelper.EliasFanoIndexListGet(
                    index, position));
end;

__SmallAntimagmaHelper.IsEliasFanoSetIndex := function(index)
    return IsRecord(index)
           and IsBound(index.size)
           and IsBound(index.universe)
           and IsBound(index.lowerBitsCount)
           and IsBound(index.lowerBase)
           and IsBound(index.lowerMask)
           and IsBound(index.lowerParts)
           and IsBound(index.upperPositions);
end;

__SmallAntimagmaHelper.IsEliasFanoListIndex := function(index)
    return IsRecord(index)
           and IsBound(index.size)
           and IsBound(index.index)
           and IsBound(index.positions)
           and __SmallAntimagmaHelper.IsEliasFanoSetIndex(index.index);
end;

__SmallAntimagmaHelper.MetadataIndexFromData := function(metadata)
    if __SmallAntimagmaHelper.IsEliasFanoListIndex(metadata) then
        return metadata;
    fi;

    return __SmallAntimagmaHelper.EliasFanoIndexOfList(metadata);
end;

__SmallAntimagmaHelper.getSmallAntimagmaMetadataIndex :=
    (function()
        local cache;
        cache := [];
        return function(order)
            if not IsBound(cache[order]) then
                cache[order] := __SmallAntimagmaHelper.MetadataIndexFromData(
                    __SmallAntimagmaHelper.getSmallAntimagmaMetadata(order)());
            fi;
            return cache[order];
        end;
    end)();

__SmallAntimagmaHelper.getAllSmallAntimagmaMetadataIndex :=
    (function()
        local cache;
        cache := [];
        return function(order)
            if not IsBound(cache[order]) then
                cache[order] := __SmallAntimagmaHelper.MetadataIndexFromData(
                    __SmallAntimagmaHelper.getAllSmallAntimagmaMetadata(order)());
            fi;
            return cache[order];
        end;
    end)();