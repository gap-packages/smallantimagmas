gap> START_TEST("tst_classification.tst");

## SmallAntimagmaClassification(magmas) rejects an empty list
gap> SmallAntimagmaClassification([]);
Error, smallantimagmas: <magmas> must be a non-empty list

## SmallAntimagmaClassification(magmas, by) rejects an unknown invariant
gap> SmallAntimagmaClassification(AllSmallAntimagmas(2), "nope");
Error, smallantimagmas: <by> must be one of all, diagonal, cancellativity, cancellativity-degree, commutativity, translation, product-set, rank, index-period, mediality, constant, squares

## SmallAntimagmaClassification(magmas, by) rejects a non-string invariant
gap> SmallAntimagmaClassification(AllSmallAntimagmas(2), 7);
Error, smallantimagmas: expected (<magmas>) or (<magmas>, <by>)

## SmallAntimagmasInformation(n, by) rejects a non-integer order
gap> SmallAntimagmasInformation("4");
Error, smallantimagmas: <order> must be an integer

## SmallAntimagmasInformation(n, by) rejects an unknown invariant
gap> SmallAntimagmasInformation(2, "nope");
Error, smallantimagmas: <by> must be one of all, diagonal, cancellativity, cancellativity-degree, commutativity, translation, product-set, rank, index-period, mediality, constant, squares

## a classification views as the number of classes it holds
gap> SmallAntimagmaClassification(AllSmallAntimagmas(3, "up-to-isomorphism"));
<classification of 10 isomorphism classes>

## every possible diagonal belongs to exactly one type
gap> ForAll([2 .. 4], n -> ForAll(AntimagmaGeneratorPossibleDiagonals(n),
>     d -> Number(DiagonalDigraphTypes(n), D -> IsIsomorphicDigraph(D,
>         DigraphByEdges(List([1 .. n], i -> [i, d[i]])))) = 1));
true

## every antimagma has exactly one type of translation profile
gap> ForAll([2 .. 4], function(n)
>     local types;
>     types := TranslationProfileTypes(n);
>     return ForAll(AllSmallAntimagmas(n, "up-to-isomorphism"),
>         M -> Number(types, T -> T = SortedList(TranslationProfile(M))) = 1);
> end);
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

## the commutativity columns are exactly the values that occur
gap> C := SmallAntimagmaClassification(AllSmallAntimagmas(2, "up-to-isomorphism"), "commutativity");;
gap> C!.tables[1].headers;
[ "0" ]
gap> Display(SmallAntimagmaClassification(AllSmallAntimagmas(3, "up-to-isomorphism"), "commutativity"));
Classified by the commutativity index:
---------------------------------
Counted objects     Total    0  1
---------------------------------
Iso+antiiso classes     5    1  4
---------------------------------
Isomorphism classes    10    2  8
.................................
2-iso classes           2    2  0
6-iso classes           8    0  8
---------------------------------
Labelled magmas        52    4 48
---------------------------------

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

## SmallAntimagmaClassification(magmas, by) classifies by the product set size
gap> Display(SmallAntimagmaClassification(AllSmallAntimagmas(3, "up-to-isomorphism"), "product-set"));
Classified by the size of the product set M * M:
------------------------------------------
Counted objects     Total    |MM|=2 |MM|=3
------------------------------------------
Iso+antiiso classes     5         1      4
------------------------------------------
Isomorphism classes    10         2      8
..........................................
2-iso classes           2         0      2
6-iso classes           8         2      6
------------------------------------------
Labelled magmas        52        12     40
------------------------------------------

## SmallAntimagmaClassification(magmas, "index-period") names the profiles in the order of IndexPeriodProfileTypes
gap> Ms := AllSmallAntimagmas(3, "up-to-isomorphism");;
gap> Display(SmallAntimagmaClassification(Ms, "index-period"));
Classified by the index-period profile:
------------------------------------------------
Counted objects     Total    P_1 P_2 P_3 P_4 P_5
------------------------------------------------
Iso+antiiso classes     5      1   1   1   1   1
------------------------------------------------
Isomorphism classes    10      2   2   2   2   2
................................................
2-iso classes           2      0   0   0   0   2
6-iso classes           8      2   2   2   2   0
------------------------------------------------
Labelled magmas        52     12  12  12  12   4
------------------------------------------------
gap> List(Ms, M -> Position(IndexPeriodProfileTypes(Ms), IndexPeriodProfile(M)));
[ 3, 3, 4, 4, 1, 1, 2, 2, 5, 5 ]

## the columns follow the magmas given, so a subset has fewer of them
gap> Display(SmallAntimagmaClassification(Filtered(Ms, IsLeftCyclic), "index-period"));
Classified by the index-period profile:
--------------------------------
Counted objects     Total    P_1
--------------------------------
Isomorphism classes     1      1
................................
2-iso classes           1      1
--------------------------------
Labelled magmas         2      2
--------------------------------

## SmallAntimagmaClassification(magmas) rejects a non-list
gap> SmallAntimagmaClassification(4);
Error, smallantimagmas: <magmas> must be a non-empty list

gap> STOP_TEST("tst_classification.tst");
