gap> START_TEST("test_properties_magma_orders_of_elements.tst");

## LeftOrdersOfElements(M) = Collected(List(M, LeftOrder)) over orders 2 and 3
gap> List(AllSmallAntimagmas([2 .. 3]), M -> LeftOrdersOfElements(M));
[ [ [ 2, 2 ] ], [ [ 2, 2 ], [ infinity, 1 ] ], [ [ 2, 3 ] ],
  [ [ 2, 1 ], [ infinity, 2 ] ], [ [ 2, 2 ], [ infinity, 1 ] ],
  [ [ infinity, 3 ] ] ]

## RightOrdersOfElements(M) = Collected(List(M, RightOrder)) over orders 2 and 3
gap> List(AllSmallAntimagmas([2 .. 3]), M -> RightOrdersOfElements(M));
[ [ [ infinity, 2 ] ], [ [ infinity, 3 ] ], [ [ infinity, 3 ] ],
  [ [ infinity, 3 ] ], [ [ infinity, 3 ] ], [ [ 3, 3 ] ] ]

## Sum(LeftOrdersOfElements(M), e -> e[2]) = Size(M)
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> Sum(LeftOrdersOfElements(M), e -> e[2]) = Size(M));
true

## Sum(RightOrdersOfElements(M), e -> e[2]) = Size(M)
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> Sum(RightOrdersOfElements(M), e -> e[2]) = Size(M));
true

## LeftOrdersOfElements(M) = RightOrdersOfElements(TransposedMagma(M))
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> LeftOrdersOfElements(M) = RightOrdersOfElements(TransposedMagma(M)));
true

## RightOrdersOfElements(M) = LeftOrdersOfElements(TransposedMagma(M))
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> RightOrdersOfElements(M) = LeftOrdersOfElements(TransposedMagma(M)));
true

gap> STOP_TEST("test_properties_magma_orders_of_elements.tst");
