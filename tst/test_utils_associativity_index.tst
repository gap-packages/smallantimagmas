gap> START_TEST( "test_utils_associativity_index.tst" );

gap> ForAll([2..4], n -> ForAll(AllSmallGroups(n), M -> AssociativityIndex(M) = n^3));
true

gap> ForAll([2..3], n -> ForAll(AllSmallAntimagmas(n), M -> AssociativityIndex(M) = 0));
true

gap> STOP_TEST( "test_utils_associativity_index.tst" );