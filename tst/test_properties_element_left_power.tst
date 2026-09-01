gap> START_TEST("test_properties_element_left_power.tst");

## LeftPower(m, 1) = m
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> ForAll(M, m -> LeftPower(m, 1) = m));
true

## LeftPower(m, 2) = m * m
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> ForAll(M, m -> LeftPower(m, 2) = m * m));
true

## LeftPower(m, k + 1) = m * LeftPower(m, k)
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> ForAll(M, m ->
>        ForAll([1 .. 5], k -> LeftPower(m, k + 1) = m * LeftPower(m, k))));
true

## LeftPower(m, k) rejects k < 1
gap> LeftPower(Representative(SmallAntimagma(2, 1)), 0);
Error, SmallAntimagmas: <id> must be an integer

## LeftPower(m, k) rejects non-integer k
gap> LeftPower(Representative(SmallAntimagma(2, 1)), "2");
Error, SmallAntimagmas: <id> must be an integer

gap> STOP_TEST("test_properties_element_left_power.tst");
