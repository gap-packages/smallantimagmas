gap> START_TEST("tst_properties_transposed_magma.tst");

## the transpose of a catalogued antimagma is the transposed table
gap> ForAll(AllSmallAntimagmas([2 .. 4]),
>        M -> MultiplicationTable(TransposedMagma(M)) = TransposedMat(MultiplicationTable(M)));
true
gap> ForAll(AllSmallAntimagmas([2 .. 4]),
>        M -> MultiplicationTable(TransposedMagma(TransposedMagma(M))) = MultiplicationTable(M));
true
gap> ForAll(AllSmallAntimagmas([2 .. 4]), M -> Size(TransposedMagma(M)) = Size(M));
true

## a magma and its transpose are antiisomorphic, and not isomorphic below order 4
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> IsMagmaAntiisomorphic(M, TransposedMagma(M)));
true
gap> ForAny(AllSmallAntimagmas([2 .. 3]), M -> IsMagmaIsomorphic(M, TransposedMagma(M)));
false
gap> ForAll(AllSmallAntimagmas(4, "self-dual"), M -> IsMagmaIsomorphic(M, TransposedMagma(M)));
true

## transposing twice gives back the magma
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> IsMagmaIsomorphic(M, TransposedMagma(TransposedMagma(M))));
true

## the transpose of an antimagma is an antimagma
gap> ForAll(AllSmallAntimagmas([2 .. 4]), M -> IsAntiassociative(TransposedMagma(M)));
true

## left-handed properties become right-handed ones
gap> ForAll(AllSmallAntimagmas([2 .. 4]), function(M)
>        local N;
>        N := TransposedMagma(M);
>        return IsLeftCancellative(N) = IsRightCancellative(M)
>           and IsRightCancellative(N) = IsLeftCancellative(M)
>           and IsLeftDistributive(N) = IsRightDistributive(M)
>           and IsRightDistributive(N) = IsLeftDistributive(M)
>           and IsLeftCyclic(N) = IsRightCyclic(M)
>           and IsRightCyclic(N) = IsLeftCyclic(M)
>           and IsLeftAlternative(N) = IsRightAlternative(M)
>           and IsRightAlternative(N) = IsLeftAlternative(M)
>           and IsLeftFPFInducted(N) = IsRightFPFInducted(M)
>           and IsRightFPFInducted(N) = IsLeftFPFInducted(M)
>           and IsLeftDerangementInducted(N) = IsRightDerangementInducted(M)
>           and IsRightDerangementInducted(N) = IsLeftDerangementInducted(M);
>    end);
true

## two-sided invariants are unchanged by transposing
gap> ForAll(AllSmallAntimagmas([2 .. 4]), function(M)
>        local N;
>        N := TransposedMagma(M);
>        return DiagonalOfMultiplicationTable(N) = DiagonalOfMultiplicationTable(M)
>           and CommutativityIndex(N) = CommutativityIndex(M)
>           and AnticommutativityIndex(N) = AnticommutativityIndex(M)
>           and AssociativityIndex(N) = AssociativityIndex(M)
>           and ProductSetSize(N) = ProductSetSize(M)
>           and Rank(N) = Rank(M);
>    end);
true

## magmas outside the catalogue are transposed as well
gap> MultiplicationTable(TransposedMagma(CyclicGroup(4))) = MultiplicationTable(CyclicGroup(4));
true
gap> IsMagmaIsomorphic(CyclicGroup(4), TransposedMagma(CyclicGroup(4)));
true

gap> STOP_TEST("tst_properties_transposed_magma.tst");
