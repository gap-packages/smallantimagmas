gap> START_TEST("test_properties_magma_index_period_profile.tst");

## IndexPeriodProfile(M) is the unordered pair of the collected left and right index-periods
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> IndexPeriodProfile(M)
>        = Set([Collected(List(M, LeftIndexPeriod)), Collected(List(M, RightIndexPeriod))]));
true

## IndexPeriodProfile(M) = IndexPeriodProfile(TransposedMagma(M))
gap> ForAll(AllSmallAntimagmas([2 .. 4]), M -> IndexPeriodProfile(M) = IndexPeriodProfile(TransposedMagma(M)));
true

## IndexPeriodProfile(M) is an isomorphism invariant
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> ForAll(SymmetricGroup(Size(M)), p ->
>        IndexPeriodProfile(M) = IndexPeriodProfile(MagmaByMultiplicationTable(
>            List([1 .. Size(M)], i -> List([1 .. Size(M)], j -> MultiplicationTable(M)[i / p][j / p] ^ p))))));
true

## IndexPeriodProfileTypes(magmas) lists each profile once, in the order of GAP lists
gap> ForAll([2 .. 4], n -> IsSet(IndexPeriodProfileTypes(AllSmallAntimagmas(n))));
true

## the number of profiles at orders 2, 3 and 4
gap> List([2 .. 4], n -> Size(IndexPeriodProfileTypes(AllSmallAntimagmas(n, "up-to-isomorphism"))));
[ 1, 5, 535 ]

## the library representatives and their transposes have the same profiles
gap> ForAll([2 .. 4], n -> IndexPeriodProfileTypes(AllSmallAntimagmas(n))
>        = IndexPeriodProfileTypes(AllSmallAntimagmas(n, "up-to-isomorphism")));
true

## IndexPeriodProfileTypes(magmas) rejects a list that is not of magmas
gap> IndexPeriodProfileTypes([1, 2]);
Error, smallantimagmas: <magmas> must be a list of magmas

gap> STOP_TEST("test_properties_magma_index_period_profile.tst");
