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

InstallMethod(DiagonalOfMultiplicationTable, "for a magma", [IsMagma],
    function(M)
        return DiagonalOfMatrix(MultiplicationTable(M));
end);

InstallMethod(AssociativityIndex, "for a magma", [IsMagma],
    function(M)
        return Size(Filtered(EnumeratorOfTuples(M, 3), t -> (t[1] * t[2]) * t[3] = t[1] * (t[2] * t[3])));
end);

InstallMethod(CommutativityIndex, "for a magma", [IsMagma],
    function(M)
        return Size(Filtered(Combinations(Elements(M), 2), m -> m[1] * m[2] = m[2] * m[1]));
end);

InstallMethod(AnticommutativityIndex, "for a magma", [IsMagma],
    function(M)
        return ((Binomial(Size(M), 2)) - CommutativityIndex(M));
end);

InstallMethod(SquaresIndex, "for a magma", [IsMagma],
    function(M)
        return Size(Set(M, m -> m ^ 2));
end);

InstallMethod(IsAntiassociative, "for a magma", [IsMagma],
    function(M)
        local x;
        for x in IteratorOfTuples(M, 3) do
            if (x[1] * (x[2] * x[3])) = ((x[1] * x[2]) * x[3]) then
                return false;
            fi;
        od;
        return true;
end);

InstallGlobalFunction(TransposedMagma,
    function(M)
        return MagmaByMultiplicationTable(TransposedMat(MultiplicationTable(M)));
end);

InstallGlobalFunction(MagmaIsomorphismInvariantsMatch,
    function(M, N)
        local invariants, leftIndexPeriods, rightIndexPeriods;
        if IsIsomorphicDigraph(DigraphOfDiagonal(M), DigraphOfDiagonal(N)) = false then
            return false;
        fi;

        leftIndexPeriods := K -> Collected(List(K, m -> LeftIndexPeriod(m)));
        rightIndexPeriods := K -> Collected(List(K, m -> RightIndexPeriod(m)));

        invariants := [
            Size,
            IsLeftCancellative,
            IsRightCancellative,
            IsLeftDistributive,
            IsRightDistributive,
            IsLeftFPFInducted,
            IsRightFPFInducted,
            CommutativityIndex,
            AnticommutativityIndex,
            SquaresIndex,
            leftIndexPeriods,
            rightIndexPeriods,
            IsLeftCyclic,
            IsRightCyclic];
        return ForAll(invariants, f -> f(M) = f(N));
end);

InstallMethod(MagmaIsomorphism, "for two magmas", true, [IsMagma, IsMagma], 0,
    function(M, N)
        local psi, n, p, m, ns, elms;

        if not MagmaIsomorphismInvariantsMatch(M, N) then
            return fail;
        fi;

        n := Size(M);
        m := Elements(M);
        ns := Elements(N);

        for p in SymmetricGroup(n) do
            elms := List([1 .. n], i -> DirectProductElement([m[i], ns[i ^ p]]));

            psi := GeneralMappingByElements(M, N, elms);

            if RespectsMultiplication(psi) then
                return psi;
            fi;
        od;
        return fail;
end);

