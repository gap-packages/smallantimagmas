gap> START_TEST( "test_properties_magma_isleftrightalternative.tst" );

gap> ForAny(AllSmallAntimagmas([2 .. 3]), M -> IsLeftAlternative );
false

gap> ForAny(AllSmallAntimagmas([2 .. 3]), M -> IsRightAlternative );
false

gap> STOP_TEST( "test_properties_magma_isleftrightalternative.tst" );
