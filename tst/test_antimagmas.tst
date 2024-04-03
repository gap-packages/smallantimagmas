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

gap> STOP_TEST( "test_antimagmas_functions.tst" );
