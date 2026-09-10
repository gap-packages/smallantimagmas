gap> START_TEST("test_properties_magma_congruences.tst");

## CongruencesOfMagma(M) over orders 2 and 3
gap> List(AllSmallAntimagmas([2 .. 3]), CongruencesOfMagma);
[ [ [ [ m1 ], [ m2 ] ], [ [ m1, m2 ] ] ],
  [ [ [ m1 ], [ m2 ], [ m3 ] ], [ [ m1 ], [ m2, m3 ] ], [ [ m1, m2 ], [ m3 ] ],
      [ [ m1, m2, m3 ] ] ],
  [ [ [ m1 ], [ m2 ], [ m3 ] ], [ [ m1 ], [ m2, m3 ] ], [ [ m1, m2, m3 ] ] ],
  [ [ [ m1 ], [ m2 ], [ m3 ] ], [ [ m1 ], [ m2, m3 ] ], [ [ m1, m2, m3 ] ] ],
  [ [ [ m1 ], [ m2 ], [ m3 ] ], [ [ m1 ], [ m2, m3 ] ], [ [ m1, m2, m3 ] ] ],
  [ [ [ m1 ], [ m2 ], [ m3 ] ], [ [ m1, m2, m3 ] ] ] ]

## the finest and the coarsest partition are always congruences
gap> ForAll(AllSmallAntimagmas([2 .. 4]), M -> IsSubset(CongruencesOfMagma(M),
>        [List(Elements(M), m -> [m]), [Elements(M)]]));
true

## a partition is listed exactly when the congruence its blocks generate is itself, checked by
## MagmaCongruenceByGeneratingPairs from the GAP library
gap> Generated := function(M, P)
>        local pairs, C;
>        pairs := Concatenation(List(P, block -> List([2 .. Size(block)], i -> [block[1], block[i]])));
>        C := MagmaCongruenceByGeneratingPairs(M, pairs);
>        return Set(Concatenation(EquivalenceRelationPartition(C),
>            List(Filtered(Elements(M), m -> ForAll(EquivalenceRelationPartition(C), block -> not m in block)), m -> [m])));
> end;;
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> ForAll(PartitionsSet(Elements(M)),
>        P -> (Generated(M, P) = Set(P)) = (Set(P) in CongruencesOfMagma(M))));
true

## NrCongruences(M) = Size(CongruencesOfMagma(M))
gap> ForAll(AllSmallAntimagmas([2 .. 4]), M -> NrCongruences(M) = Size(CongruencesOfMagma(M)));
true

## NrCongruences(G) is the number of normal subgroups of G
#@if IsPackageMarkedForLoading( "smallgrp", "" )
gap> ForAll(AllSmallGroups([1 .. 8]), G -> NrCongruences(G) = Size(NormalSubgroups(G)));
true
#@fi

## CongruencesOfMagma(M) = CongruencesOfMagma(TransposedMagma(M)), compared by the positions of the elements
gap> ByPositions := M -> List(CongruencesOfMagma(M), P -> List(P, block -> List(block, m -> Position(Elements(M), m))));;
gap> ForAll(AllSmallAntimagmas([2 .. 4]), M -> ByPositions(M) = ByPositions(TransposedMagma(M)));
true

## NrCongruences is invariant under relabelling
gap> Relabelled := function(M, p)
>        local T;
>        T := MultiplicationTable(M);
>        return MagmaByMultiplicationTable(List([1 .. Size(M)], i -> List([1 .. Size(M)], j -> T[i / p][j / p] ^ p)));
> end;;
gap> ForAll(AllSmallAntimagmas(4), M -> ForAll(SymmetricGroup(4), p -> NrCongruences(Relabelled(M, p)) = NrCongruences(M)));
true

## IsCongruenceFree(M) if and only if NrCongruences(M) = 2
gap> ForAll(AllSmallAntimagmas([2 .. 4]), M -> IsCongruenceFree(M) = (NrCongruences(M) = 2));
true

## Collected(List(Ms, NrCongruences)) over order 4 up to isomorphism
gap> Ms := AllSmallAntimagmas(4, "up-to-isomorphism");;
gap> Collected(List(Ms, NrCongruences));
[ [ 2, 997 ], [ 3, 15664 ], [ 4, 819 ], [ 5, 262 ], [ 6, 30 ], [ 7, 4 ], [ 9, 2 ], [ 10, 2 ] ]
gap> Number(Ms, IsCongruenceFree);
997

## every congruence-free magma of order 4 is neither deranged nor op-deranged
gap> ForAll(Filtered(Ms, IsCongruenceFree), M -> not IsLeftDerangementInducted(M) and not IsRightDerangementInducted(M));
true

gap> STOP_TEST("test_properties_magma_congruences.tst");