InstallMethod(MagmaAntiisomorphism, "for two magmas", true, [IsMagma, IsMagma], 0,
    function(M, N)
        local psi, n, p, m, ns, elms;

        if Size(M) <> Size(N) then
            return fail;
        fi;

        n := Size(M);
        m := Elements(M);
        ns := Elements(N);

        for p in SymmetricGroup(n) do
            elms := List([1 .. n], i -> DirectProductElement([m[i], ns[i ^ p]]));
            psi := GeneralMappingByElements(M, N, elms);

            if ForAll(EnumeratorOfTuples(m, 2), t -> psi(t[1] * t[2]) = psi(t[2]) * psi(t[1])) then
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

InstallMethod(LeftIndexPeriod, "for a left-multiplicable element", [IsExtLElement],
    function(m)
        local temporary, next, index;
        temporary := [m];

        next := m * Last(temporary);
        while not (next in temporary) do
            Add(temporary, next);
            next := m * Last(temporary);
        od;

        index := Position(temporary, next);
        return [index, Size(temporary) - index + 1];
end);

InstallMethod(RightIndexPeriod, "for a right-multiplicable element", [IsExtRElement],
    function(m)
        local temporary, next, index;
        temporary := [m];

        next := Last(temporary) * m;
        while not (next in temporary) do
            Add(temporary, next);
            next := Last(temporary) * m;
        od;

        index := Position(temporary, next);
        return [index, Size(temporary) - index + 1];
end);

InstallMethod(IsLeftCyclic, "for a magma", [IsMagma],
    function(M)
        return ForAny(List(M), m -> LeftIndexPeriod(m) = [1, Size(M)]);
end);

InstallMethod(IsRightCyclic, "for a magma", [IsMagma],
    function(M)
        return ForAny(List(M), m -> RightIndexPeriod(m) = [1, Size(M)]);
end);

InstallMethod(IsLeftCancellative, "for a magma", [IsMagma],
    function(M)
        return ForAll(Filtered(EnumeratorOfTuples(M, 3), m -> m[3] * m[1] = m[3] * m[2]), m -> m[1] = m[2]);
end);

InstallMethod(IsRightCancellative, "for a magma", [IsMagma],
    function(M)
        return IsLeftCancellative(TransposedMagma(M));
end);

InstallMethod(IsLeftDistributive, "for a magma", [IsMagma],
    function(M)
        return ForAll(EnumeratorOfTuples(M, 3), m -> m[1] * (m[2] * m[3]) = (m[1] * m[2]) * (m[1] * m[3]));
end);

InstallMethod(IsRightDistributive, "for a magma", [IsMagma],
    function(M)
        return IsLeftDistributive(TransposedMagma(M));
end);

InstallMethod(IsCancellative, "for a magma", [IsMagma],
    function(M)
        return IsLeftCancellative(M) and IsRightCancellative(M);
end);

InstallMethod(IsLeftFPFInducted, "for a magma", [IsMagma],
    function(M)
        return ForAll(M, m -> Size(Unique(m * Elements(M))) = 1 and First(Unique(m * Elements(M))) <> m);
end);

InstallMethod(IsRightFPFInducted, "for a magma", [IsMagma],
    function(M)
        return IsLeftFPFInducted(TransposedMagma(M));
end);

InstallMethod(IsLeftDerangementInducted, "for a magma", [IsMagma],
    function(M)
        local closureCycles, admissiblePairs, candidateBlocks,
              elements, cycles, pair, cand;

        # permutation closure of the diagonal endofunction f(x) = x * x:
        # iterate f until the image stabilises, then return the cycles of
        # the induced permutation of the fibers, each cycle a list of
        # blocks of magma elements in cyclic order
        closureCycles := function(elts)
            local fk, labels, perm;
            fk := elts;
            while Size(Set(List(fk, y -> y * y))) < Size(Set(fk)) do
                fk := List(fk, y -> y * y);
            od;
            labels := Set(fk);
            perm := PermList(List(labels, v -> Position(labels, v * v)));
            return List(Cycles(perm, [1 .. Length(labels)]),
                c -> List(c, pos -> Set(elts{Positions(fk, labels[pos])})));
        end;

        # admissible pairs (alpha, beta) for the given cycle lengths:
        # alpha picks a prime divisor of each cycle length, beta picks
        # a shift in [0 .. p - 1] for every repeated prime
        admissiblePairs := function(lengths)
            local result, alpha, primes, betaChoices, beta;
            result := [];
            for alpha in Cartesian(List(lengths, PrimeDivisors)) do
                primes := Set(alpha);
                betaChoices := List(primes, p -> Cartesian(Concatenation(
                    [[0]],
                    List([2 .. Number(alpha, q -> q = p)],
                        t -> [0 .. p - 1]))));
                for beta in Cartesian(betaChoices) do
                    Add(result,
                        rec(alpha := alpha, primes := primes, beta := beta));
                od;
            od;
            return result;
        end;

        # maximal element of the closure poset determined by an
        # admissible pair: blocks of the induced partition together with
        # the index of the image block under the induced derangement
        candidateBlocks := function(cycs, chosen)
            local blocks, img, k, p, cycleIdxs, offset, j, t, c, b, Z;
            blocks := [];
            img := [];
            for k in [1 .. Length(chosen.primes)] do
                p := chosen.primes[k];
                cycleIdxs := Positions(chosen.alpha, p);
                offset := Length(blocks);
                for j in [0 .. p - 1] do
                    Z := [];
                    for t in [1 .. Length(cycleIdxs)] do
                        c := cycs[cycleIdxs[t]];
                        b := chosen.beta[k][t];
                        UniteSet(Z, Union(c{Filtered([1 .. Length(c)],
                            s -> s mod p = (b + j + 1) mod p)}));
                    od;
                    Add(blocks, Z);
                    Add(img, offset + ((j + 1) mod p) + 1);
                od;
            od;
            return rec(blocks := blocks, img := img);
        end;

        elements := Elements(M);
        if ForAny(elements, x -> x in Set(x * elements)) then
            return false;
        fi;
        cycles := closureCycles(elements);
        for pair in admissiblePairs(List(cycles, Length)) do
            cand := candidateBlocks(cycles, pair);
            if ForAll([1 .. Length(cand.blocks)], blk ->
                    ForAll(cand.blocks[blk],
                        x -> IsSubset(cand.blocks[cand.img[blk]],
                            Set(x * elements)))) then
                return true;
            fi;
        od;
        return false;
end);

InstallMethod(IsRightDerangementInducted, "for a magma", [IsMagma],
    function(M)
        return IsLeftDerangementInducted(TransposedMagma(M));
end);

InstallMethod(IsLeftAlternative, "for a magma", [IsMagma],
    function(M)
        return ForAll(EnumeratorOfTuples(M, 2), c -> c[1] * (c[1] * c[2]) = (c[1] * c[1]) * c[2]);
end);

InstallMethod(IsRightAlternative, "for a magma", [IsMagma],
    function(M)
        return IsLeftAlternative(TransposedMagma(M));
end);

InstallMethod(DigraphOfDiagonal, "for a magma", [IsMagma],
    function(M)
        return DigraphByEdges(List([1 .. Size(M)], m -> [m, DiagonalOfMultiplicationTable(M)[m]]));
end);