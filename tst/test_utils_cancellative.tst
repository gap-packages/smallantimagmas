gap> START_TEST("smallantimagmas: test_utils_cancellative.tst");

gap> ForAll([1..16], i -> ForAll(AllSmallGroups(i), G -> IsLeftCancellative(G) ) );
true

gap> ForAll([1..16], i -> ForAll(AllSmallGroups(i), G -> IsRightCancellative(G) ) );
true

gap> ForAll([1..16], i -> ForAll(AllSmallGroups(i), G -> IsCancellative(G) ) );
true

gap> ForAny([2..3], i -> ForAny(AllSmallAntimagmas(i), M -> IsCancellative(M) ) );
false

gap> START_TEST("smallantimagmas: test_utils_cancellative.tst");
