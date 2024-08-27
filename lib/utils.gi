InstallGlobalFunction(AntimagmaMultiplicationTableConvert,
    function(M)
        local nrows;
        nrows := NrRows(MultiplicationTable(M));
        return List(MultiplicationTable(M), row -> Position( EnumeratorOfTuples([1 .. nrows], nrows), row ) );
end);

InstallGlobalFunction(AntimagmaMultiplicationTableReverse,
    function(T)
        local ncols;
        ncols := Size(T);
        return List(T, col -> EnumeratorOfTuples([1 .. ncols], ncols)[col] );
end);

InstallGlobalFunction(AntimagmaGeneratorPossibleDiagonals,
    function(n)
        return Filtered(Tuples([1 .. n], n), t -> ForAll([1 .. n], i -> t[i] <> i));
end);

InstallGlobalFunction(AntimagmaGeneratorFilterNonIsomorphicMagmas,
    function(magmas)
        local result, m;
        result := [];

        while not IsEmpty(magmas) do
            m := First(magmas);
            Add(result, m);
            magmas := Filtered(magmas, n -> IsMagmaIsomorphic(m, n) = false);
        od;
        return result;
end);