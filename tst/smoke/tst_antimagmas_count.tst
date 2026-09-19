gap> START_TEST("tst_antimagmas_count.tst");

gap> List([2 .. 4], i -> NrSmallAntimagmas(i));
[ 1, 5, 8891 ]

gap> List([2 .. 4], i -> NrSmallAntimagmas(i, "self-dual"));
[ 0, 0, 2 ]

gap> List([2 .. 4], i -> 2 * NrSmallAntimagmas(i) - NrSmallAntimagmas(i, "self-dual") - NrSmallAntimagmas(i, "up-to-isomorphism"));
[ 0, 0, 0 ]

gap> List(AllSmallAntimagmas([2 .. 4], "self-dual"), IdSmallAntimagma);
[ [ 4, 5984 ], [ 4, 8885 ] ]

gap> ForAll(AllSmallAntimagmas(4, "self-dual"), M -> IsMagmaIsomorphic(M, TransposedMagma(M)));
true
gap> Number(AllSmallAntimagmas(3), M -> IsMagmaIsomorphic(M, TransposedMagma(M)));
0

gap> STOP_TEST("tst_antimagmas_count.tst");

