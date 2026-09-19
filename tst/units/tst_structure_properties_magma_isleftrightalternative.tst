gap> START_TEST("tst_structure_properties_magma_isleftrightalternative.tst");

gap> ForAny(AllSmallAntimagmas([2 .. 3]), M -> IsLeftAlternative(M));
false

gap> ForAny(AllSmallAntimagmas([2 .. 3]), M -> IsRightAlternative(M));
false

gap> STOP_TEST("tst_structure_properties_magma_isleftrightalternative.tst");
