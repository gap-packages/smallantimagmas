InstallMethod(AntimagmaGeneratorPossibleDiagonals, "for possible antiassociative diagonals", [IsPosInt],
    function(n)
        local enum;
        enum := EnumeratorOfTuples([1 .. n], n);
        return Filtered(enum, t -> ForAll([1 .. n], i -> t[i] <> i));
end);

InstallMethod(UpToIsomorphism, "for a list of non-equivalent antimagmas", [IsList],
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
