gap> START_TEST("smallantimagmas: test_utils.tst");

gap> ForAll(AllSmallAntimagmas(2), M -> ForAll(GeneratorsOfMagma(M), m -> LeftPower(m, 1) = m));
true

gap> ForAll(AllSmallAntimagmas(2), M -> ForAll(GeneratorsOfMagma(M), m -> RightPower(m, 1) = m));
true

gap> ForAll(AllSmallAntimagmas(3), M -> ForAll(GeneratorsOfMagma(M), m -> LeftPower(m, 1) = m));
true

gap> ForAll(AllSmallAntimagmas(3), M -> ForAll(GeneratorsOfMagma(M), m -> RightPower(m, 1) = m));
true

gap> ForAll(AllSmallAntimagmas(2), M -> ForAll(GeneratorsOfMagma(M), m -> LeftPower(m, 2) = RightPower(m, 2)));
true

gap> ForAll(AllSmallAntimagmas(3), M -> ForAll(GeneratorsOfMagma(M), m -> LeftPower(m, 2) = RightPower(m, 2)));
true

gap> ForAll(AllSmallAntimagmas(2), M -> HasPropertyA3(M) or HasPropertyA3( TransposedMagma(M) ) );
true

gap> ForAll(AllSmallAntimagmas(3), M -> HasPropertyA3(M) or HasPropertyA3( TransposedMagma(M) ) );
true

gap> ForAny(AllSmallAntimagmas(4), M -> not (HasPropertyA3(M) or HasPropertyA3( TransposedMagma(M) ) ) );
true

gap> ForAll(AllSmallGroups(2), M -> IsRightCancellative(M) );
true

gap> ForAll(AllSmallGroups(3), M -> IsRightCancellative(M) );
true

gap> ForAll(AllSmallGroups(4), M -> IsRightCancellative(M) );
true

gap> ForAll(AllSmallGroups(2), M -> IsLeftCancellative(M) );
true

gap> ForAll(AllSmallGroups(3), M -> IsLeftCancellative(M) );
true

gap> ForAll(AllSmallGroups(4), M -> IsLeftCancellative(M) );
true

gap> ForAll(AllSmallGroups(2), M -> IsCancellative(M) );
true

gap> ForAll(AllSmallGroups(3), M -> IsCancellative(M) );
true

gap> ForAll(AllSmallGroups(4), M -> IsCancellative(M) );
true

gap> Filtered(AllSmallAntimagmas(2), M -> IsCancellative(M) );
[ ]

gap> Filtered(AllSmallAntimagmas(3), M -> IsCancellative(M) );
[ ]

gap> STOP_TEST( "test_utils.tst" );

