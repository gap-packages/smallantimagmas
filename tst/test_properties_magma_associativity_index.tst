gap> START_TEST( "test_properties_magma_associativity_index.txt" );

gap> ForAll([2..12], n -> ForAll(AllSmallGroups(n), M -> AssociativityIndex(M) = n^3));
true

gap> ForAll([2..3], n -> ForAll(AllSmallAntimagmas(n), M -> AssociativityIndex(M) = 0));
true

gap> STOP_TEST( "test_properties_magma_associativity_index.txt" );