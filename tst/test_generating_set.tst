gap> START_TEST("test_generating_set.tst");

# Test GeneratingSet returns a generating set
gap> M := SmallAntimagma(2, 1);
<magma with 2 generators>

gap> gens := GeneratingSet(M);
[ m1, m2 ]

gap> Size(Submagma(M, gens)) = Size(M);
true

# Test MinimalGeneratingSet returns a minimal generating set
gap> M := SmallAntimagma(2, 1);
<magma with 2 generators>

gap> mingens := MinimalGeneratingSet(M);
[ m1, m2 ]

gap> Size(Submagma(M, mingens)) = Size(M);
true

# Test that MinimalGeneratingSet for size 3 antimagmas
gap> M := SmallAntimagma(3, 1);
<magma with 3 generators>

gap> mingens := MinimalGeneratingSet(M);
[ m1, m2, m3 ]

gap> Size(Submagma(M, mingens)) = Size(M);
true

# Test all antimagmas of size 2
gap> ForAll(AllSmallAntimagmas(2), M -> Size(Submagma(M, GeneratingSet(M))) = Size(M));
true

gap> ForAll(AllSmallAntimagmas(2), M -> Size(Submagma(M, MinimalGeneratingSet(M))) = Size(M));
true

# Test all antimagmas of size 3
gap> ForAll(AllSmallAntimagmas(3), M -> Size(Submagma(M, GeneratingSet(M))) = Size(M));
true

gap> ForAll(AllSmallAntimagmas(3), M -> Size(Submagma(M, MinimalGeneratingSet(M))) = Size(M));
true

gap> STOP_TEST("test_generating_set.tst");
