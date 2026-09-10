gap> START_TEST("test_properties_magma_mediality_index.tst");

## a medial magma satisfies the law on all |M|^4 quadruples
#@if IsPackageMarkedForLoading( "smallgrp", "" )
gap> ForAll(Filtered(AllSmallGroups([2 .. 12]), IsAbelian), G -> MedialityIndex(G) = Size(G) ^ 4);
true
gap> ForAll(Filtered(AllSmallGroups([2 .. 12]), G -> not IsAbelian(G)), G -> MedialityIndex(G) < Size(G) ^ 4);
true
#@fi

## the index agrees with a direct count over quadruples
gap> Direct := M -> Number(EnumeratorOfTuples(M, 4),
>     t -> (t[1] * t[2]) * (t[3] * t[4]) = (t[1] * t[3]) * (t[2] * t[4]));;
gap> ForAll(AllSmallAntimagmas([2 .. 3], "up-to-isomorphism"), M -> MedialityIndex(M) = Direct(M));
true

## the index is invariant under transposition
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> MedialityIndex(M) = MedialityIndex(TransposedMagma(M)));
true

gap> Collected(List(AllSmallAntimagmas([2 .. 3], "up-to-isomorphism"), MedialityIndex));
[ [ 16, 2 ], [ 57, 2 ], [ 65, 2 ], [ 73, 2 ], [ 81, 4 ] ]

gap> STOP_TEST("test_properties_magma_mediality_index.tst");
