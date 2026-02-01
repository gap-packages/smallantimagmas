InstallGlobalFunction(NrSmallAntimagmas,
    function(order)
    return Size(__SmallAntimagmaHelper.getSmallAntimagmaMetadata(order)());
end);

InstallGlobalFunction(SmallAntimagma,
    function(arg)
        local order, id;
        if Length(arg) = 1 and IsList(arg[1]) and Length(arg[1]) = 2 then
            order := arg[1][1];
            id := arg[1][2];
        elif Length(arg) = 2 then
            order := arg[1];
            id := arg[2];
        else
            Error("SmallAntimagma: expected (n, i) or [n, i]");
        fi;
        return MagmaByMultiplicationTable(
            __SmallAntimagmaHelper.MultiplicationTableReverse(__SmallAntimagmaHelper.getSmallAntimagmaMetadata(order)()[id]));
end);

InstallGlobalFunction(AllSmallAntimagmas,
    function(order)
        if IsList(order) and ForAll(order, o -> IsInt(o)) then
            return Flat(
                List(order, o -> List(__SmallAntimagmaHelper.getSmallAntimagmaMetadata(o)(),
                                    table -> MagmaByMultiplicationTable(
                                        __SmallAntimagmaHelper.MultiplicationTableReverse(table)))));
        elif IsInt(order) then
            return List(__SmallAntimagmaHelper.getSmallAntimagmaMetadata(order)(), table -> MagmaByMultiplicationTable(
                                        __SmallAntimagmaHelper.MultiplicationTableReverse(table)));
        fi;
end);

InstallMethod(IdSmallAntimagma, "for a magma", [IsMagma],
    function(M)
        local n;
        n := Size(M);
        return [n, First(Filtered([1 .. NrSmallAntimagmas(n)], index -> IsMagmaIsomorphic(M, SmallAntimagma(n, index))))];
end);

InstallGlobalFunction(OneSmallAntimagma,
    function(order)
        return SmallAntimagma(order, Random([1 .. NrSmallAntimagmas(order)]));
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
                                    table -> MagmaByMultiplicationTable(
                                        __SmallAntimagmaHelper.MultiplicationTableReverse(table)))));
        elif IsInt(order) then
            return List(__SmallAntimagmaHelper.getAllSmallAntimagmaMetadata(order)(),
                                    table -> MagmaByMultiplicationTable(
                                        __SmallAntimagmaHelper.MultiplicationTableReverse(table)));
        fi;
end);
