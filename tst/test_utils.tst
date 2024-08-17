gap> START_TEST("smallantimagmas: test_utils.tst");

gap> ForAll(AllSmallGroups(3), M -> AssociativityIndex(M) = 3^3);
true

gap> ForAll(AllSmallAntimagmas(2), M -> AssociativityIndex(M) = 0);
true

gap> ForAll(AllSmallAntimagmas(3), M -> AssociativityIndex(M) = 0);
true

gap> ForAll(AllSmallAntimagmas(2), M -> ForAll(GeneratorsOfMagma(M), m -> LeftPower(m, 1) = m));
true

gap> ForAll(AllSmallAntimagmas(2), M -> ForAll(GeneratorsOfMagma(M), m -> RightPower(m, 1) = m));
true

gap> ForAll(AllSmallAntimagmas(3), M -> ForAll(GeneratorsOfMagma(M), m -> LeftPower(m, 1) = m));
true

gap> ForAll(AllSmallAntimagmas(3), M -> ForAll(GeneratorsOfMagma(M), m -> RightPower(m, 1) = m));
true

gap> ForAll(AllSmallAntimagmas(2), M -> ForAll(GeneratorsOfMagma(M), m -> LeftPower(m, 2) = RightPower(m, 2)));
true

gap> ForAll(AllSmallAntimagmas(3), M -> ForAll(GeneratorsOfMagma(M), m -> LeftPower(m, 2) = RightPower(m, 2)));
true

gap> ForAll(AllSmallAntimagmas(2), M -> HasPropertyA3(M) or HasPropertyA3( TransposedMagma(M) ) );
true

gap> ForAll(AllSmallAntimagmas(3), M -> HasPropertyA3(M) or HasPropertyA3( TransposedMagma(M) ) );
true

gap> ForAny(AllSmallAntimagmas(4), M -> not (HasPropertyA3(M) or HasPropertyA3( TransposedMagma(M) ) ) );
true

gap> ForAll([2..10], n -> ForAll(AllSmallGroups(n), G -> IsLeftCancellative(G)));
true

gap> ForAll([2..10], n -> ForAll(AllSmallGroups(n), G -> IsRightCancellative(G))); 
true

gap> ForAll([2..10], n -> ForAll(AllSmallGroups(n), G -> IsCancellative(G)));     
true

gap> ForAny([2..4], n -> ForAny(AllSmallAntimagmas(n), G -> IsCancellative(G)));
false

gap> ForAll([2..10], n -> ForAll(AllSmallGroups(n), G -> ForAll(Elements(G), g -> Order(g) = LeftOrder(g))));
true

gap> ForAll([2..10], n -> ForAll(AllSmallGroups(n), G -> ForAll(Elements(G), g -> Order(g) = RightOrder(g))));
true

gap> Ms_2 := AllSmallAntimagmas(2);;

gap> Ms_3 := AllSmallAntimagmas(3);;

gap> List(Cartesian(Ms_2, Ms_3), M -> IsMagmaIsomorphic(M[1], M[2]));
[ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ]

gap> List(Cartesian(Ms_2, Ms_3), M -> MagmaIsomorphism(M[1], M[2]));
[ fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail ]

gap> STOP_TEST( "test_utils.tst" );

