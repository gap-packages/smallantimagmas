gap> START_TEST("tst_indices_properties_magma_commutativity_index.tst");

gap> Collected(List(AllSmallAntimagmas([2 .. 3]), M -> CommutativityIndex(M)));
[ [ 0, 2 ], [ 1, 4 ] ]

gap> STOP_TEST("tst_indices_properties_magma_commutativity_index.tst");
