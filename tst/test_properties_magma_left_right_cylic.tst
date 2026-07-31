gap> START_TEST("test_properties_magma_left_right_cyclic.tst");

#@if IsPackageMarkedForLoading( "smallgrp", "" )
gap> ForAll(Filtered(AllSmallGroups([2 .. 12]), G -> not IsCyclic(G)), G -> not IsLeftCyclic(G));
true

gap> ForAll(Filtered(AllSmallGroups([2 .. 12]), G -> IsCyclic(G)), G -> IsLeftCyclic(G));
true

gap> ForAll(Filtered(AllSmallGroups([2 .. 12]), G -> not IsCyclic(G)), G -> not IsRightCyclic(G));
true

gap> ForAll(Filtered(AllSmallGroups([2 .. 12]), G -> IsCyclic(G)), G -> IsRightCyclic(G));        
true
#@fi

gap> STOP_TEST("test_properties_magma_left_right_cyclic.tst");