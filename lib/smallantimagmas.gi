InstallGlobalFunction(NrSmallAntimagmas,
    function(order)
    return Size(__SmallAntimagmaHelper.getSmallAntimagmaMetadata(order)());
end);

InstallGlobalFunction(AllSmallAntimagmas,
    function(order)
    return List(__SmallAntimagmaHelper.getSmallAntimagmaMetadata(order)(), id -> MagmaByMultiplicationTable(id));
end);

InstallGlobalFunction(SmallAntimagma,
    function(order, id)
    return MagmaByMultiplicationTable(__SmallAntimagmaHelper.getSmallAntimagmaMetadata(order)()[id]);
end);

InstallGlobalFunction(OneSmallAntimagma,
    function(order)
    return SmallAntimagma(order, Random([1 .. NrSmallAntimagmas(order) ]));
end);

InstallGlobalFunction(IdAntimagma,
    function(M)
    local id, n;
    n := Size(M);
    id := First(Filtered([1 .. NrSmallAntimagmas(n)], i -> IsMagmaIsomorphic(M, SmallAntimagma(n, i))));
    return [n, id];
end);

InstallGlobalFunction(ReallyNrSmallAntimagmas,
    function(order)
    return Size(__SmallAntimagmaHelper.getAllSmallAntimagmaMetadata(order)());
end);

InstallGlobalFunction(ReallyAllSmallAntimagmas,
    function(order)
    return List(__SmallAntimagmaHelper.getAllSmallAntimagmaMetadata(order)(), id -> MagmaByMultiplicationTable(id) );
end);
