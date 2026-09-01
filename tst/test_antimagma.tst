gap> START_TEST("test_antimagma.tst");

gap> ForAll([2 .. 3], n -> ForAll(Combinations([1 .. NrSmallAntimagmas(n)], 2), c -> not IsMagmaIsomorphic(SmallAntimagma(n, c[1]), SmallAntimagma(n, c[2])) and not IsMagmaAntiisomorphic(SmallAntimagma(n, c[1]), SmallAntimagma(n, c[2]))));
true

gap> List(Cartesian(AllSmallAntimagmas(2), AllSmallAntimagmas(3)), c -> MagmaIsomorphism(c[1], c[2]));
[ fail, fail, fail, fail, fail ]

gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> IsEmpty(Idempotents(M)));
true

gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> IsEmpty(Center(M)));
true

gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> IsAntiassociative(M));
true

gap> ForAll([2 .. 3], n -> ForAll([1 .. NrSmallAntimagmas(n)], i -> IsMagmaIsomorphic(SmallAntimagma([n, i]), SmallAntimagma(n, i))));
true

## Size(OneSmallAntimagma(n)) = n
gap> List([2 .. 4], n -> Size(OneSmallAntimagma(n)));
[ 2, 3, 4 ]

## IsAntiassociative(OneSmallAntimagma(n))
gap> ForAll([2 .. 4], n -> IsAntiassociative(OneSmallAntimagma(n)));
true

## IdSmallAntimagma(OneSmallAntimagma(n))[1] = n
gap> ForAll([2 .. 3], n -> IdSmallAntimagma(OneSmallAntimagma(n))[1] = n);
true

gap> STOP_TEST("test_antimagma.tst");
