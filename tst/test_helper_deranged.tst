gap> START_TEST("test_helper_deranged.tst");

## brute-force-definition-used-as-oracle-throughout-this-file
gap> BruteForceLeftDeranged := function(M)
> return ForAny(PartitionsSet(Elements(M)), p ->
>     ForAny(Derangements(p), d ->
>         ForAll([1 .. Size(p)], i ->
>             ForAll(p[i], m -> IsSubset(d[i], Unique(m * Elements(M)))))));
> end;;

## paper-8-element-magma-is-left-deranged
gap> M := MagmaByMultiplicationTable([[7, 3, 3, 7, 7, 3, 7, 7],
> [8, 8, 8, 8, 8, 8, 8, 8], [1, 1, 6, 1, 6, 6, 6, 1],
> [7, 7, 5, 7, 5, 7, 7, 5], [4, 6, 4, 4, 6, 6, 4, 6],
> [5, 3, 5, 3, 5, 3, 5, 5], [1, 4, 4, 1, 1, 4, 4, 1],
> [2, 2, 2, 2, 2, 2, 2, 2]]);;
gap> IsLeftDerangementInducted(M);
true

## edge-cases
gap> IsLeftDerangementInducted(MagmaByMultiplicationTable([[1, 2], [2, 1]]));
false
gap> IsLeftDerangementInducted(MagmaByMultiplicationTable([[2, 2], [1, 1]]));
true
gap> M := MagmaByMultiplicationTable([[2, 1], [2, 1]]);;
gap> IsLeftDerangementInducted(M);
false
gap> IsRightDerangementInducted(M);
true
gap> IsLeftDerangementInducted(MagmaByMultiplicationTable([[1]]));
false

## cross-validation-against-brute-force-exhaustive-order-2-and-3
gap> ForAll([2, 3], n -> ForAll(Tuples(Tuples([1 .. n], n), n),
> function(t)
>     local M;
>     M := MagmaByMultiplicationTable(List(t, ShallowCopy));
>     return IsLeftDerangementInducted(M) = BruteForceLeftDeranged(M);
> end));
true

## cross-validation-against-brute-force-random-order-4-and-5
gap> state := State(GlobalMersenneTwister);;
gap> Init(GlobalMersenneTwister, 42);;
gap> RandomMagma := n -> MagmaByMultiplicationTable(List([1 .. n],
> r -> List([1 .. n], c -> Random(GlobalMersenneTwister, [1 .. n]))));;
gap> magmas := List([1 .. 200], i -> RandomMagma(4));;
gap> ForAll(magmas,
> M -> IsLeftDerangementInducted(M) = BruteForceLeftDeranged(M));
true
gap> magmas := List([1 .. 50], i -> RandomMagma(5));;
gap> ForAll(magmas,
> M -> IsLeftDerangementInducted(M) = BruteForceLeftDeranged(M));
true

## cross-validation-on-all-small-antimagmas-of-order-4
gap> ForAll(AllSmallAntimagmas(4), M -> IsLeftDerangementInducted(M)
> = BruteForceLeftDeranged(M));
true
gap> ForAll(AllSmallAntimagmas(4), M -> IsRightDerangementInducted(M)
> = BruteForceLeftDeranged(TransposedMagma(M)));
true

## performance-100-runs-of-new-implementation-beat-a-single-brute-force-run
## fixed-point-free but non-deranged order-7 magma, so brute force must
## exhaust all 17394 (partition, derangement) pairs; 100 fresh copies of
## the magma are prepared upfront so property caching cannot short-cut
## the timed runs
gap> T := [[3, 3, 2, 5, 5, 3, 7], [3, 4, 7, 5, 1, 5, 1],
> [4, 7, 2, 6, 1, 2, 6], [2, 3, 1, 6, 2, 3, 5],
> [4, 7, 4, 7, 7, 2, 3], [2, 5, 4, 5, 1, 7, 3],
> [4, 4, 5, 2, 5, 6, 6]];;
gap> magmas := List([1 .. 100], i -> MagmaByMultiplicationTable(T));;
gap> t0 := Runtime();;
gap> results := List(magmas, IsLeftDerangementInducted);;
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
gap> RandomFpfMagma := n -> MagmaByMultiplicationTable(List([1 .. n],
> m -> List([1 .. n],
> j -> Random(GlobalMersenneTwister, Difference([1 .. n], [m])))));;
gap> magmas := List([1 .. 5], i -> RandomFpfMagma(n));;
gap> ForAll(magmas, M -> ForAll(M, m -> not m in Set(m * Elements(M))));
true
gap> List(magmas, IsLeftDerangementInducted);
[ false, false, false, false, false ]
gap> Reset(GlobalMersenneTwister, state);;

gap> STOP_TEST("test_helper_deranged.tst");
