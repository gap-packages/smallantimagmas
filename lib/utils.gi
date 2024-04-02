InstallGlobalFunction(IsAntiassociative,
    function(M)
        local x;
        for x in IteratorOfTuples(M, 3) do
            if ( x[1] * ( x[2] * x[3] ) ) = ( ( x[1] * x[2] ) * x[3] ) then
                return false;
            fi;
        od;
        return true;
end);

InstallGlobalFunction(MagmaIsomorphism,
    function(M, N)
        local psi, n, p, m, elms;
        if Size(M) <> Size(N) then
            return false;
        fi;

        n := Size(M);
        m := Elements(M);

        for p in PermutationsList(Elements(N)) do
            elms := List([ 1 .. n ], i -> Tuple( [ m[i], p[i] ] ) );

            psi := GeneralMappingByElements( M, N, elms);

            if ForAll(Tuples(m, 2), t -> psi(t[1] * t[2]) = psi(t[1]) * psi(t[2])) then
                return psi;
            fi;
        od;
        return fail;
end);

InstallGlobalFunction(MagmaAntiisomorphism,
    function(M, N)
        local psi, n, p, m, elms;

        if Size(M) <> Size(N) then
            return false;
        fi;

        n := Size(M);
        m := Elements(M);

        for p in PermutationsList(Elements(N)) do
            elms := List([ 1 .. n ], i -> Tuple( [ m[i], p[i] ] ) );
            psi := GeneralMappingByElements( M, N, elms);

            if ForAll(Tuples(m, 2), t -> psi(t[1] * t[2]) = psi(t[2]) * psi(t[1])) then
                return psi;
            fi;
        od;
        return fail;
end);

InstallGlobalFunction(IsMagmaIsomorphic,
    function(M, N)
        if MagmaIsomorphism(M, N) <> fail then
            return true;
        fi;
        return false;
end);

InstallGlobalFunction(IsMagmaAntiisomorphic,
    function(M, N)
        if MagmaAntiisomorphism(M, N) <> fail then
            return true;
        fi;
        return false;
end);

InstallGlobalFunction(HasPropertyA3,
    function(M)
        local partitions, s, p, ns, rows_cartesian, bool_across_values;
        ns := GeneratorsOfMagma(M);
        for s in [ 2 .. Size(M) ] do
            partitions := PartitionsSet(ns, s);
            for p in partitions do
                rows_cartesian := List(p, p_i -> [ p_i, Set( Flat( List( p_i, p_x -> List( ns, x -> x * p_x ) ) ) ) ]);
                bool_across_partitions := ForAll(rows_cartesian, r -> IsEmpty(Intersection(r[1], r[2])));
                bool_across_values := ForAll(Combinations(List(rows_cartesian, r -> r[2]), 2), c -> IsEmpty(Intersection(c)));

                if bool_across_values and bool_across_values then
                    return true;
                fi;
            od;
        od;
        return false;
end);
