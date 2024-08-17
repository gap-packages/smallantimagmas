gap> START_TEST( "test_properties_magma_left_right_cyclic.tst" );

gap> ForAll([2..12], n -> ForAll(Filtered(AllSmallGroups(n), G -> not IsCyclic(G)), G -> not IsLeftCyclic(G)) );
true

gap> ForAll([2..12], n -> ForAll(Filtered(AllSmallGroups(n), G -> IsCyclic(G)), G -> IsLeftCyclic(G)) );        
true

gap> ForAll([2..12], n -> ForAll(Filtered(AllSmallGroups(n), G -> not IsCyclic(G)), G -> not IsRightCyclic(G)) );
true

gap> ForAll([2..12], n -> ForAll(Filtered(AllSmallGroups(n), G -> IsCyclic(G)), G -> IsRightCyclic(G)) );        
true

gap> STOP_TEST( "test_properties_magma_left_right_cyclic.tst" );