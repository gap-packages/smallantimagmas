gap> START_TEST("smallantimagmas: test_utils_isantiassociative.tst");

gap> ForAll([2..3], i -> ForAll(AllSmallAntimagmas(i), M -> IsAntiassociative(M) ) );
true

gap> ForAny([1..16], i -> ForAny(AllSmallGroups(i), M -> IsAntiassociative(M) ) );
false

gap> STOP_TEST("smallantimagmas: test_utils_isantiassociative.tst");
