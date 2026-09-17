gap> START_TEST("test_properties_magma_constant_translations.tst");

## constant rows are constant left translations, constant columns right ones
gap> M := MagmaByMultiplicationTable([[2, 2, 2], [3, 1, 2], [3, 1, 1]]);;
gap> NrConstantLeftTranslations(M);
1
gap> NrConstantRightTranslations(M);
0
gap> NrConstantLeftTranslations(TransposedMagma(M));
0
gap> NrConstantRightTranslations(TransposedMagma(M));
1

## a constant table has every translation constant
gap> NrConstantLeftTranslations(MagmaByMultiplicationTable([[1, 1], [1, 1]]));
2
gap> NrConstantRightTranslations(MagmaByMultiplicationTable([[1, 1], [1, 1]]));
2

## transposition swaps the two numbers
gap> ForAll(AllSmallAntimagmas([2 .. 4]), M ->
>     [NrConstantLeftTranslations(M), NrConstantRightTranslations(M)]
>     = [NrConstantRightTranslations(TransposedMagma(M)),
>        NrConstantLeftTranslations(TransposedMagma(M))]);
true

## an antimagma never has both a constant row and a constant column
gap> ForAll(AllSmallAntimagmas([2 .. 4]), M ->
>     NrConstantLeftTranslations(M) = 0 or NrConstantRightTranslations(M) = 0);
true

## every translation constant is the fixed-point free inducted case
gap> ForAll(AllSmallAntimagmas([2 .. 4]), M ->
>     (NrConstantLeftTranslations(M) = Size(M)) = IsLeftFPFInducted(M)
>     and (NrConstantRightTranslations(M) = Size(M)) = IsRightFPFInducted(M));
true

## the pairs of order 4, one per isomorphism class
gap> Collected(List(AllSmallAntimagmas(4, "up-to-isomorphism"),
>     M -> [NrConstantLeftTranslations(M), NrConstantRightTranslations(M)]));
[ [ [ 0, 0 ], 10154 ], [ [ 0, 1 ], 2925 ], [ [ 0, 2 ], 767 ],
  [ [ 0, 3 ], 115 ], [ [ 0, 4 ], 6 ], [ [ 1, 0 ], 2925 ], [ [ 2, 0 ], 767 ],
  [ [ 3, 0 ], 115 ], [ [ 4, 0 ], 6 ] ]

## the classification lists every pair antiassociativity allows, in this order
gap> C := SmallAntimagmaClassification(AllSmallAntimagmas(3, "up-to-isomorphism"), "constant");;
gap> C!.tables[1].headers;
[ "(0,0)", "(1,0)", "(2,0)", "(3,0)", "(0,1)", "(0,2)", "(0,3)" ]

gap> STOP_TEST("test_properties_magma_constant_translations.tst");
