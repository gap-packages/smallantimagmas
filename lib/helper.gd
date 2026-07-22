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
    result := DirectoriesPackageLibrary("smallantimagmas", Concatenation(["data", "/", String(order)]));
    if Size(result) = 0 then
        ErrorNoReturn("smallantimagmas:", "<order> is not yet implemeneted");
    fi;
    if Size(result) > 1 then
        ErrorNoReturn("smallantimagmas:", "metadata directory must not be ambigous");
    fi;
    return First(result);
end;

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

__SmallAntimagmaHelper.MultiplicationTableConvert := function(T)
        local nrows;
        nrows := NrRows(T);
        return List(T, row -> Position(EnumeratorOfTuples([1 .. nrows], nrows), row));
end;

__SmallAntimagmaHelper.MultiplicationTableReverse := function(T)
        local ncols;
        ncols := Size(T);
        return List(T, col -> EnumeratorOfTuples([1 .. ncols], ncols)[col]);
end;