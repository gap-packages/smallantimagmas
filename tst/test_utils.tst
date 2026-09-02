gap> START_TEST("smallantimagmas: test_utils.tst");

gap> AntimagmaGeneratorPossibleDiagonals(2);  
[[2, 1 ]]

gap> AntimagmaGeneratorPossibleDiagonals(3);
[ 
    [ 2, 1, 1 ], [ 2, 1, 2 ], 
    [ 2, 3, 1 ], [ 2, 3, 2 ], 
    [ 3, 1, 1 ], [ 3, 1, 2 ], 
    [ 3, 3, 1 ], [ 3, 3, 2 ] 
]

gap> AntimagmaGeneratorPossibleDiagonals(4);
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

gap> UpToIsomorphism(AllSmallAntimagmas(3));
[ 
    <magma with 3 generators>, <magma with 3 generators>, <magma with 3 generators>, <magma with 3 generators>, <magma with 3 generators>
]

## Size(UpToIsomorphism(AllSmallAntimagmas(n))) = NrSmallAntimagmas(n)
gap> List([2 .. 3], n -> Size(UpToIsomorphism(AllSmallAntimagmas(n))) = NrSmallAntimagmas(n));
[ true, true ]

## Size(UpToIsomorphismAndAntiisomorphism(AllSmallAntimagmas(n))) = NrSmallAntimagmas(n)
gap> List([2 .. 3], n -> Size(UpToIsomorphismAndAntiisomorphism(AllSmallAntimagmas(n))) = NrSmallAntimagmas(n));
[ true, true ]

## UpToIsomorphismAndAntiisomorphism absorbs TransposedMagma(M) for every M
gap> List([2 .. 3], n -> Size(UpToIsomorphismAndAntiisomorphism(
>        Concatenation(AllSmallAntimagmas(n), List(AllSmallAntimagmas(n), M -> TransposedMagma(M))))));
[ 1, 5 ]

## UpToIsomorphism([]) = []
gap> UpToIsomorphism([]);
[  ]

## UpToIsomorphismAndAntiisomorphism([]) = []
gap> UpToIsomorphismAndAntiisomorphism([]);
[  ]

gap> STOP_TEST("test_utils.tst");

