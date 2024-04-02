__SmallAntimagmaHelper := rec();

__SmallAntimagmaHelper.checkOrder := function(order)
        if not IsInt(order) then
            ErrorNoReturn("SmallAntimagmas: ", "<order> must be an integer");
        fi;

        if order < 1 then
            ErrorNoReturn("SmallAntimagmas:", "<order> must greater than or equal to 1");
        fi;
end;

__SmallAntimagmaHelper.checkId := function(id)
        if not IsInt(id) then
            ErrorNoReturn("SmallAntimagmas: ", "<id> must be an integer");
        fi;

        if id < 1 then
            ErrorNoReturn("SmallAntimagmas:", "<id> must greater than or equal to 1");
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
        ErrorNoReturn("SmallAntimagmas:", "<order> is not yet implemeneted");
    fi;
    if Size(result) > 1 then
        ErrorNoReturn("SmallAntimagmas:", "metadata directory must not be ambigous");
    fi;
    return First(result);
end;

__SmallAntimagmaHelper.getSmallAntimagmaMetadata := function(order)
    local dir, files;
    dir := __SmallAntimagmaHelper.getSmallAntimagmaMetadataDirectory(order);
    files := SortedList(List(Filtered(DirectoryContents(dir), f -> f <> ".." and f <> "."), f -> Filename(dir, f)));
    return ReadAsFunction(First(files));
end;
