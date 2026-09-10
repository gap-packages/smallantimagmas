gap> START_TEST("test_properties_magma_cancellativity_degree.tst");

## a group has every translation injective
#@if IsPackageMarkedForLoading( "smallgrp", "" )
gap> ForAll(AllSmallGroups([2 .. 4]), G -> CancellativityDegree(G) = [Size(G), Size(G)]);
true
#@fi

gap> CancellativityDegree(SmallAntimagma(2, 1));
[ 2, 0 ]

gap> CancellativityDegree(SmallAntimagma(3, 5));
[ 0, 3 ]

gap> List(AllSmallAntimagmas(3), M -> CancellativityDegree(M));
[ [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 3 ] ]

## the degree counts the elements whose left, resp. right, translation is onto
gap> ForAll(AllSmallAntimagmas([2 .. 4]),
>        M -> CancellativityDegree(M) = [Number(M, z -> Set(M, x -> z * x) = Elements(M)),
>                                        Number(M, z -> Set(M, x -> x * z) = Elements(M))]);
true

## transposing the magma swaps the two entries
gap> ForAll(AllSmallAntimagmas([2 .. 4]),
>        M -> CancellativityDegree(TransposedMagma(M)) = Reversed(CancellativityDegree(M)));
true

## a full count on one side is exactly cancellativity on that side
gap> ForAll(AllSmallAntimagmas([2 .. 4], "up-to-isomorphism"),
>        M -> (CancellativityDegree(M)[1] = Size(M)) = IsLeftCancellative(M)
>             and (CancellativityDegree(M)[2] = Size(M)) = IsRightCancellative(M));
true

## the degrees that occur among antimagmas of order 4
gap> Collected(List(AllSmallAntimagmas(4, "up-to-isomorphism"), CancellativityDegree));
[ [ [ 0, 0 ], 5906 ], [ [ 0, 1 ], 3665 ], [ [ 0, 2 ], 1839 ],
  [ [ 0, 3 ], 392 ], [ [ 0, 4 ], 40 ], [ [ 1, 0 ], 3665 ], [ [ 1, 1 ], 2 ],
  [ [ 2, 0 ], 1839 ], [ [ 3, 0 ], 392 ], [ [ 4, 0 ], 40 ] ]

gap> STOP_TEST("test_properties_magma_cancellativity_degree.tst");
