gap> START_TEST("test_properties_element_left_right_index_period.tst");

## LeftIndexPeriod(g) = [ 1, Order(g) ] and RightIndexPeriod(g) = [ 1, Order(g) ]
#@if IsPackageMarkedForLoading( "smallgrp", "" )
gap> ForAll(AllSmallGroups([2 .. 10]), G -> ForAll(Elements(G), g -> LeftIndexPeriod(g) = [1, Order(g)]));
true

gap> ForAll(AllSmallGroups([2 .. 10]), G -> ForAll(Elements(G), g -> RightIndexPeriod(g) = [1, Order(g)]));
true
#@fi

## LeftPower(m, i + p) = LeftPower(m, i) for LeftIndexPeriod(m) = [ i, p ]
gap> ForAll(AllSmallAntimagmas([2 .. 4]), M -> ForAll(M, m ->
>        LeftPower(m, LeftIndexPeriod(m)[1] + LeftIndexPeriod(m)[2]) = LeftPower(m, LeftIndexPeriod(m)[1])));
true

## RightPower(m, i + p) = RightPower(m, i) for RightIndexPeriod(m) = [ i, p ]
gap> ForAll(AllSmallAntimagmas([2 .. 4]), M -> ForAll(M, m ->
>        RightPower(m, RightIndexPeriod(m)[1] + RightIndexPeriod(m)[2]) = RightPower(m, RightIndexPeriod(m)[1])));
true

## LeftIndexPeriod(m) <> RightIndexPeriod(m) over orders 2 and 3
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> ForAll(M, m -> LeftIndexPeriod(m) <> RightIndexPeriod(m)));
true

## Collected(List(M, LeftIndexPeriod)) over orders 2 and 3
gap> List(AllSmallAntimagmas([2 .. 3]), M -> Collected(List(M, LeftIndexPeriod)));
[ [ [ [ 1, 2 ], 2 ] ], [ [ [ 1, 2 ], 2 ], [ [ 2, 2 ], 1 ] ],
  [ [ [ 1, 2 ], 3 ] ], [ [ [ 1, 2 ], 1 ], [ [ 2, 2 ], 2 ] ],
  [ [ [ 1, 2 ], 2 ], [ [ 2, 2 ], 1 ] ], [ [ [ 2, 1 ], 3 ] ] ]

## Collected(List(M, RightIndexPeriod)) over orders 2 and 3
gap> List(AllSmallAntimagmas([2 .. 3]), M -> Collected(List(M, RightIndexPeriod)));
[ [ [ [ 2, 1 ], 2 ] ], [ [ [ 2, 1 ], 3 ] ], [ [ [ 2, 1 ], 3 ] ],
  [ [ [ 2, 1 ], 2 ], [ [ 2, 2 ], 1 ] ], [ [ [ 2, 1 ], 2 ], [ [ 3, 1 ], 1 ] ],
  [ [ [ 1, 3 ], 3 ] ] ]

## Collected(List(M, LeftIndexPeriod)) = Collected(List(TransposedMagma(M), RightIndexPeriod))
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M ->
>        Collected(List(M, LeftIndexPeriod)) = Collected(List(TransposedMagma(M), RightIndexPeriod)));
true

## Collected(List(M, RightIndexPeriod)) = Collected(List(TransposedMagma(M), LeftIndexPeriod))
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M ->
>        Collected(List(M, RightIndexPeriod)) = Collected(List(TransposedMagma(M), LeftIndexPeriod)));
true

gap> STOP_TEST("test_properties_element_left_right_index_period.tst");
