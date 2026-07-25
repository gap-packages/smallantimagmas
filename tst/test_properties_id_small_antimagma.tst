gap> START_TEST("test_properties_id_small_antimagma.tst");

gap> List(AllSmallAntimagmas(2), IdSmallAntimagma);
[ [ 2, 1 ] ]

gap> List(AllSmallAntimagmas(3), IdSmallAntimagma);
[ [ 3, 1 ], [ 3, 2 ], [ 3, 3 ], [ 3, 4 ], [ 3, 5 ] ]

gap> IdSmallAntimagma(MagmaByMultiplicationTable([[2, 1], [2, 1]]));
[ 2, 1 ]

gap> ForAll(AllSmallAntimagmas(3), M -> IdSmallAntimagma(TransposedMagma(M)) = IdSmallAntimagma(M));
true

gap> tables := List(Tuples(Tuples([1 .. 3], 3), 3), t -> List(t, ShallowCopy));;
gap> antimagmas := Filtered(tables, T -> IsAntiassociative(MagmaByMultiplicationTable(T)));;
gap> Size(antimagmas);
52

gap> ids := List(antimagmas, T -> IdSmallAntimagma(MagmaByMultiplicationTable(T)));;
gap> Collected(ids);
[ [ [ 3, 1 ], 12 ], [ [ 3, 2 ], 12 ], [ [ 3, 3 ], 12 ], [ [ 3, 4 ], 12 ], [ [ 3, 5 ], 4 ] ]

gap> Set(ids) = List([1 .. NrSmallAntimagmas(3)], k -> [3, k]);
true

gap> STOP_TEST("test_properties_id_small_antimagma.tst");
