gap> START_TEST("smallantimagmas: test_utils_hasproperty_a3.tst");

gap> ForAll(AllSmallAntimagmas(2), M -> HasPropertyA3(M) or HasPropertyA3( TransposedMagma(M) ) );
true

gap> ForAll(AllSmallAntimagmas(3), M -> HasPropertyA3(M) or HasPropertyA3( TransposedMagma(M) ) );
true

gap> ForAny(AllSmallAntimagmas(4), M -> not (HasPropertyA3(M) or HasPropertyA3( TransposedMagma(M) ) ) );
true

gap> STOP_TEST( "test_utils_hasproperty_a3.tst" );

