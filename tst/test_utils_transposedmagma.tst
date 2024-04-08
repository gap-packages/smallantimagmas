gap> START_TEST("smallantimagmas: test_utils_transposedmagma.tst");


gap> ForAll([2..3], i -> ForAll(AllSmallAntimagmas(i), M -> MultiplicationTable(TransposedMagma(M)) = TransposedMat(MultiplicationTable(M))) );
true

gap> ForAll([2..3], i -> ForAll(AllSmallAntimagmas(i), M -> IsMagmaAntiisomorphic(M, TransposedMagma(M) ) ) );
true

gap> STOP_TEST( "test_utils_transposedmagma.tst" );
