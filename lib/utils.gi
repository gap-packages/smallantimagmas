InstallGlobalFunction(AllSubmagmas,
    function(M)
        local result, c, T;
        result := [];
        for c in Combinations(GeneratorsOfMagma(M)) do
            T := Submagma(M, c);
            if not ForAny(result, N -> IsMagmaIsomorphic(N, T)) and Size(T) > 0 then
                Add(result, T);
            fi;
        od;
        return result;
end);

InstallGlobalFunction(AssociativityIndex,
    function(M)
        return Size(Filtered(Tuples(M, 3), t -> (t[1] * t[2]) * t[3] = t[1] * (t[2] * t[3])));
end);

InstallGlobalFunction(IsAntiassociative,
    function(M)
        return ForAll(Tuples(M, 3), m -> ( m[1] * m[2] ) * m[3] <> m[1] * ( m[2] * m[3] ) );
end);

InstallGlobalFunction(TransposedMagma,
    function(M)
        return MagmaByMultiplicationTable(TransposedMat(MultiplicationTable(M)));
end);

InstallGlobalFunction(MagmaIsomorphism,
    function(M, N)
        local psi, n, p, m, elms;
        if Size(M) <> Size(N) then
            return fail;
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
            return fail;
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

InstallGlobalFunction(IsLeftCancellative,
    function(M)
        return ForAll( Filtered( Tuples(M, 3), m -> m[3] * m[1] = m[3] * m[2] ), m -> m[1] = m[2] );
end);

InstallGlobalFunction(IsRightCancellative,
    function(M)
        return ForAll( Filtered( Tuples(M, 3), m -> m[1] * m[3] = m[2] * m[3] ), m -> m[1] = m[2] );
end);

InstallGlobalFunction(IsCancellative,
    function(M)
        return IsRightCancellative(M) and IsLeftCancellative(M);
end);

InstallGlobalFunction(IsDepartitionedOfCode,
    function(M, partition, deragment)
        return ForAll([1..Size(partition)], i -> IsSubset( Permuted(partition, deragment)[i], Unique(Flat(List(partition[i], m -> m*Elements(M)))) ));
end);

InstallGlobalFunction(DepartitionOfCode,
    function(M, code)
    local p, d, partitions, partition_deragments;

    partitions := PartitionsSet(Elements(M), Sum(code));

    for p in partitions do
        partition_deragments := List(Derangements(p), d -> PermListList(p, d));

        ## Filtered deragments of partition that matches the code of departition
        partition_deragments := Filtered(partition_deragments, u -> ForAll(Collected(code), r -> IsBound(CycleStructurePerm(u)[r[1] - 1]) ));
        partition_deragments := Filtered(partition_deragments, u -> ForAll(Collected(code), r -> CycleStructurePerm(u)[r[1] - 1] = r[2] ));

        for d in partition_deragments do
            if IsDepartitionedOfCode(M, p, d) then
                return [p, d];
            fi;
        od;
    od;
    return fail;
end);

InstallGlobalFunction(DepartitionCodes,
    function(M)
        local k, available_codes;

        available_codes := [];
        for k in [1..Size(M)] do
            Append(available_codes, Filtered(Tuples([2..Size(M)], k), t -> Sum(t) <= Size(M)));
        od;

        #available_codes := Filtered(available_codes, c -> DepartitionOfCode(M, c))[1];
        return available_codes;
end);

InstallGlobalFunction(IsDepartitioned,
    function(M)
        return Size( DepartitionCodes(M) ) > 0;
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
