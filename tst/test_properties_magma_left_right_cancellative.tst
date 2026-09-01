gap> START_TEST("test_properties_magma_left_right_cancellative.tst");

#@if IsPackageMarkedForLoading( "smallgrp", "" )
gap> ForAll(AllSmallGroups([2 .. 4]), G -> IsLeftCancellative(G));
true

gap> ForAll(AllSmallGroups([2 .. 4]), G -> IsRightCancellative(G));
true

gap> ForAll(AllSmallGroups([2 .. 4]), G -> IsCancellative(G));
true
#@fi

gap> ForAny(AllSmallAntimagmas([2 .. 3]), M -> IsCancellative(M));
false

gap> List(AllSmallAntimagmas(3), M -> IsRightCancellative(M));
[ false, false, false, false, true ]

gap> IsRightCancellative(SmallAntimagma(3, 5));
true

gap> IsLeftCancellative(SmallAntimagma(3, 5));
false

gap> STOP_TEST("test_properties_magma_left_right_cancellative.tst");