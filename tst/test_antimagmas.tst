gap> START_TEST("smallantimagmas: test_antimagmas_functions.tst");

gap> IsAntiassociative(MagmaByMultiplicationTable([[2, 1], [2, 1]]));
true

gap> ForAll(AllSmallAntimagmas(2), M -> IsEmpty(Idempotents(M)));
true

gap> ForAll(AllSmallAntimagmas(3), M -> IsEmpty(Idempotents(M)));
true

gap> ForAll(AllSmallAntimagmas(2), M -> IsEmpty(Center(M)));
true

gap> ForAll(AllSmallAntimagmas(3), M -> IsEmpty(Center(M)));
true

gap> ForAll(AllSmallAntimagmas(2), M -> IsAntiassociative(M));
true

gap> ForAll(AllSmallAntimagmas(3), M -> IsAntiassociative(M));
true

gap> Collected(List(ReallyAllSmallAntimagmas(3), M -> IdAntimagma(M)));
[ [ [ 3, 1 ], 6 ], [ [ 3, 2 ], 6 ], [ [ 3, 3 ], 6 ], [ [ 3, 4 ], 6 ], [ [ 3, 5 ], 6 ], [ [ 3, 6 ], 6 ], [ [ 3, 7 ], 6 ], [ [ 3, 8 ], 6 ], [ [ 3, 9 ], 2 ], [ [ 3, 10 ], 2 ] ]

gap> STOP_TEST( "test_antimagmas_functions.tst" );
