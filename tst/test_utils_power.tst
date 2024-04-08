gap> START_TEST("smallantimagmas: test_utils_power.tst");

gap> ForAll([2..3], i -> ForAll(AllSmallAntimagmas(i), M -> ForAll(M, m -> LeftPower(m, 1) = m ) ) );
true

gap> ForAll([2..3], i -> ForAll(AllSmallAntimagmas(i), M -> ForAll(M, m -> RightPower(m, 1) = m ) ) );
true

gap> ForAll([2..3], i -> ForAll(AllSmallAntimagmas(i), M -> ForAll(M, m -> RightPower(m, 2) = LeftPower(m, 2) ) ) );
true

gap> START_TEST("smallantimagmas: test_utils_power.tst");
