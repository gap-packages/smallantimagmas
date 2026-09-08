gap> START_TEST("test_classification_tables.tst");

## one classification per order, reused by every check below
gap> orders := [2 .. 4];;
gap> Cs := List(orders, n -> SmallAntimagmaClassification(AllSmallAntimagmas(n, "up-to-isomorphism")));;

## every table counts the labelled magmas of its order
gap> ForAll([1 .. Size(orders)], i -> ForAll(Cs[i]!.tables,
>     T -> Sum(First(T.rows, row -> row[1] = "Labelled magmas")[2])
>          = NrSmallAntimagmas(orders[i], "labelled")));
true

## in every table the class rows add up to the isomorphism classes counted
gap> ForAll([1 .. Size(orders)], i -> ForAll(Cs[i]!.tables, function(T)
>     local counts;
>     counts := First(T.rows, row -> row[1] = "Isomorphism classes")[2];
>     return Sum(counts) = NrSmallAntimagmas(orders[i], "up-to-isomorphism")
>            and Sum(Filtered(T.rows, row -> row[1] <> "Labelled magmas"
>                and row[1] <> "Isomorphism classes"
>                and row[1] <> "Iso+antiiso classes"), row -> Sum(row[2])) = Sum(counts);
> end));
true

## the iso+antiiso row counts what the library stores, when it is shown at all
gap> ForAll([1 .. Size(orders)], i -> ForAll(Cs[i]!.tables,
>     T -> not ForAny(T.rows, row -> row[1] = "Iso+antiiso classes")
>          or Sum(First(T.rows, row -> row[1] = "Iso+antiiso classes")[2])
>             = NrSmallAntimagmas(orders[i])));
true

gap> STOP_TEST("test_classification_tables.tst");
