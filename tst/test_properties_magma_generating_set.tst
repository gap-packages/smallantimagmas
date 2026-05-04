gap> START_TEST("test_properties_magma_generating_set.tst");

gap> ForAll(AllSmallAntimagmas(2), M -> Size(Submagma(M, MinimalGeneratingSet(M))) = Size(M));
true

gap> ForAll(AllSmallAntimagmas(3), M -> Size(Submagma(M, MinimalGeneratingSet(M))) = Size(M));
true

gap> ForAll(AllSmallAntimagmas(2), M -> Size(MinimalGeneratingSet(M)) <= Size(M));
true

gap> ForAll(AllSmallAntimagmas(2), M -> IsSubset(Elements(M), MinimalGeneratingSet(M)));
true

gap> ForAll(AllSmallAntimagmas(2), M -> Size(Submagma(M, GeneratingSet(M))) = Size(M));
true

gap> STOP_TEST("test_properties_magma_generating_set.tst");
