gap> START_TEST("test_properties_element_right_power.tst");

## RightPower(m, 1) = m
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> ForAll(M, m -> RightPower(m, 1) = m));
true

## RightPower(m, 2) = m * m
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> ForAll(M, m -> RightPower(m, 2) = m * m));
true

## RightPower(m, k + 1) = RightPower(m, k) * m
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> ForAll(M, m ->
>        ForAll([1 .. 5], k -> RightPower(m, k + 1) = RightPower(m, k) * m)));
true

## LeftPower(m, 3) <> RightPower(m, 3) for some m of every antimagma of order 2 and 3
gap> Number(AllSmallAntimagmas([2 .. 3]), M -> ForAny(M, m -> LeftPower(m, 3) <> RightPower(m, 3)));
6

## Position(Elements(M), RightPower(m, k)) = Position(Elements(TransposedMagma(M)), LeftPower(m, k))
gap> ForAll(AllSmallAntimagmas([2 .. 3]), function(M)
>        local T, e, f;
>        T := TransposedMagma(M);
>        e := Elements(M);
>        f := Elements(T);
>        return ForAll([1 .. Size(M)], i ->
>            ForAll([1 .. 5], k -> Position(e, RightPower(e[i], k)) = Position(f, LeftPower(f[i], k))));
>    end);
true

## RightPower(m, k) rejects k < 1
gap> RightPower(Representative(SmallAntimagma(2, 1)), 0);
Error, SmallAntimagmas: <id> must be an integer

## RightPower(m, k) rejects non-integer k
gap> RightPower(Representative(SmallAntimagma(2, 1)), "2");
Error, SmallAntimagmas: <id> must be an integer

gap> STOP_TEST("test_properties_element_right_power.tst");
