gap> START_TEST("test_helper_argument_checks.tst");

# ------------------------------------------------------------------
# Every entry point reaches the data of an order through checkOrder
# and through the directory lookup, so an order that is not an
# integer, that is smaller than 1, or that ships no data is refused
# before any file is read.
# ------------------------------------------------------------------

gap> NrSmallAntimagmas("2");
Error, smallantimagmas: <order> must be an integer

gap> NrSmallAntimagmas(0);
Error, smallantimagmas: <order> must be greater than or equal to 1

gap> NrSmallAntimagmas(9);
Error, smallantimagmas: <order> is not yet implemented

gap> AllSmallAntimagmas(0);
Error, smallantimagmas: <order> must be greater than or equal to 1

gap> SmallAntimagma(0, 1);
Error, smallantimagmas: <order> must be greater than or equal to 1

gap> NrSmallAntimagmas(1);
0

gap> AllSmallAntimagmas(1);
[  ]

gap> SmallAntimagma(1, 1);
Error, smallantimagmas: <id> is larger than the number of antimagmas of that order

gap> __SmallAntimagmaHelper.getSmallAntimagmaMetadataDirectory(9);
Error, smallantimagmas: <order> is not yet implemented

# SmallAntimagma takes (n, i) or [n, i], and nothing else.
gap> SmallAntimagma(2);
Error, SmallAntimagma: expected (n, i) or [n, i]

gap> SmallAntimagma([2, 1, 1]);
Error, SmallAntimagma: expected (n, i) or [n, i]

gap> SmallAntimagma(2, "1");
Error, SmallAntimagma: expected (n, i) or [n, i]

gap> STOP_TEST("test_helper_argument_checks.tst");
