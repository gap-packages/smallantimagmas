InstallGlobalFunction(GeneratorPossibleDiagonals,
    function(n)
        return Filtered(Tuples([1 .. n], n), t -> ForAll([1 .. n], i -> t[i] <> i));
end);

InstallGlobalFunction(GeneratorFilterNonIsomorphicMagmas,
    function(magmas)
        local result;
        result := [];

        while not IsEmpty(magmas) do
            Add(result, First(magmas));
            magmas := Filtered(magmas, m -> IsMagmaIsomorphic(First(magmas), m) = false);
        od;
        return result;
end);