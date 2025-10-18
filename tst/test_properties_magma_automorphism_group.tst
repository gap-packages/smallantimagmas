gap> START_TEST("test_properties_magma_automorphism_group.tst");

gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> ForAll(MagmaAutomorphismGroup(M), psi -> IsMagmaHomomorphism(psi)));
true

gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> ForAll(MagmaAutomorphismGroup(M), psi -> RespectsMultiplication(psi)));
true

gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> Order(SymmetricGroup(Size(M))) mod Order(MagmaAutomorphismGroup(M)) = 0);
true

gap> STOP_TEST("test_properties_magma_automorphism_group.tst");