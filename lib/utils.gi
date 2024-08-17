InstallGlobalFunction(GeneratePossibleDiagonals,
    function(n)
        return Filtered(Tuples([1 .. n], n), t -> ForAll([1 .. n], i -> t[i] <> i));
end);