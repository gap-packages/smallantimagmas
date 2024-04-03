InstallGlobalFunction(NrSmallAntimagmas,
    function(order)
    return Size(__SmallAntimagmaHelper.getSmallAntimagmaMetadata(order)());
end);

InstallGlobalFunction(SmallAntimagma,
    function(order, id)
    return MagmaByMultiplicationTable(__SmallAntimagmaHelper.getSmallAntimagmaMetadata(order)()[id]);
end);

InstallGlobalFunction(AllSmallAntimagmas,
    function(order)
    return List(__SmallAntimagmaHelper.getSmallAntimagmaMetadata(order)(), id -> MagmaByMultiplicationTable(id));
end);

InstallGlobalFunction(OneSmallAntimagma,
    function(order)
    return SmallAntimagma(order, Random([1..NrSmallAntimagmas(order)]));
end);
