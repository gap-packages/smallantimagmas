gap> START_TEST( "test_properties_element_left_right_order.tst" );

gap> ForAll([2..10], n -> ForAll(AllSmallGroups(n), G -> ForAll(Elements(G), g -> Order(g) = LeftOrder(g))));
true

gap> ForAll([2..10], n -> ForAll(AllSmallGroups(n), G -> ForAll(Elements(G), g -> Order(g) = RightOrder(g))));
true

gap> ForAll([2..3], n -> ForAll(AllSmallAntimagmas(n), M -> ForAll(Filtered(Elements(M), m -> LeftOrder(m) <> infinity), m -> LeftOrder(m) <> RightOrder(m) ) ) );
true

gap> ForAll([2..3], n -> ForAll(AllSmallAntimagmas(n), M -> ForAll(Filtered(Elements(M), m -> RightOrder(m) <> infinity), m -> LeftOrder(m) <> RightOrder(m) ) ) );
true

gap> STOP_TEST( "test_properties_element_left_right_order.tst" );