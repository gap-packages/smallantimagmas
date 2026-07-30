gap> START_TEST("test_helper_deranged.tst");

## brute-force-definition-used-as-oracle-throughout-this-file
gap> BruteForceLeftDeranged := function(M)
> return ForAny(PartitionsSet(Elements(M)), p ->
>     ForAny(Derangements(p), d ->
>         ForAll([1 .. Size(p)], i ->
>             ForAll(p[i], m -> IsSubset(d[i], Unique(m * Elements(M)))))));
> end;;
gap> LeftDerangedOfTable := T ->
> IsLeftDerangementInducted(MagmaByMultiplicationTable(T));;

## paper-8-element-magma-is-left-deranged
gap> T := [[7, 3, 3, 7, 7, 3, 7, 7], [8, 8, 8, 8, 8, 8, 8, 8],
> [1, 1, 6, 1, 6, 6, 6, 1], [7, 7, 5, 7, 5, 7, 7, 5],
> [4, 6, 4, 4, 6, 6, 4, 6], [5, 3, 5, 3, 5, 3, 5, 5],
> [1, 4, 4, 1, 1, 4, 4, 1], [2, 2, 2, 2, 2, 2, 2, 2]];;
gap> LeftDerangedOfTable(T);
true

## edge-cases
gap> LeftDerangedOfTable([[1, 2], [2, 1]]);
false
gap> LeftDerangedOfTable([[2, 2], [1, 1]]);
true
gap> LeftDerangedOfTable([[2, 1], [2, 1]]);
false
gap> IsRightDerangementInducted(MagmaByMultiplicationTable([[2, 1], [2, 1]]));
true
gap> LeftDerangedOfTable([[1]]);
false

## cross-validation-against-brute-force-exhaustive-order-2-and-3
gap> ForAll([2, 3], n -> ForAll(Tuples(Tuples([1 .. n], n), n),
> t -> LeftDerangedOfTable(List(t, ShallowCopy))
> = BruteForceLeftDeranged(
> MagmaByMultiplicationTable(List(t, ShallowCopy)))));
true

## cross-validation-against-brute-force-random-order-4-and-5
gap> state := State(GlobalMersenneTwister);;
gap> Init(GlobalMersenneTwister, 42);;
gap> RandomTable := n -> List([1 .. n],
> r -> List([1 .. n], c -> Random(GlobalMersenneTwister, [1 .. n])));;
gap> tables := List([1 .. 200], i -> RandomTable(4));;
gap> ForAll(tables, t -> LeftDerangedOfTable(t)
> = BruteForceLeftDeranged(MagmaByMultiplicationTable(t)));
true
gap> tables := List([1 .. 50], i -> RandomTable(5));;
gap> ForAll(tables, t -> LeftDerangedOfTable(t)
> = BruteForceLeftDeranged(MagmaByMultiplicationTable(t)));
true

## cross-validation-on-all-small-antimagmas-of-order-4
gap> ForAll(AllSmallAntimagmas(4), M -> IsLeftDerangementInducted(M)
> = BruteForceLeftDeranged(M));
true
gap> ForAll(AllSmallAntimagmas(4), M -> IsRightDerangementInducted(M)
> = BruteForceLeftDeranged(TransposedMagma(M)));
true

## performance-100-runs-of-new-implementation-beat-a-single-brute-force-run
## fixed-point-free but non-deranged order-7 table, so brute force must
## exhaust all 17394 (partition, derangement) pairs
gap> T := [[3, 3, 2, 5, 5, 3, 7], [3, 4, 7, 5, 1, 5, 1],
> [4, 7, 2, 6, 1, 2, 6], [2, 3, 1, 6, 2, 3, 5],
> [4, 7, 4, 7, 7, 2, 3], [2, 5, 4, 5, 1, 7, 3],
> [4, 4, 5, 2, 5, 6, 6]];;
gap> t0 := Runtime();;
gap> results := List([1 .. 100], i -> LeftDerangedOfTable(T));;
gap> timeNew := Runtime() - t0;;
gap> t0 := Runtime();;
gap> resultBrute := BruteForceLeftDeranged(MagmaByMultiplicationTable(T));;
gap> timeBrute := Runtime() - t0;;
gap> Set(results) = [resultBrute];
true
gap> resultBrute;
false
gap> timeNew < timeBrute;
true

## order-50-far-beyond-brute-force-reach
## random rows drawn from [1 .. n] minus the row index, so m*M is
## anything besides m and the necessary condition m not in m*M holds
gap> n := 50;;
gap> RandomFpfTable := n -> List([1 .. n], m -> List([1 .. n],
> j -> Random(GlobalMersenneTwister, Difference([1 .. n], [m]))));;
gap> tables := List([1 .. 5], i -> RandomFpfTable(n));;
gap> ForAll(tables, T -> ForAll([1 .. n], m -> not m in Set(T[m])));
true
gap> List(tables, LeftDerangedOfTable);
[ false, false, false, false, false ]
gap> Reset(GlobalMersenneTwister, state);;

gap> STOP_TEST("test_helper_deranged.tst");
