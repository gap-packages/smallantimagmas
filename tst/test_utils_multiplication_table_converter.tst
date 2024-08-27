gap> List(AllSmallAntimagmas([2 .. 3]), M -> AntimagmaMultiplicationTableConvert(M) );
[ 
    [3, 3],
    [4, 1],
    [ 10, 10, 10 ],
    [ 10, 10, 19 ],
    [ 11, 17, 11 ],
    [ 10, 19, 10 ],
    [ 14, 1, 1 ],
    [ 14, 3, 14 ],
    [ 14, 7, 14 ],
    [ 14, 19, 14 ],
    [ 14, 27, 1 ],
    [ 16, 16, 16 ] 
]

gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> MultiplicationTable(M) = AntimagmaMultiplicationTableReverse(AntimagmaMultiplicationTableConvert(M)) );
true