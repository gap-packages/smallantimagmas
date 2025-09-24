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
    result := DirectoriesPackageLibrary("smallantimagmas", Concatenation(["data", "/", "non-isomorphic", "/", String(order)]));
    if Size(result) = 0 then
        ErrorNoReturn("smallantimagmas:", "<order> is not yet implemeneted");
    fi;
    if Size(result) > 1 then
        ErrorNoReturn("smallantimagmas:", "metadata directory must not be ambigous");
    fi;
    return First(result);
end;

__SmallAntimagmaHelper.getSmallAntimagmaMetadata := function(order)
    local dir, files;
    dir := __SmallAntimagmaHelper.getSmallAntimagmaMetadataDirectory(order);
    files := SortedList(List(Filtered(DirectoryContents(dir), f -> f <> ".." and f <> "."), f -> Filename(dir, f)));
    return ReadAsFunction(First(files));
end;

__SmallAntimagmaHelper.getAllSmallAntimagmaMetadataDirectory := function(order)
    local result;
    __SmallAntimagmaHelper.checkOrder(order);
    result := DirectoriesPackageLibrary("smallantimagmas", Concatenation(["data", "/", "all", "/", String(order)]));
    if Size(result) = 0 then
        ErrorNoReturn("smallantimagmas:", "<order> is not yet implemeneted");
    fi;
    if Size(result) > 1 then
        ErrorNoReturn("smallantimagmas:", "metadata directory must not be ambigous");
    fi;
    return First(result);
end;

__SmallAntimagmaHelper.getAllSmallAntimagmaMetadata := function(order)
    local dir, files;
    dir := __SmallAntimagmaHelper.getAllSmallAntimagmaMetadataDirectory(order);
    files := SortedList(List(Filtered(DirectoryContents(dir), f -> f <> ".." and f <> "."), f -> Filename(dir, f)));
    return ReadAsFunction(First(files));
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


__SmallAntimagmaHelper.VerifyIfIndexIsAntiassociative := function( order, index )
    local es;
    es := EnumeratorOfTuples( EnumeratorOfTuples( [1..order], order ), order );
    if index > Length(es) then
        Error("Index out of range");
    fi;

    return IsAntiassociative(MagmaByMultiplicationTable(es[index]));
end;

__SmallAntimagmaHelper.SaveIndexData := function(order, index)
    local libfile, output, result;
    libfile := Concatenation( 
             GAPInfo.PackagesInfo.( "smallantimagmas" )[1].InstallationPath,
             "/userdata/",
             String( order ), ".g");
    output := OutputTextFile( libfile, true );
    SetPrintFormattingStatus( output, false );

    result := __SmallAntimagmaHelper.VerifyIfIndexIsAntiassociative(order, index); 

    if result then
        AppendTo(output, String(index), "\n");
    fi;
    CloseStream( output );
    return result;
end;

__SmallAntimagmaHelper.SaveData := function(order, bounds)
    local index, start_index, end_index;
    Print("Processing order ", order, " from index ", bounds[1], " to ", bounds[2], "\n");
    start_index := bounds[1];
    end_index := bounds[2];

    index := start_index;
    while index <= end_index do
        __SmallAntimagmaHelper.SaveIndexData(order, index);
        index := index + 1;
    od;
end;


__SmallAntimagmaHelper.SplitInteger := function(n, number_of_subsets, i)
    local total, subsetSize, subset_start, subset_end;
    total := n^(n^2);
    subsetSize := total / number_of_subsets;
    subset_start := Int((i - 1) * subsetSize) + 1;
    subset_end := Int(i * subsetSize);
    return [subset_start, subset_end];
end;