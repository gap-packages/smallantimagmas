gap> START_TEST("smallantimagmas: test_utils.tst");

gap> ForAll(AllSmallAntimagmas(2), M -> ForAll(GeneratorsOfMagma(M), m -> LeftPower(m, 1) = m));
true

gap> ForAll(AllSmallAntimagmas(2), M -> ForAll(GeneratorsOfMagma(M), m -> RightPower(m, 1) = m));
true

gap> ForAll(AllSmallAntimagmas(3), M -> ForAll(GeneratorsOfMagma(M), m -> LeftPower(m, 1) = m));
true

gap> ForAll(AllSmallAntimagmas(3), M -> ForAll(GeneratorsOfMagma(M), m -> RightPower(m, 1) = m));
true

gap> ForAll(AllSmallAntimagmas(2), M -> ForAll(GeneratorsOfMagma(M), m -> LeftPower(m, 2) = RightPower(m, 2)));
true

gap> ForAll(AllSmallAntimagmas(3), M -> ForAll(GeneratorsOfMagma(M), m -> LeftPower(m, 2) = RightPower(m, 2)));
true

gap> ForAll(AllSmallAntimagmas(2), M -> HasPropertyA3(M) or HasPropertyA3( TransposedMagma(M) ) );
true

gap> ForAll(AllSmallAntimagmas(3), M -> HasPropertyA3(M) or HasPropertyA3( TransposedMagma(M) ) );
true

gap> ForAny(AllSmallAntimagmas(4), M -> not (HasPropertyA3(M) or HasPropertyA3( TransposedMagma(M) ) ) );
true

gap> Ms_2 := AllSmallAntimagmas(2);;

gap> Ms_3 := AllSmallAntimagmas(3);;

gap> List(Cartesian(Ms_2, Ms_3), M -> IsMagmaIsomorphic(M[1], M[2]));
[ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ]

gap> List(Cartesian(Ms_2, Ms_3), M -> MagmaIsomorphism(M[1], M[2]));
[ fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail, fail ]

gap> GeneratePossibleDiagonals(2);  
[ [ 2, 1 ] ]

gap> GeneratePossibleDiagonals(3);
[ 
    [ 2, 1, 1 ], [ 2, 1, 2 ], 
    [ 2, 3, 1 ], [ 2, 3, 2 ], 
    [ 3, 1, 1 ], [ 3, 1, 2 ], 
    [ 3, 3, 1 ], [ 3, 3, 2 ] 
]

gap> GeneratePossibleDiagonals(4);
[ 
    [ 2, 1, 1, 1 ], [ 2, 1, 1, 2 ], [ 2, 1, 1, 3 ], 
    [ 2, 1, 2, 1 ], [ 2, 1, 2, 2 ], [ 2, 1, 2, 3 ], 
    [ 2, 1, 4, 1 ], [ 2, 1, 4, 2 ], [ 2, 1, 4, 3 ], 
    [ 2, 3, 1, 1 ], [ 2, 3, 1, 2 ], [ 2, 3, 1, 3 ], 
    [ 2, 3, 2, 1 ], [ 2, 3, 2, 2 ], [ 2, 3, 2, 3 ], 
    [ 2, 3, 4, 1 ], [ 2, 3, 4, 2 ], [ 2, 3, 4, 3 ], 
    [ 2, 4, 1, 1 ], [ 2, 4, 1, 2 ], [ 2, 4, 1, 3 ], 
    [ 2, 4, 2, 1 ], [ 2, 4, 2, 2 ], [ 2, 4, 2, 3 ], 
    [ 2, 4, 4, 1 ], [ 2, 4, 4, 2 ], [ 2, 4, 4, 3 ], 
    [ 3, 1, 1, 1 ], [ 3, 1, 1, 2 ], [ 3, 1, 1, 3 ], 
    [ 3, 1, 2, 1 ], [ 3, 1, 2, 2 ], [ 3, 1, 2, 3 ], 
    [ 3, 1, 4, 1 ], [ 3, 1, 4, 2 ], [ 3, 1, 4, 3 ], 
    [ 3, 3, 1, 1 ], [ 3, 3, 1, 2 ], [ 3, 3, 1, 3 ], 
    [ 3, 3, 2, 1 ], [ 3, 3, 2, 2 ], [ 3, 3, 2, 3 ], 
    [ 3, 3, 4, 1 ], [ 3, 3, 4, 2 ], [ 3, 3, 4, 3 ], 
    [ 3, 4, 1, 1 ], [ 3, 4, 1, 2 ], [ 3, 4, 1, 3 ], 
    [ 3, 4, 2, 1 ], [ 3, 4, 2, 2 ], [ 3, 4, 2, 3 ], 
    [ 3, 4, 4, 1 ], [ 3, 4, 4, 2 ], [ 3, 4, 4, 3 ], 
    [ 4, 1, 1, 1 ], [ 4, 1, 1, 2 ], [ 4, 1, 1, 3 ], 
    [ 4, 1, 2, 1 ], [ 4, 1, 2, 2 ], [ 4, 1, 2, 3 ], 
    [ 4, 1, 4, 1 ], [ 4, 1, 4, 2 ], [ 4, 1, 4, 3 ], 
    [ 4, 3, 1, 1 ], [ 4, 3, 1, 2 ], [ 4, 3, 1, 3 ], 
    [ 4, 3, 2, 1 ], [ 4, 3, 2, 2 ], [ 4, 3, 2, 3 ], 
    [ 4, 3, 4, 1 ], [ 4, 3, 4, 2 ], [ 4, 3, 4, 3 ], 
    [ 4, 4, 1, 1 ], [ 4, 4, 1, 2 ], [ 4, 4, 1, 3 ], 
    [ 4, 4, 2, 1 ], [ 4, 4, 2, 2 ], [ 4, 4, 2, 3 ], 
    [ 4, 4, 4, 1 ], [ 4, 4, 4, 2 ], [ 4, 4, 4, 3 ] 
]

gap> STOP_TEST( "test_utils.tst" );

