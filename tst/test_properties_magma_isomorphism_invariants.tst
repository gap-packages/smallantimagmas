gap> START_TEST( "test_properties_magma_isomorphism_invariants.tst" );

gap> List([2 .. 3], n -> List(AllSmallAntimagmas(n), M -> MagmaIsomorphismInvariants(M) <> MagmaIsomorphismInvariants(TransposedMagma(M)) ) );
[ [ true, true ], [ false, false, false, false, false, false, false, false, true, true ] ]

gap> STOP_TEST( "test_properties_magma_isomorphism_invariants.tst" );