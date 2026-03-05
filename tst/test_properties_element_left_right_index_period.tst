gap> START_TEST("test_properties_element_left_right_index_period.tst");

gap> BruteRightIndexPeriod := function(m)
> local i, n, p;
> n := Size(Parent(m));
> for i in [1 .. n ^ 2] do
>   for p in [1 .. n ^ 2] do
>     if RightPower(m, i + p) = RightPower(m, i) then
>       return [i, p];
>     fi;
>   od;
> od;
> end;
function( m ) ... end

gap> BruteLeftIndexPeriod := function(m)
> local M, T, em, pos;
> M := Parent(m);
> T := TransposedMagma(M);
> em := Elements(M);
> pos := Position(em, m);
> return BruteRightIndexPeriod(Elements(T)[pos]);
> end;
function( m ) ... end

gap> ForAll(AllSmallGroups([1 .. 10]), G -> ForAll(Elements(G), g -> LeftIndexPeriod(g) = [1, Order(g)]));
true

gap> ForAll(AllSmallGroups([1 .. 10]), G -> ForAll(Elements(G), g -> RightIndexPeriod(g) = [1, Order(g)]));
true

gap> G := SmallGroup(1, 1);;
gap> LeftIndexPeriod(One(G));
[ 1, 1 ]
gap> RightIndexPeriod(One(G));
[ 1, 1 ]

gap> ForAll(AllSmallGroups([1 .. 10]), G -> ForAll(Elements(G), g -> LeftIndexPeriod(g) = BruteLeftIndexPeriod(g)));
true

gap> ForAll(AllSmallGroups([1 .. 10]), function(G)
> local T, eg, et;
> T := TransposedMagma(G);
> eg := Elements(G);
> et := Elements(T);
> return ForAll([1 .. Length(eg)], i -> LeftIndexPeriod(eg[i]) = RightIndexPeriod(et[i]));
> end);
true

gap> ForAll(AllSmallAntimagmas([2 .. 3]), function(M)
> local T, em, et;
> T := TransposedMagma(M);
> em := Elements(M);
> et := Elements(T);
> return ForAll([1 .. Length(em)], i -> LeftIndexPeriod(em[i]) = RightIndexPeriod(et[i]));
> end);
true

gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> ForAll(Elements(M), m -> RightIndexPeriod(m) = BruteRightIndexPeriod(m)));
true

gap> ForAny(AllSmallAntimagmas([2 .. 3]), M -> ForAny(Elements(M), m -> LeftIndexPeriod(m) <> RightIndexPeriod(m)));
true

gap> STOP_TEST("test_properties_element_left_right_index_period.tst");
