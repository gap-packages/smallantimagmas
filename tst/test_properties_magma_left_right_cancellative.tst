gap> START_TEST(  "test_properties_magma_left_right_cancellative.tst" );

gap> ForAll(AllSmallGroups([2 .. 4]), G -> IsLeftCancellative);
true

gap> ForAll(AllSmallGroups([2 .. 4]), G -> IsRightCancellative);
true

gap> ForAll(AllSmallGroups([2 .. 4]), G -> IsCancellative);
true

gap> ForAny(AllSmallAntimagmas([2 .. 3]), M -> IsCancellative);
false

gap> STOP_TEST(  "test_properties_magma_left_right_cancellative.tst" );
