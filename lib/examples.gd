#! @Chapter Examples
#!
#! @Section Classification by diagonal digraph
#!
#! The diagonal digraph <M>\Gamma</M> of a magma <M>M</M> is the digraph of the
#! map <M>x \mapsto x * x</M>, and its isomorphism type is a coarse invariant of
#! <M>M</M>. This section classifies the antiassociative magmas of orders 2, 3
#! and 4 by that type, reproducing at order 4
#! <Cite Key="MazurekZabielski2025" Where="Tables 1, 2 and 3"/>.
#!
#! The classification counts magmas up to isomorphism, while
#! <Ref Func="AllSmallAntimagmas"/> keeps one representative per class of magmas
#! that are isomorphic <E>or</E> antiisomorphic. An antiisomorphism
#! <M>M \to N</M> is an isomorphism <M>M^{op} \to N</M>, and a composite of two
#! antiisomorphisms is an isomorphism, so such a class is
#! <M>[M] \cup [M^{op}]</M>: it splits into the isomorphism class of <M>M</M>
#! and the one of its transpose, and into nothing else.
#! <C>AllSmallAntimagmas(n, "up-to-isomorphism")</C> performs that split.
#!
#! @BeginExampleSession
#! gap> List([2 .. 4], NrSmallAntimagmas);
#! [ 1, 5, 8891 ]
#! gap> List([2 .. 4], n -> NrSmallAntimagmas(n, "up-to-isomorphism"));
#! [ 2, 10, 17780 ]
#! gap> List([2 .. 4], n -> NrSmallAntimagmas(n, "labelled"));
#! [ 2, 52, 421560 ]
#! @EndExampleSession
#!
#! The columns of every table below are the types listed by
#! <Ref Oper="DiagonalDigraphTypes" Label="for IsPosInt"/>, each named by the
#! least diagonal that induces it.
#!
#! @Section Orders 2 and 3
#!
#! At order 2 there is one type of diagonal digraph, and the two isomorphism
#! classes hold a single magma each, both being invariant under the one
#! non-trivial relabelling.
#!
#! @BeginExampleSession
#! gap> List(DiagonalDigraphTypes(2), OutNeighbours);
#! [ [ [ 2 ], [ 1 ] ] ]
#! gap> Display(SmallAntimagmaClassification(
#! >        AllSmallAntimagmas(2, "up-to-isomorphism"), "diagonal"));
#! Classified by the isomorphism type of the diagonal digraph:
#! ------------------------------------
#! Counted objects     Total    Gamma_1
#! ------------------------------------
#! Iso+antiiso classes     1          1
#! ------------------------------------
#! Isomorphism classes     2          2
#! ....................................
#! 1-iso classes           2          2
#! ------------------------------------
#! Labelled magmas         2          2
#! ------------------------------------
#! @EndExampleSession
#!
#! At order 3 there are two types, the 2-cycle with a tail and the 3-cycle.
#!
#! @BeginExampleSession
#! gap> List(DiagonalDigraphTypes(3), OutNeighbours);
#! [ [ [ 2 ], [ 1 ], [ 1 ] ], [ [ 2 ], [ 3 ], [ 1 ] ] ]
#! gap> Ms := AllSmallAntimagmas(3, "up-to-isomorphism");;
#! gap> Display(SmallAntimagmaClassification(Ms, "diagonal"));
#! Classified by the isomorphism type of the diagonal digraph:
#! --------------------------------------------
#! Counted objects     Total    Gamma_1 Gamma_2
#! --------------------------------------------
#! Iso+antiiso classes     5          4       1
#! --------------------------------------------
#! Isomorphism classes    10          8       2
#! ............................................
#! 2-iso classes           2          0       2
#! 6-iso classes           8          8       0
#! --------------------------------------------
#! Labelled magmas        52         48       4
#! --------------------------------------------
#! @EndExampleSession
#!
#! Both orders are small enough to enumerate outright, which confirms that the
#! library together with the transpose accounts for every antiassociative magma
#! and counts none of them twice.
#!
#! @BeginExampleSession
#! gap> BruteForce := n -> Filtered(Tuples(Tuples([1 .. n], n), n),
#! >        T -> IsAntiassociative(MagmaByMultiplicationTable(List(T, ShallowCopy))));;
#! gap> List([2, 3], n -> Size(BruteForce(n)));
#! [ 2, 52 ]
#! gap> List([2, 3], n -> Set(BruteForce(n))
#! >                      = Set(AllSmallAntimagmas(n, "labelled"), MultiplicationTable));
#! [ true, true ]
#! @EndExampleSession
#!
#! Half of the order-3 classes are deranged, in the sense of
#! <Ref Prop="IsLeftDerangementInducted" Label="for IsMagma"/>, and the other
#! half are op-deranged, that is deranged after transposition; no magma of order
#! 2 or 3 is neither.
#!
#! @BeginExampleSession
#! gap> Display(SmallAntimagmaClassification(
#! >        Filtered(Ms, IsLeftDerangementInducted), "diagonal"));
#! Classified by the isomorphism type of the diagonal digraph:
#! --------------------------------------------
#! Counted objects     Total    Gamma_1 Gamma_2
#! --------------------------------------------
#! Isomorphism classes     5          4       1
#! ............................................
#! 2-iso classes           1          0       1
#! 6-iso classes           4          4       0
#! --------------------------------------------
#! Labelled magmas        26         24       2
#! --------------------------------------------
#! gap> Number(Ms, M -> not IsLeftDerangementInducted(M)
#! >                         and not IsRightDerangementInducted(M));
#! 0
#! @EndExampleSession
#!
#! @Section Order 4
#!
#! At order 4 there are six types of diagonal digraph, the digraphs
#! <M>\Gamma_1, \ldots, \Gamma_6</M> pictured in
#! <Cite Key="MazurekZabielski2025"/>.
#!
#! @BeginExampleSession
#! gap> List(DiagonalDigraphTypes(4), OutNeighbours);
#! [ [ [ 2 ], [ 1 ], [ 1 ], [ 1 ] ], [ [ 2 ], [ 1 ], [ 1 ], [ 2 ] ],
#!   [ [ 2 ], [ 1 ], [ 1 ], [ 3 ] ], [ [ 2 ], [ 3 ], [ 1 ], [ 1 ] ],
#!   [ [ 2 ], [ 3 ], [ 4 ], [ 1 ] ], [ [ 2 ], [ 1 ], [ 4 ], [ 3 ] ] ]
#! gap> Ms := AllSmallAntimagmas(4, "up-to-isomorphism");;
#! gap> Size(Ms);
#! 17780
#! @EndExampleSession
#!
#! @Subsection Deranged magmas
#!
#! Every deranged magma is antiassociative, so the deranged magmas of order 4
#! are found by filtering the isomorphism classes above. This reproduces
#! <Cite Key="MazurekZabielski2025" Where="Table 1"/>.
#!
#! @BeginExampleSession
#! gap> Display(SmallAntimagmaClassification(
#! >        Filtered(Ms, IsLeftDerangementInducted), "diagonal"));
#! Classified by the isomorphism type of the diagonal digraph:
#! -----------------------------------------------------------------------------
#! Counted objects      Total    Gamma_1 Gamma_2 Gamma_3 Gamma_4 Gamma_5 Gamma_6
#! -----------------------------------------------------------------------------
#! Isomorphism classes   8315         15    2080    4096       8    1044    1072
#! .............................................................................
#! 3-iso classes            1          0       0       0       0       0       1
#! 6-iso classes           15          0       0       0       0       8       7
#! 12-iso classes         179          3      64       0       0      28      84
#! 24-iso classes        8120         12    2016    4096       8    1008     980
#! -----------------------------------------------------------------------------
#! Labelled magmas     197121        324   49152   98304     192   24576   24573
#! -----------------------------------------------------------------------------
#! @EndExampleSession
#!
#! A magma is op-deranged when its transpose is deranged, that is when it
#! satisfies <Ref Prop="IsRightDerangementInducted" Label="for IsMagma"/>.
#! Transposing is a bijection between the two families, so the op-deranged
#! magmas fill in the same table.
#!
#! @BeginExampleSession
#! gap> Display(SmallAntimagmaClassification(
#! >        Filtered(Ms, IsRightDerangementInducted), "diagonal"));
#! Classified by the isomorphism type of the diagonal digraph:
#! -----------------------------------------------------------------------------
#! Counted objects      Total    Gamma_1 Gamma_2 Gamma_3 Gamma_4 Gamma_5 Gamma_6
#! -----------------------------------------------------------------------------
#! Isomorphism classes   8315         15    2080    4096       8    1044    1072
#! .............................................................................
#! 3-iso classes            1          0       0       0       0       0       1
#! 6-iso classes           15          0       0       0       0       8       7
#! 12-iso classes         179          3      64       0       0      28      84
#! 24-iso classes        8120         12    2016    4096       8    1008     980
#! -----------------------------------------------------------------------------
#! Labelled magmas     197121        324   49152   98304     192   24576   24573
#! -----------------------------------------------------------------------------
#! @EndExampleSession
#!
#! @Subsection Anti-associative magmas
#!
#! This reproduces <Cite Key="MazurekZabielski2025" Where="Table 2"/>.
#!
#! @BeginExampleSession
#! gap> Display(SmallAntimagmaClassification(Ms, "diagonal"));
#! Classified by the isomorphism type of the diagonal digraph:
#! -----------------------------------------------------------------------------
#! Counted objects      Total    Gamma_1 Gamma_2 Gamma_3 Gamma_4 Gamma_5 Gamma_6
#! -----------------------------------------------------------------------------
#! Iso+antiiso classes   8891         48    2176    4334     112    1073    1148
#! -----------------------------------------------------------------------------
#! Isomorphism classes  17780         96    4352    8668     224    2146    2294
#! .............................................................................
#! 3-iso classes            2          0       0       0       0       0       2
#! 6-iso classes           29          0       0       0       0      16      13
#! 12-iso classes         383         10     140       0       0      56     177
#! 24-iso classes       17366         86    4212    8668     224    2074    2102
#! -----------------------------------------------------------------------------
#! Labelled magmas     421560       2184  102768  208032    5376   50544   52656
#! -----------------------------------------------------------------------------
#! @EndExampleSession
#!
#! @Subsection Magmas that are neither deranged nor op-deranged
#!
#! This reproduces <Cite Key="MazurekZabielski2025" Where="Table 3"/>. No
#! isomorphism class of size 3 or 6 survives both filters.
#!
#! @BeginExampleSession
#! gap> Display(SmallAntimagmaClassification(Filtered(Ms,
#! >        M -> not IsLeftDerangementInducted(M)
#! >             and not IsRightDerangementInducted(M)), "diagonal"));
#! Classified by the isomorphism type of the diagonal digraph:
#! ----------------------------------------------------------------------------
#! Counted objects     Total    Gamma_1 Gamma_2 Gamma_3 Gamma_4 Gamma_5 Gamma_6
#! ----------------------------------------------------------------------------
#! Iso+antiiso classes   576         33      96     238     104      29      76
#! ----------------------------------------------------------------------------
#! Isomorphism classes  1151         66     192     476     208      58     151
#! ............................................................................
#! 12-iso classes         25          4      12       0       0       0       9
#! 24-iso classes       1126         62     180     476     208      58     142
#! ----------------------------------------------------------------------------
#! Labelled magmas     27324       1536    4464   11424    4992    1392    3516
#! ----------------------------------------------------------------------------
#! @EndExampleSession
#!
#!
#! @Section Classification by cancellativity degree
#!
#! The cancellativity degree <Ref Attr="CancellativityDegree" Label="for IsMagma"/>
#! of a magma <M>M</M> is the pair <M>[ l, r ]</M> counting the elements whose
#! left translation <M>x \mapsto z * x</M>, respectively right translation
#! <M>x \mapsto x * z</M>, is injective. Left cancellativity is <M>l = |M|</M>
#! and right cancellativity is <M>r = |M|</M>, so the table by
#! <C>"cancellativity"</C> is a coarsening of the one by
#! <C>"cancellativity-degree"</C>, which keeps the intermediate counts apart.
#!
#! At order 2 the degrees are extreme: one class is left cancellative, the other
#! is its transpose.
#!
#! @BeginExampleSession
#! gap> Display(SmallAntimagmaClassification(
#! >        AllSmallAntimagmas(2, "up-to-isomorphism"), "cancellativity-degree"));
#! Classified by the cancellativity degree:
#! ----------------------------------------
#! Counted objects     Total    (0,2) (2,0)
#! ----------------------------------------
#! Isomorphism classes     2        1     1
#! ........................................
#! 1-iso classes           2        1     1
#! ----------------------------------------
#! Labelled magmas         2        1     1
#! ----------------------------------------
#! @EndExampleSession
#!
#! At order 3 no magma has a partially injective side: eight classes have no
#! injective translation at all, and the remaining two are again a left
#! cancellative magma and its transpose. The left cancellative one is
#! <M>x * y = \sigma(y)</M> for the 3-cycle <M>\sigma</M>.
#!
#! @BeginExampleSession
#! gap> Ms := AllSmallAntimagmas(3, "up-to-isomorphism");;
#! gap> Display(SmallAntimagmaClassification(Ms, "cancellativity-degree"));
#! Classified by the cancellativity degree:
#! ----------------------------------------------
#! Counted objects     Total    (0,0) (0,3) (3,0)
#! ----------------------------------------------
#! Isomorphism classes    10        8     1     1
#! ..............................................
#! 2-iso classes           2        0     1     1
#! 6-iso classes           8        8     0     0
#! ----------------------------------------------
#! Labelled magmas        52       48     2     2
#! ----------------------------------------------
#! gap> M := First(Ms, M -> CancellativityDegree(M) = [3, 0]);;
#! gap> Display(MultiplicationTable(M));
#! [ [  2,  3,  1 ],
#!   [  2,  3,  1 ],
#!   [  2,  3,  1 ] ]
#! @EndExampleSession
#!
#! At order 4 the coarse table records that no antiassociative magma is
#! cancellative, and that 40 classes are cancellative on each side.
#!
#! @BeginExampleSession
#! gap> Ms := AllSmallAntimagmas(4, "up-to-isomorphism");;
#! gap> Display(SmallAntimagmaClassification(Ms, "cancellativity"));
#! Classified by left and right cancellativity:
#! -----------------------------------------------------
#! Counted objects      Total    neither left right both
#! -----------------------------------------------------
#! Isomorphism classes  17780      17700   40    40    0
#! .....................................................
#! 3-iso classes            2          0    1     1    0
#! 6-iso classes           29         23    3     3    0
#! 12-iso classes         383        365    9     9    0
#! 24-iso classes       17366      17312   27    27    0
#! -----------------------------------------------------
#! Labelled magmas     421560     420006  777   777    0
#! -----------------------------------------------------
#! @EndExampleSession
#!
#! The degree splits the <C>neither</C> column further. Ten degrees occur, and
#! the table is easier to read in three parts: the classes with at least one
#! injective left translation, those with at least one injective right
#! translation, and those with none. Transposition swaps the first two parts,
#! so they fill in mirror-image tables.
#!
#! @BeginExampleSession
#! gap> Display(SmallAntimagmaClassification(
#! >        Filtered(Ms, M -> CancellativityDegree(M)[1] > 0), "cancellativity-degree"));
#! Classified by the cancellativity degree:
#! -----------------------------------------------------------
#! Counted objects      Total    (1,0) (1,1) (2,0) (3,0) (4,0)
#! -----------------------------------------------------------
#! Isomorphism classes   5938     3665     2  1839   392    40
#! ...........................................................
#! 3-iso classes            1        0     0     0     0     1
#! 6-iso classes            3        0     0     0     0     3
#! 12-iso classes          86        0     0    77     0     9
#! 24-iso classes        5848     3665     2  1762   392    27
#! -----------------------------------------------------------
#! Labelled magmas     141405    87960    48 43212  9408   777
#! -----------------------------------------------------------
#! gap> Display(SmallAntimagmaClassification(
#! >        Filtered(Ms, M -> CancellativityDegree(M)[2] > 0), "cancellativity-degree"));
#! Classified by the cancellativity degree:
#! -----------------------------------------------------------
#! Counted objects      Total    (0,1) (0,2) (0,3) (0,4) (1,1)
#! -----------------------------------------------------------
#! Isomorphism classes   5938     3665  1839   392    40     2
#! ...........................................................
#! 3-iso classes            1        0     0     0     1     0
#! 6-iso classes            3        0     0     0     3     0
#! 12-iso classes          86        0    77     0     9     0
#! 24-iso classes        5848     3665  1762   392    27     2
#! -----------------------------------------------------------
#! Labelled magmas     141405    87960 43212  9408   777    48
#! -----------------------------------------------------------
#! gap> Display(SmallAntimagmaClassification(
#! >        Filtered(Ms, M -> CancellativityDegree(M) = [0, 0]), "cancellativity-degree"));
#! Classified by the cancellativity degree:
#! ------------------------------------
#! Counted objects      Total     (0,0)
#! ------------------------------------
#! Iso+antiiso classes   2954      2954
#! ------------------------------------
#! Isomorphism classes   5906      5906
#! ....................................
#! 6-iso classes           23        23
#! 12-iso classes         211       211
#! 24-iso classes        5672      5672
#! ------------------------------------
#! Labelled magmas     138798    138798
#! ------------------------------------
#! @EndExampleSession
#!
#! The degree <M>(1, 1)</M> is the only one with both entries non-zero, and it is
#! attained by a single pair of transposed classes, so a single class up to
#! isomorphism and antiisomorphism.
#!
#! @BeginExampleSession
#! gap> mixed := Filtered(Ms, M -> CancellativityDegree(M) = [1, 1]);;
#! gap> List(mixed, IdSmallAntimagma);
#! [ [ 4, 7426 ], [ 4, 7426 ] ]
#! gap> IsMagmaIsomorphic(mixed[1], TransposedMagma(mixed[2]));
#! true
#! gap> Display(MultiplicationTable(mixed[1]));
#! [ [  2,  1,  3,  3 ],
#!   [  4,  1,  2,  1 ],
#!   [  4,  1,  1,  1 ],
#!   [  2,  1,  4,  3 ] ]
#! @EndExampleSession
#!
#! Among the deranged magmas of order 4, in the sense of
#! <Ref Prop="IsLeftDerangementInducted" Label="for IsMagma"/>, no left
#! translation is injective, while all but one of the 40 right cancellative
#! classes are deranged.
#!
#! @BeginExampleSession
#! gap> deranged := Filtered(Ms, IsLeftDerangementInducted);;
#! gap> for d in Collected(List(deranged, CancellativityDegree)) do
#! >        Print(d[1], String(d[2], 6), "\n");
#! >    od;
#! [ 0, 0 ]  2672
#! [ 0, 1 ]  3456
#! [ 0, 2 ]  1764
#! [ 0, 3 ]   384
#! [ 0, 4 ]    39
#! gap> Number(Ms, IsRightCancellative);
#! 40
#! @EndExampleSession
#!
