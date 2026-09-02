gap> START_TEST("test_properties_magma_distributive_submagmas.tst");

## IsLeftDistributive(M) over orders 2 and 3
gap> Collected(List(AllSmallAntimagmas([2 .. 3]), M -> IsLeftDistributive(M)));
[ [ true, 2 ], [ false, 4 ] ]

## IsRightDistributive(M) over orders 2 and 3
gap> Collected(List(AllSmallAntimagmas([2 .. 3]), M -> IsRightDistributive(M)));
[ [ true, 1 ], [ false, 5 ] ]

## IsLeftDistributive(M) = IsRightDistributive(TransposedMagma(M))
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> IsLeftDistributive(M) = IsRightDistributive(TransposedMagma(M)));
true

## Size(N) for N in AllSubmagmas(M), orders 2 and 3
gap> List(AllSmallAntimagmas([2 .. 3]), M -> List(AllSubmagmas(M), N -> Size(N)));
[ [ 2 ], [ 2, 3 ], [ 2, 3 ], [ 3 ], [ 3 ], [ 3 ] ]

## IsSubset(Elements(M), Elements(N)) for N in AllSubmagmas(M)
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> ForAll(AllSubmagmas(M), N -> IsSubset(Elements(M), Elements(N))));
true

## AllSubmagmas(M) is pairwise non-isomorphic
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> ForAll(Combinations([1 .. Size(AllSubmagmas(M))], 2),
>        c -> not IsMagmaIsomorphic(AllSubmagmas(M)[c[1]], AllSubmagmas(M)[c[2]])));
true

gap> STOP_TEST("test_properties_magma_distributive_submagmas.tst");
