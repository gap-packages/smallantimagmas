gap> START_TEST("property_transposed_magma.tst");

## the magma on a 1-element set is its own transpose
gap> MultiplicationTable(TransposedMagma(MagmaByMultiplicationTable([[1]])));
[ [ 1 ] ]

## x *^op y = y * x, i.e. rows become columns
gap> MultiplicationTable(TransposedMagma(MagmaByMultiplicationTable([[2, 1], [2, 1]])));
[ [ 2, 2 ], [ 1, 1 ] ]
gap> MultiplicationTable(TransposedMagma(MagmaByMultiplicationTable([[2, 1, 1], [2, 1, 1], [3, 1, 1]])));
[ [ 2, 2, 3 ], [ 1, 1, 1 ], [ 1, 1, 1 ] ]

## the left projection transposes to the right projection
gap> MultiplicationTable(TransposedMagma(MagmaByMultiplicationTable([[1, 1, 1], [2, 2, 2], [3, 3, 3]])));
[ [ 1, 2, 3 ], [ 1, 2, 3 ], [ 1, 2, 3 ] ]

## a symmetric table is its own transpose
gap> MultiplicationTable(TransposedMagma(MagmaByMultiplicationTable([[1, 2], [2, 1]])));
[ [ 1, 2 ], [ 2, 1 ] ]

## transposing twice gives back the table
gap> MultiplicationTable(TransposedMagma(TransposedMagma(MagmaByMultiplicationTable([[2, 1, 1], [2, 1, 1], [3, 1, 1]]))));
[ [ 2, 1, 1 ], [ 2, 1, 1 ], [ 3, 1, 1 ] ]

## the transpose has as many elements as the magma
gap> Size(TransposedMagma(MagmaByMultiplicationTable([[2, 1, 1], [2, 1, 1], [3, 1, 1]])));
3

gap> STOP_TEST("property_transposed_magma.tst");
