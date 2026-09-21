gap> START_TEST("property_commutativity_index.tst");

gap> Collected(List(AllSmallAntimagmas([2 .. 3]), M -> CommutativityIndex(M)));
[ [ 0, 2 ], [ 1, 4 ] ]

gap> STOP_TEST("property_commutativity_index.tst");
