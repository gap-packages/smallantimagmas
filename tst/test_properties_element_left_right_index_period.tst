gap> START_TEST("test_properties_element_left_right_index_period.tst");

gap> BruteLeftIndexPeriod := function(m)
> local i, p;
> for i in [1 .. 100] do
>   for p in [1 .. 100] do
>     if LeftPower(m, i + p) = LeftPower(m, i) then
>       return [i, p];
>     fi;
>   od;
> od;
> end;
function( m ) ... end

gap> BruteRightIndexPeriod := function(m)
> local i, p;
> for i in [1 .. 100] do
>   for p in [1 .. 100] do
>     if RightPower(m, i + p) = RightPower(m, i) then
>       return [i, p];
>     fi;
>   od;
> od;
> end;
function( m ) ... end

gap> ForAll(AllSmallGroups([2 .. 10]), G -> ForAll(Elements(G), g -> LeftIndexPeriod(g) = [1, Order(g)]));
true

gap> ForAll(AllSmallGroups([2 .. 10]), G -> ForAll(Elements(G), g -> RightIndexPeriod(g) = [1, Order(g)]));
true

gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> ForAll(Elements(M), m -> LeftIndexPeriod(m) = BruteLeftIndexPeriod(m)));
true

gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> ForAll(Elements(M), m -> RightIndexPeriod(m) = BruteRightIndexPeriod(m)));
true

gap> ForAny(AllSmallAntimagmas([2 .. 3]), M -> ForAny(Elements(M), m -> LeftIndexPeriod(m) <> RightIndexPeriod(m)));
true

gap> STOP_TEST("test_properties_element_left_right_index_period.tst");
