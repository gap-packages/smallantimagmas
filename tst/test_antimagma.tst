gap> START_TEST( "test_antimagma.tst" );

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

gap> ForAll(ReallyAllSmallAntimagmas([2 .. 3]), M -> IdSmallAntimagma(M)[1] = Size(M));
true

gap> ForAll(ReallyAllSmallAntimagmas([2 .. 3]), M -> IdSmallAntimagma(M)[2] <= NrSmallAntimagmas(Size(M)));
true

gap> STOP_TEST( "test_antimagma.tst" );
