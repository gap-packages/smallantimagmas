gap> START_TEST("property_left_right_alternative.tst");

gap> ForAny(AllSmallAntimagmas([2 .. 3]), M -> IsLeftAlternative(M));
false

gap> ForAny(AllSmallAntimagmas([2 .. 3]), M -> IsRightAlternative(M));
false

gap> STOP_TEST("property_left_right_alternative.tst");
