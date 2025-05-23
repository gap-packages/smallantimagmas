InstallGlobalFunction(AntimagmaGeneratorPossibleDiagonals,
    function(n)
        return Filtered(Tuples([1 .. n], n), t -> ForAll([1 .. n], i -> t[i] <> i));
end);

InstallGlobalFunction(UpToIsomorphism,
    function(Ms)
        local result, m;
        result := [];

        while not IsEmpty(Ms) do
            m := First(Ms);
            Add(result, m);
            Ms := Filtered(Ms, n -> IsMagmaIsomorphic(m, n) = false);
        od;
        return result;
end);
