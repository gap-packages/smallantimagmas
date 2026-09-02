gap> START_TEST("test_properties_magma_indices.tst");

## DiagonalOfMultiplicationTable(M) lists Position(Elements(M), m * m) for m in M
gap> DiagonalOfMultiplicationTable(SmallAntimagma(2, 1));
[ 2, 1 ]

## DiagonalOfMultiplicationTable(M)[i] <> i, i.e. M has no idempotent
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> ForAll([1 .. Size(M)], i -> DiagonalOfMultiplicationTable(M)[i] <> i));
true

## SquaresIndex(M) = Size(Set(M, m -> m ^ 2)) for order 2
gap> List(AllSmallAntimagmas(2), M -> SquaresIndex(M));
[ 2 ]

## SquaresIndex(M) = Size(Set(M, m -> m ^ 2)) for order 3
gap> List(AllSmallAntimagmas(3), M -> SquaresIndex(M));
[ 2, 2, 2, 2, 3 ]

## SquaresIndex(M) = Size(Set(DiagonalOfMultiplicationTable(M)))
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> SquaresIndex(M) = Size(Set(DiagonalOfMultiplicationTable(M))));
true

## AnticommutativityIndex(M) over orders 2 and 3
gap> Collected(List(AllSmallAntimagmas([2 .. 3]), M -> AnticommutativityIndex(M)));
[ [ 1, 1 ], [ 2, 4 ], [ 3, 1 ] ]

## CommutativityIndex(M) + AnticommutativityIndex(M) = Binomial(Size(M), 2)
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> CommutativityIndex(M) + AnticommutativityIndex(M) = Binomial(Size(M), 2));
true

gap> STOP_TEST("test_properties_magma_indices.tst");
