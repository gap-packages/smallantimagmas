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
        if IsList(order) and ForAll(order, o -> IsInt(o)) then
            return Flat(
                List(order, o -> List(__SmallAntimagmaHelper.getSmallAntimagmaMetadata(o)(),
                                    id -> MagmaByMultiplicationTable(id)))
            );
        elif IsInt(order) then
            return List(__SmallAntimagmaHelper.getSmallAntimagmaMetadata(order)(), id -> MagmaByMultiplicationTable(id));
        fi;
end);

InstallGlobalFunction(OneSmallAntimagma,
    function(order)
        return SmallAntimagma(order, Random([1 .. NrSmallAntimagmas(order) ]));
end);

InstallGlobalFunction(ReallyNrSmallAntimagmas,
    function(order)
        return Size(__SmallAntimagmaHelper.getAllSmallAntimagmaMetadata(order)());
end);

InstallGlobalFunction(ReallyAllSmallAntimagmas,
    function(order)
        if IsList(order) and ForAll(order, o -> IsInt(o)) then
            return Flat(
                List(order, o -> List(__SmallAntimagmaHelper.getAllSmallAntimagmaMetadata(o)(),
                                    id -> MagmaByMultiplicationTable(id)))
            );
        elif IsInt(order) then
            return List(__SmallAntimagmaHelper.getAllSmallAntimagmaMetadata(order)(), id -> MagmaByMultiplicationTable(id) );
        fi;
end);