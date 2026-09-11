InstallGlobalFunction(NrSmallAntimagmas,
    function(arg...)
        local orders, view;
        orders := __SmallAntimagmaHelper.checkOrders(First(arg));
        view := __SmallAntimagmaHelper.checkView(arg{[2 .. Size(arg)]});
        return Sum(orders, view.nr);
end);

InstallGlobalFunction(SmallAntimagma,
    function(arg...)
        local order, id;
        if Length(arg) = 1 and IsList(arg[1]) and Length(arg[1]) = 2 and ForAll(arg[1], IsInt) then
            order := arg[1][1];
            id := arg[1][2];
        elif Length(arg) = 2 and ForAll(arg, IsInt) then
            order := arg[1];
            id := arg[2];
        else
            Error("SmallAntimagma: expected (n, i) or [n, i]");
        fi;
        __SmallAntimagmaHelper.checkOrderId(order, id);
        return MagmaByMultiplicationTable(
            __SmallAntimagmaHelper.MultiplicationTableReverse(__SmallAntimagmaHelper.TableAt(order, id)));
end);

InstallGlobalFunction(AllSmallAntimagmas,
    function(arg...)
        local orders, view;
        orders := __SmallAntimagmaHelper.checkOrders(First(arg));
        view := __SmallAntimagmaHelper.checkView(arg{[2 .. Size(arg)]});
        return Concatenation(List(orders, view.all));
end);

InstallMethod(IdSmallAntimagma, "for a magma", [IsMagma],
    function(M)
        local n;
        n := Size(M);
        return [n, First(Filtered([1 .. NrSmallAntimagmas(n)],
            index -> IsMagmaIsomorphic(M, SmallAntimagma(n, index)) or IsMagmaAntiisomorphic(M, SmallAntimagma(n, index))))];
end);

InstallGlobalFunction(OneSmallAntimagma,
    function(order)
        return SmallAntimagma(order, Random([1 .. NrSmallAntimagmas(order)]));
end);
