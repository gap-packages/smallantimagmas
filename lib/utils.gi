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

InstallGlobalFunction(TransposedMagma,
    function(M)
        return MagmaByMultiplicationTable(TransposedMat(MultiplicationTable(M)));
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

InstallGlobalFunction(LeftPower,
    function(m, k)
        local result;

        if (not IsInt(k)) or (k < 1) then
            Error("SmallAntimagmas: ", "<id> must be an integer");
        fi;

        result := m;
        while k > 1 do
            result := m * result;
            k := k - 1;
        od;
        return result;
end);

InstallGlobalFunction(RightPower,
    function(m, k)
        local result;

        if (not IsInt(k)) or (k < 1) then
            Error("SmallAntimagmas: ", "<id> must be an integer");
        fi;

        result := m;
        while k > 1 do
            result := result * m;
            k := k - 1;
        od;
        return result;
end);

InstallGlobalFunction(LeftOrder,
    function(m)
        local temporary, next;
        temporary := [ m * m ];

        next := m * Last(temporary);
        while not (next in temporary) do
            Add(temporary, next);
            next := m * Last(temporary);
        od;

        if m = Last(temporary) then
            return Size(temporary);
        fi;
        return infinity;
end);

InstallGlobalFunction(RightOrder,
    function(m)
        local temporary, next;
        temporary := [ m * m ];

        next := Last(temporary) * m;
        while not (next in temporary) do
            Add(temporary, next);
            next := Last(temporary) * m;
        od;

        if m = Last(temporary) then
            return Size(temporary);
        fi;
        return infinity;
end);

InstallGlobalFunction(IsLeftCyclic,
    function(M)
        return ForAny(List(M), m -> LeftOrder(m) = Size(M));
end);

InstallGlobalFunction(IsRightCyclic,
    function(M)
        return ForAny(List(M), m -> RightOrder(m) = Size(M));
end);

InstallGlobalFunction(IsRightCancellative,
    function(M)
        return ForAll( Filtered( Tuples(M, 3), m -> m[1] * m[3] = m[2] * m[3] ), m -> m[1] = m[2] );
end);

InstallGlobalFunction(IsLeftCancellative,
    function(M)
        return ForAll( Filtered( Tuples(M, 3), m -> m[3] * m[1] = m[3] * m[2] ), m -> m[1] = m[2] );
end);

InstallGlobalFunction(IsCancellative,
    function(M)
        return IsRightCancellative(M) and IsLeftCancellative(M);
end);

InstallGlobalFunction(HasPropertyA3,
    function(M)
        local partitions, s, p, ns, rows_cartesian, bool_across_values, bool_across_partitions;
        ns := GeneratorsOfMagma(M);
        for s in [ 2 .. Size(M) ] do
            partitions := PartitionsSet(ns, s);
            for p in partitions do
                rows_cartesian := List(p, p_i -> [ p_i, Set( Flat( List( p_i, p_x -> List( ns, x -> x * p_x ) ) ) ) ]);
                bool_across_partitions := ForAll(rows_cartesian, r -> IsEmpty(Intersection(r[1], r[2])));
                bool_across_values := ForAll(Combinations(List(rows_cartesian, r -> r[2]), 2), c -> IsEmpty(Intersection(c)));

                if bool_across_values and bool_across_partitions then
                    return true;
                fi;
            od;
        od;
        return false;
end);
