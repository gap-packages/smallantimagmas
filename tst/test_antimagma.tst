gap> START_TEST( "test_antimagma.tst" );

gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> HasPropertyA3(M) or HasPropertyA3( TransposedMagma(M) ) );
true

gap> ForAll([2 .. 3], n -> ForAll(Combinations([1 .. NrSmallAntimagmas(n)], 2), c -> not IsMagmaIsomorphic(SmallAntimagma(n, c[1]), SmallAntimagma(n, c[2]) ) ) );
true

gap> List(Cartesian(AllSmallAntimagmas(2), AllSmallAntimagmas(3)), c -> MagmaIsomorphism(c[1], c[2]));
[ fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail ]

gap> IsAntiassociative(MagmaByMultiplicationTable([[1]]));
false

gap> IsAntiassociative(MagmaByMultiplicationTable([[2, 1], [2, 1]]));
true

gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> IsEmpty(Idempotents(M)));
true

gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> IsEmpty(Center(M)));
true

gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> IsAntiassociative(M));
true

gap> Collected( List(ReallyAllSmallAntimagmas(3), M -> IdSmallAntimagma(M)) );
[ [ [ 3, 1 ], 6 ], [ [ 3, 2 ], 6 ], [ [ 3, 3 ], 6 ], [ [ 3, 4 ], 6 ], [ [ 3, 5 ], 6 ], [ [ 3, 6 ], 6 ], [ [ 3, 7 ], 6 ], [ [ 3, 8 ], 6 ], [ [ 3, 9 ], 2 ], [ [ 3, 10 ], 2 ] ]

gap> STOP_TEST( "test_antimagma.tst" );
