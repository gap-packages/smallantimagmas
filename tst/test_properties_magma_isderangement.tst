gap> START_TEST("test_properties_magma_isderangement.tst");

## all-3-antimagmas-are-either-left-or-right-derangement-inducted
gap> List(AllSmallAntimagmas(3), M -> IsLeftDerangementInducted(M));
[ false, false, false, false, true ]
gap> List(AllSmallAntimagmas(3), M -> IsRightDerangementInducted(M));
[ true, true, true, true, false ]

## all-left-derangement-antimagmas-after-transposition-become-right-derangement
gap> List(Filtered(AllSmallAntimagmas(3), M -> IsLeftDerangementInducted(M)), M -> IsRightDerangementInducted(TransposedMagma(M)));
[ true ]

## there-is-1-antimagma-that-is-both-left-right-derangement-inducted
gap> Filtered(AllSmallAntimagmas(4), M -> IsLeftDerangementInducted(M) and IsRightDerangementInducted(M));
[ <magma with 4 generators> ]

gap> STOP_TEST("test_properties_magma_isderangement.tst");
