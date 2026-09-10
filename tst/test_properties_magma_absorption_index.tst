gap> START_TEST("test_properties_magma_absorption_index.tst");

## LeftZeroIndex(M) counts ordered pairs (x, y) with x * y = x
gap> LeftZeroIndex(SmallAntimagma(2, 1));
2
gap> List(AllSmallAntimagmas(3), M -> LeftZeroIndex(M));
[ 3, 4, 2, 3, 0 ]

## RightZeroIndex(M) counts ordered pairs (x, y) with x * y = y
gap> RightZeroIndex(SmallAntimagma(2, 1));
0
gap> List(AllSmallAntimagmas(3), M -> RightZeroIndex(M));
[ 0, 0, 0, 0, 3 ]

## AbsorptionIndex(M) = [ LeftZeroIndex(M), RightZeroIndex(M) ]
gap> ForAll(AllSmallAntimagmas([2 .. 4]), M -> AbsorptionIndex(M) = [LeftZeroIndex(M), RightZeroIndex(M)]);
true

## RightZeroIndex(M) = LeftZeroIndex(TransposedMagma(M))
gap> ForAll(AllSmallAntimagmas([2 .. 4]), M -> RightZeroIndex(M) = LeftZeroIndex(TransposedMagma(M)));
true

## no idempotents and no pair (x, y) with x <> y absorbs both ways, so the sum is at most |M| (|M| - 1)
gap> ForAll(AllSmallAntimagmas([2 .. 4]), M -> Sum(AbsorptionIndex(M)) <= Size(M) * (Size(M) - 1));
true

## left zero magma, i.e. x * y = x for all x, y, has left zero index |M| ^ 2
gap> M := MagmaByMultiplicationTable([[1, 1, 1], [2, 2, 2], [3, 3, 3]]);;
gap> AbsorptionIndex(M);
[ 9, 3 ]
gap> AbsorptionIndex(TransposedMagma(M));
[ 3, 9 ]

## groups: x * y = x iff y is the identity, so both indices equal |G|
gap> AbsorptionIndex(CyclicGroup(4));
[ 4, 4 ]

## distribution over antimagmas of order 4
gap> Collected(List(AllSmallAntimagmas(4), M -> AbsorptionIndex(M)));
[ [ [ 0, 0 ], 40 ], [ [ 0, 1 ], 99 ], [ [ 0, 2 ], 180 ], [ [ 0, 3 ], 137 ],
  [ [ 0, 4 ], 53 ], [ [ 0, 5 ], 6 ], [ [ 1, 0 ], 173 ], [ [ 1, 1 ], 29 ],
  [ [ 1, 2 ], 17 ], [ [ 1, 3 ], 10 ], [ [ 2, 0 ], 785 ], [ [ 2, 1 ], 84 ],
  [ [ 2, 2 ], 33 ], [ [ 3, 0 ], 1749 ], [ [ 3, 1 ], 66 ], [ [ 4, 0 ], 2341 ],
  [ [ 4, 1 ], 42 ], [ [ 5, 0 ], 1831 ], [ [ 6, 0 ], 921 ], [ [ 7, 0 ], 256 ],
  [ [ 8, 0 ], 39 ] ]
gap> Size(Set(AllSmallAntimagmas(4), M -> AbsorptionIndex(M)));
21

gap> STOP_TEST("test_properties_magma_absorption_index.tst");
