gap> START_TEST("test_classification.tst");

## SmallAntimagmaClassification(magmas) rejects an empty list
gap> SmallAntimagmaClassification([]);
Error, smallantimagmas: <magmas> must be a non-empty list

## SmallAntimagmaClassification(magmas, by) rejects an unknown invariant
gap> SmallAntimagmaClassification(AllSmallAntimagmas(2), "nope");
Error, smallantimagmas: <by> must be one of all, diagonal, cancellativity, index-period

## SmallAntimagmaClassification(magmas, by) rejects a non-string invariant
gap> SmallAntimagmaClassification(AllSmallAntimagmas(2), 7);
Error, smallantimagmas: expected (<magmas>) or (<magmas>, <by>)

## SmallAntimagmasInformation(n, by) rejects a non-integer order
gap> SmallAntimagmasInformation("4");
Error, smallantimagmas: <order> must be an integer

## SmallAntimagmasInformation(n, by) rejects an unknown invariant
gap> SmallAntimagmasInformation(2, "nope");
Error, smallantimagmas: <by> must be one of all, diagonal, cancellativity, index-period

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

gap> STOP_TEST("test_classification.tst");
