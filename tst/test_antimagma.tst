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

gap> STOP_TEST( "test_antimagma.tst" );
