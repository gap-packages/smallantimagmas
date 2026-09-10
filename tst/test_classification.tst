gap> START_TEST("test_classification.tst");

## SmallAntimagmaClassification(magmas) rejects an empty list
gap> SmallAntimagmaClassification([]);
Error, smallantimagmas: <magmas> must be a non-empty list

## SmallAntimagmaClassification(magmas, by) rejects an unknown invariant
gap> SmallAntimagmaClassification(AllSmallAntimagmas(2), "nope");
Error, smallantimagmas: <by> must be one of all, diagonal, cancellativity, cancellativity-degree

## SmallAntimagmaClassification(magmas, by) rejects a non-string invariant
gap> SmallAntimagmaClassification(AllSmallAntimagmas(2), 7);
Error, smallantimagmas: expected (<magmas>) or (<magmas>, <by>)

## SmallAntimagmasInformation(n, by) rejects a non-integer order
gap> SmallAntimagmasInformation("4");
Error, smallantimagmas: <order> must be an integer

## SmallAntimagmasInformation(n, by) rejects an unknown invariant
gap> SmallAntimagmasInformation(2, "nope");
Error, smallantimagmas: <by> must be one of all, diagonal, cancellativity, cancellativity-degree

## a classification views as the number of classes it holds
gap> SmallAntimagmaClassification(AllSmallAntimagmas(3, "up-to-isomorphism"));
<classification of 10 isomorphism classes>

## every possible diagonal belongs to exactly one type
gap> ForAll([2 .. 4], n -> ForAll(AntimagmaGeneratorPossibleDiagonals(n),
>     d -> Number(DiagonalDigraphTypes(n), D -> IsIsomorphicDigraph(D,
>         DigraphByEdges(List([1 .. n], i -> [i, d[i]])))) = 1));
true

## the row is left out when the transposes are not all present
gap> C := SmallAntimagmaClassification(
>          Filtered(AllSmallAntimagmas(3, "up-to-isomorphism"), IsLeftDerangementInducted));;
gap> ForAny(C!.tables[1].rows, row -> row[1] = "Iso+antiiso classes");
false

## SmallAntimagmasInformation(n, by) narrows the report to one invariant
gap> SmallAntimagmasInformation(2, "cancellativity");
-------------------------------------------
Antiassociative magmas of order 2     Total
-------------------------------------------
up to isomorphism and antiisomorphism     1
up to isomorphism                         2
labelled                                  2
-------------------------------------------

Classified by left and right cancellativity:
----------------------------------------------------
Counted objects     Total    neither left right both
----------------------------------------------------
Isomorphism classes     2          0    1     1    0
....................................................
1-iso classes           2          0    1     1    0
----------------------------------------------------
Labelled magmas         2          0    1     1    0
----------------------------------------------------

## the degree table's columns are the degrees the magmas attain, in order
gap> C := SmallAntimagmaClassification(AllSmallAntimagmas(3, "up-to-isomorphism"), "cancellativity-degree");;
gap> C!.tables[1].headers;
[ "(0,0)", "(0,3)", "(3,0)" ]
gap> Display(C);
Classified by the cancellativity degree:
----------------------------------------------
Counted objects     Total    (0,0) (0,3) (3,0)
----------------------------------------------
Isomorphism classes    10        8     1     1
..............................................
2-iso classes           2        0     1     1
6-iso classes           8        8     0     0
----------------------------------------------
Labelled magmas        52       48     2     2
----------------------------------------------

## the degree table refines the cancellativity table: summing the degree
## columns with a full left count gives the "left" column, and so on
gap> C := SmallAntimagmaClassification(AllSmallAntimagmas(4, "up-to-isomorphism"),
>          "cancellativity-degree");;
gap> T := C!.tables[1];;
gap> JoinStringsWithSeparator(T.headers, " ");
"(0,0) (0,1) (0,2) (0,3) (0,4) (1,0) (1,1) (2,0) (3,0) (4,0)"
gap> D := SmallAntimagmaClassification(AllSmallAntimagmas(4, "up-to-isomorphism"),
>          "cancellativity")!.tables[1];;
gap> degreesOf := List(T.headers, h -> List(SplitString(h{[2 .. Size(h) - 1]}, ","), Int));;
gap> coarsen := row -> List([[false, false], [true, false], [false, true], [true, true]],
>     flags -> Sum(Filtered([1 .. Size(row)],
>         i -> [degreesOf[i][1] = 4, degreesOf[i][2] = 4] = flags), i -> row[i], 0));;
gap> ForAll([1 .. Size(T.rows)], i -> T.rows[i][1] = D.rows[i][1]
>     and coarsen(T.rows[i][2]) = D.rows[i][2]);
true
gap> First(T.rows, row -> row[1] = "Isomorphism classes")[2];
[ 5906, 3665, 1839, 392, 40, 3665, 2, 1839, 392, 40 ]
gap> First(T.rows, row -> row[1] = "Labelled magmas")[2];
[ 138798, 87960, 43212, 9408, 777, 87960, 48, 43212, 9408, 777 ]

## SmallAntimagmaClassification(magmas) rejects a non-list
gap> SmallAntimagmaClassification(4);
Error, smallantimagmas: <magmas> must be a non-empty list

gap> STOP_TEST("test_classification.tst");
