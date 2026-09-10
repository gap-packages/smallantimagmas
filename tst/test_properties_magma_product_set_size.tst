gap> START_TEST("test_properties_magma_product_set_size.tst");

gap> List(AllSmallAntimagmas(2), M -> ProductSetSize(M));
[ 2 ]

gap> List(AllSmallAntimagmas(3), M -> ProductSetSize(M));
[ 2, 3, 3, 3, 3 ]

gap> Collected(List(AllSmallAntimagmas(4), M -> ProductSetSize(M)));
[ [ 2, 2 ], [ 3, 146 ], [ 4, 8743 ] ]

gap> ForAll(AllSmallAntimagmas([2 .. 4]), M -> ProductSetSize(M) >= SquaresIndex(M));
true

gap> ProductSetSize(CyclicGroup(4));
4

gap> STOP_TEST("test_properties_magma_product_set_size.tst");
