gap> START_TEST( "test_properties_magma_left_right_cyclic.tst" );

gap> ForAll(Filtered(AllSmallGroups([2 .. 12]), G -> not IsCyclic), G -> not IsLeftCyclic);
true

gap> ForAll(Filtered(AllSmallGroups([2 .. 12]), G -> IsCyclic), G -> IsLeftCyclic);
true

gap> ForAll(Filtered(AllSmallGroups([2 .. 12]), G -> not IsCyclic), G -> not IsRightCyclic);
true

gap> ForAll(Filtered(AllSmallGroups([2 .. 12]), G -> IsCyclic), G -> IsRightCyclic);        
true

gap> STOP_TEST( "test_properties_magma_left_right_cyclic.tst" );
