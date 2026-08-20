gap> START_TEST("test_helper_multiplication_table_converter.tst");

gap> List([1 .. 2], n -> List(EnumeratorOfTuples([1 .. n], n)));
[
    [
        [ 1 ] 
    ],
    [ 
        [ 1, 1 ], 
        [ 1, 2 ],
        [ 2, 1 ],
        [ 2, 2 ]
    ]
]

gap> ForAll([1 .. 5], n -> List(EnumeratorOfTuples([1 .. n], n)) = Tuples([1 .. n], n));
true

gap> ForAll([1 .. 5], n -> EnumeratorOfTuples([1 .. n], n) = SortedList(Tuples([1 .. n], n)));
true

gap> List(AllSmallAntimagmas([2 .. 3]), M -> __SmallAntimagmaHelper.MultiplicationTableConvert(MultiplicationTable(M)));
[ 
    [3, 3],
    [ 10, 10, 10 ],
    [ 10, 10, 19 ],
    [ 10, 19, 10 ],
    [ 10, 19, 19 ],
    [ 14, 27, 1 ] 
]

gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> MultiplicationTable(M) = __SmallAntimagmaHelper.MultiplicationTableReverse(__SmallAntimagmaHelper.MultiplicationTableConvert(MultiplicationTable(M))));
true

# n = 2, weights 2, 1: [ 2, 1 ] -> 1 + 1 * 2 + 0 * 1 = 3
gap> List(AllSmallAntimagmas(2), M -> __SmallAntimagmaHelper.MultiplicationTableConvert(MultiplicationTable(M))) = [[3, 3]];
true

# n = 3, weights 9, 3, 1:
#   [ 1, 1, 1 ] -> 1 + 0 * 9 + 0 * 3 + 0 * 1 =  1
#   [ 2, 1, 1 ] -> 1 + 1 * 9 + 0 * 3 + 0 * 1 = 10
#   [ 2, 2, 2 ] -> 1 + 1 * 9 + 1 * 3 + 1 * 1 = 14
#   [ 3, 1, 1 ] -> 1 + 2 * 9 + 0 * 3 + 0 * 1 = 19
#   [ 3, 3, 3 ] -> 1 + 2 * 9 + 2 * 3 + 2 * 1 = 27
gap> List(AllSmallAntimagmas(3), M -> __SmallAntimagmaHelper.MultiplicationTableConvert(MultiplicationTable(M))) = [
>     [10, 10, 10], [10, 10, 19], [10, 19, 10], [10, 19, 19], [14, 27, 1]
> ];
true

# decoding those row forms gives the tables back
gap> List([[3, 3]], T -> __SmallAntimagmaHelper.MultiplicationTableReverse(T)) = List(AllSmallAntimagmas(2), MultiplicationTable);
true

gap> List([[10, 10, 10], [10, 10, 19], [10, 19, 10], [10, 19, 19], [14, 27, 1]], T -> __SmallAntimagmaHelper.MultiplicationTableReverse(T)) = List(AllSmallAntimagmas(3), MultiplicationTable);
true

gap> STOP_TEST("test_helper_multiplication_table_converter.tst");
