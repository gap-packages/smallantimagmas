gap> START_TEST( "test_utils_left_right_cancellative.tst" );

gap> ForAll([2..4], n -> ForAll(AllSmallGroups(n), G -> IsLeftCancellative(G)));
true

gap> ForAll([2..4], n -> ForAll(AllSmallGroups(n), G -> IsRightCancellative(G))); 
true

gap> ForAll([2..4], n -> ForAll(AllSmallGroups(n), G -> IsCancellative(G)));     
true

gap> ForAny([2..3], n -> ForAny(AllSmallAntimagmas(n), M -> IsCancellative(M)));
false

gap> STOP_TEST(  "test_utils_left_right_cancellative.tst" );