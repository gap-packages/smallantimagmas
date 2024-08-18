gap> START_TEST( "test_antimagma.tst" );

gap> IsAntiassociative(MagmaByMultiplicationTable([[1]]));
false

gap> IsAntiassociative(MagmaByMultiplicationTable([[2, 1], [2, 1]]));
true

gap> ForAll([2..3], n -> ForAll(AllSmallAntimagmas(n), M -> IsEmpty(Idempotents(M))));
true

gap> ForAll([2..3], n -> ForAll(AllSmallAntimagmas(n), M -> IsEmpty(Center(M))));
true

gap> ForAll([2..3], n -> ForAll(AllSmallAntimagmas(n), M -> IsAntiassociative(M)));
true

gap> Collected( List(ReallyAllSmallAntimagmas(3), M -> IdSmallAntimagma(M)) );
[ [ [ 3, 1 ], 6 ], [ [ 3, 2 ], 6 ], [ [ 3, 3 ], 6 ], [ [ 3, 4 ], 6 ], [ [ 3, 5 ], 6 ], [ [ 3, 6 ], 6 ], [ [ 3, 7 ], 6 ], [ [ 3, 8 ], 6 ], [ [ 3, 9 ], 2 ], [ [ 3, 10 ], 2 ] ]

gap> STOP_TEST( "test_antimagma.tst" );
