gap> START_TEST("test_antimagmas_count.tst");

gap> List([2 .. 4], i -> NrSmallAntimagmas);
[ 2, 10, 17780 ]

gap> List([2 .. 4], i -> ReallyNrSmallAntimagmas);
[ 2, 52, 421560 ]

gap> STOP_TEST( "test_antimagmas_count.tst" );

