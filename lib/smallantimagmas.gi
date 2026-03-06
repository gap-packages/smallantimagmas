InstallGlobalFunction(NrSmallAntimagmas,
    function(order)
    return __SmallAntimagmaHelper.getSmallAntimagmaMetadataIndex(order).size;
end);

InstallGlobalFunction(SmallAntimagma,
    function(order, id)
        return MagmaByMultiplicationTable(
            __SmallAntimagmaHelper.MultiplicationTableDecode(
                __SmallAntimagmaHelper.EliasFanoIndexListGet(
                    __SmallAntimagmaHelper.getSmallAntimagmaMetadataIndex(
                        order), id),
                order));
end);

InstallGlobalFunction(AllSmallAntimagmas,
    function(order)
        if IsList(order) and ForAll(order, o -> IsInt(o)) then
            return Flat(
                List(order, o -> List(
                    __SmallAntimagmaHelper.EliasFanoIndexListDecode(
                        __SmallAntimagmaHelper
                            .getSmallAntimagmaMetadataIndex(o)),
                    table -> MagmaByMultiplicationTable(
                        __SmallAntimagmaHelper
                            .MultiplicationTableDecode(
                                table, o)))));
        elif IsInt(order) then
            return List(
                __SmallAntimagmaHelper.EliasFanoIndexListDecode(
                    __SmallAntimagmaHelper
                        .getSmallAntimagmaMetadataIndex(order)),
                table -> MagmaByMultiplicationTable(
                    __SmallAntimagmaHelper
                        .MultiplicationTableDecode(
                            table, order)));
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
        return __SmallAntimagmaHelper
            .getAllSmallAntimagmaMetadataIndex(order).size;
end);

InstallGlobalFunction(ReallyAllSmallAntimagmas,
    function(order)
        if IsList(order) and ForAll(order, o -> IsInt(o)) then
            return Flat(
                List(order, o -> List(
                    __SmallAntimagmaHelper.EliasFanoIndexListDecode(
                        __SmallAntimagmaHelper
                            .getAllSmallAntimagmaMetadataIndex(o)),
                    table -> MagmaByMultiplicationTable(
                        __SmallAntimagmaHelper
                            .MultiplicationTableDecode(
                                table, o)))));
        elif IsInt(order) then
            return List(
                __SmallAntimagmaHelper.EliasFanoIndexListDecode(
                    __SmallAntimagmaHelper
                        .getAllSmallAntimagmaMetadataIndex(order)),
                table -> MagmaByMultiplicationTable(
                    __SmallAntimagmaHelper
                        .MultiplicationTableDecode(
                            table, order)));
        fi;
end);