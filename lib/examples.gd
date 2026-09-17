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
#! @Section Classification by commutativity index
#!
#! The commutativity index of a magma, <Ref Attr="CommutativityIndex" Label="for IsMagma"/>,
#! counts the unordered pairs of distinct elements that commute. It is an
#! isomorphism invariant, and is preserved by transposition as well, so the
#! antiisomorphism classes can always be counted. The columns of each table are
#! the values that occur among the magmas classified.
#!
#! No antiassociative magma of order 2 has a commuting pair, and at order 3 at
#! most one pair commutes.
#!
#! @BeginExampleSession
#! gap> Display(SmallAntimagmaClassification(
#! >        AllSmallAntimagmas(2, "up-to-isomorphism"), "commutativity"));
#! Classified by the commutativity index:
#! ------------------------------
#! Counted objects     Total    0
#! ------------------------------
#! Iso+antiiso classes     1    1
#! ------------------------------
#! Isomorphism classes     2    2
#! ..............................
#! 1-iso classes           2    2
#! ------------------------------
#! Labelled magmas         2    2
#! ------------------------------
#! gap> Display(SmallAntimagmaClassification(
#! >        AllSmallAntimagmas(3, "up-to-isomorphism"), "commutativity"));
#! Classified by the commutativity index:
#! ---------------------------------
#! Counted objects     Total    0  1
#! ---------------------------------
#! Iso+antiiso classes     5    1  4
#! ---------------------------------
#! Isomorphism classes    10    2  8
#! .................................
#! 2-iso classes           2    2  0
#! 6-iso classes           8    0  8
#! ---------------------------------
#! Labelled magmas        52    4 48
#! ---------------------------------
#! @EndExampleSession
#!
#! At order 4 the index ranges from 0 to 3, and no class of size 3 or 6 has a
#! commuting pair.
#!
#! @BeginExampleSession
#! gap> Display(SmallAntimagmaClassification(
#! >        AllSmallAntimagmas(4, "up-to-isomorphism"), "commutativity"));
#! Classified by the commutativity index:
#! ------------------------------------------------------
#! Counted objects      Total         0      1      2   3
#! ------------------------------------------------------
#! Iso+antiiso classes   8891      2322   4389   2165  15
#! ------------------------------------------------------
#! Isomorphism classes  17780      4642   8778   4330  30
#! ......................................................
#! 3-iso classes            2         2      0      0   0
#! 6-iso classes           29        29      0      0   0
#! 12-iso classes         383       237      2    138   6
#! 24-iso classes       17366      4374   8776   4192  24
#! ------------------------------------------------------
#! Labelled magmas     421560    108000 210648 102264 648
#! ------------------------------------------------------
#! @EndExampleSession
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
#! @Section Absorption index
#!
#! The absorption index <Ref Attr="AbsorptionIndex" Label="for IsMagma"/> of a
#! magma <M>M</M> is the pair of the numbers of ordered pairs
#! <M>(x, y) \in M \times M</M> with <M>x * y = x</M> and with
#! <M>x * y = y</M>, the left and right zero indices. It measures how far the
#! operation is from the left projection <M>x * y = x</M> and from the right
#! projection <M>x * y = y</M>. An antimagma has no idempotents, so its diagonal never
#! contributes, and a pair <M>(x, y)</M> with <M>x \neq y</M> absorbs at most
#! one way, so the two indices sum to at most <M>|M| (|M| - 1)</M>.
#!
#! At order 3, four of the five antiisomorphism classes are left absorbing
#! only, and the fifth is the transpose of one of them.
#!
#! @BeginExampleSession
#! gap> List(AllSmallAntimagmas(3), M -> [MultiplicationTable(M), AbsorptionIndex(M)]);
#! [ [ [ [ 2, 1, 1 ], [ 2, 1, 1 ], [ 2, 1, 1 ] ], [ 3, 0 ] ],
#!   [ [ [ 2, 1, 1 ], [ 2, 1, 1 ], [ 3, 1, 1 ] ], [ 4, 0 ] ],
#!   [ [ [ 2, 1, 1 ], [ 3, 1, 1 ], [ 2, 1, 1 ] ], [ 2, 0 ] ],
#!   [ [ [ 2, 1, 1 ], [ 3, 1, 1 ], [ 3, 1, 1 ] ], [ 3, 0 ] ],
#!   [ [ [ 2, 2, 2 ], [ 3, 3, 3 ], [ 1, 1, 1 ] ], [ 0, 3 ] ] ]
#! gap> ForAll(AllSmallAntimagmas(3),
#! >        M -> AbsorptionIndex(TransposedMagma(M)) = Reversed(AbsorptionIndex(M)));
#! true
#! @EndExampleSession
#!
#! Transposition reverses the pair, so over the isomorphism classes of order 4
#! the distribution is symmetric. It takes 25 values, and no index exceeds 8,
#! well below the bound <M>4 \cdot 3 = 12</M>.
#!
#! @BeginExampleSession
#! gap> ai := List(Ms, AbsorptionIndex);;
#! gap> Collected(ai);
#! [ [ [ 0, 0 ], 79 ], [ [ 0, 1 ], 272 ], [ [ 0, 2 ], 965 ], [ [ 0, 3 ], 1886 ],
#!   [ [ 0, 4 ], 2394 ], [ [ 0, 5 ], 1837 ], [ [ 0, 6 ], 921 ], [ [ 0, 7 ], 256 ],
#!   [ [ 0, 8 ], 39 ], [ [ 1, 0 ], 272 ], [ [ 1, 1 ], 58 ], [ [ 1, 2 ], 101 ],
#!   [ [ 1, 3 ], 76 ], [ [ 1, 4 ], 42 ], [ [ 2, 0 ], 965 ], [ [ 2, 1 ], 101 ],
#!   [ [ 2, 2 ], 65 ], [ [ 3, 0 ], 1886 ], [ [ 3, 1 ], 76 ], [ [ 4, 0 ], 2394 ],
#!   [ [ 4, 1 ], 42 ], [ [ 5, 0 ], 1837 ], [ [ 6, 0 ], 921 ], [ [ 7, 0 ], 256 ],
#!   [ [ 8, 0 ], 39 ] ]
#! gap> Size(Set(ai));
#! 25
#! gap> Collected(ai) = Collected(List(ai, Reversed));
#! true
#! gap> Maximum(List(ai, Maximum));
#! 8
#! @EndExampleSession
#!
#! Most classes absorb on one side only. Absorption on both sides is rare, and
#! 79 classes have no absorbing pair at all.
#!
#! @BeginExampleSession
#! gap> Number(ai, a -> a = [0, 0]);
#! 79
#! gap> Number(ai, a -> 0 in a and a <> [0, 0]);
#! 17140
#! gap> Number(ai, a -> not 0 in a);
#! 561
#! gap> MultiplicationTable(Ms[Position(ai, [0, 0])]);
#! [ [ 2, 3, 2, 2 ], [ 4, 1, 1, 1 ], [ 4, 1, 1, 1 ], [ 2, 3, 2, 2 ] ]
#! gap> MultiplicationTable(Ms[Position(ai, [8, 0])]);
#! [ [ 2, 1, 1, 2 ], [ 2, 1, 1, 2 ], [ 3, 1, 1, 3 ], [ 2, 4, 4, 2 ] ]
#! @EndExampleSession
#!
#! In a left cancellative magma each <M>x</M> has exactly one <M>y</M> with
#! <M>x * y = x</M>, so the left zero index is <M>|M|</M>. The 40 left
#! cancellative classes of order 4 all have absorption index <M>[ 4, 0 ]</M>.
#!
#! @BeginExampleSession
#! gap> Collected(List(Filtered(Ms, IsLeftCancellative), AbsorptionIndex));
#! [ [ [ 4, 0 ], 40 ] ]
#! @EndExampleSession
#!
#! @Section Classification by translation profile
#!
#! The translation profile of a magma <M>M</M>, given by
#! <Ref Attr="TranslationProfile" Label="for IsMagma"/>, counts its distinct
#! left translations <M>x \mapsto z * x</M> and its distinct right translations
#! <M>x \mapsto x * z</M>. Transposing swaps the two counts, so the unordered
#! pair is invariant under isomorphism and antiisomorphism alike, and the
#! columns below are the types listed by
#! <Ref Oper="TranslationProfileTypes" Label="for IsPosInt"/>.
#!
#! At order 2 the product depends on one factor only, so the single type is
#! <M>\{1, 2\}</M>.
#!
#! @BeginExampleSession
#! gap> TranslationProfileTypes(2);
#! [ [ 1, 2 ] ]
#! gap> Display(SmallAntimagmaClassification(
#! >        AllSmallAntimagmas(2, "up-to-isomorphism"), "translation"));
#! Classified by the translation profile:
#! --------------------------------
#! Counted objects     Total    T_1
#! --------------------------------
#! Iso+antiiso classes     1      1
#! --------------------------------
#! Isomorphism classes     2      2
#! ................................
#! 1-iso classes           2      2
#! --------------------------------
#! Labelled magmas         2      2
#! --------------------------------
#! @EndExampleSession
#!
#! At order 3 the profile separates the two cancellative classes, of type
#! <M>\{1, 3\}</M>, from the two classes of type <M>\{1, 2\}</M> whose product
#! depends on one factor only, and both from the six remaining classes.
#!
#! @BeginExampleSession
#! gap> TranslationProfileTypes(3);
#! [ [ 2, 2 ], [ 1, 2 ], [ 1, 3 ] ]
#! gap> Display(SmallAntimagmaClassification(
#! >        AllSmallAntimagmas(3, "up-to-isomorphism"), "translation"));
#! Classified by the translation profile:
#! ----------------------------------------
#! Counted objects     Total    T_1 T_2 T_3
#! ----------------------------------------
#! Iso+antiiso classes     5      3   1   1
#! ----------------------------------------
#! Isomorphism classes    10      6   2   2
#! ........................................
#! 2-iso classes           2      0   0   2
#! 6-iso classes           8      6   2   0
#! ----------------------------------------
#! Labelled magmas        52     36  12   4
#! ----------------------------------------
#! @EndExampleSession
#!
#! At order 4 every sorted pair but <M>\{1, 1\}</M> occurs. The last three
#! types, with a single translation on one side, hold four isomorphism classes
#! each, and the profile <M>\{4, 4\}</M> alone covers more than half of the
#! classes.
#!
#! @BeginExampleSession
#! gap> TranslationProfileTypes(4);
#! [ [ 4, 4 ], [ 3, 3 ], [ 3, 4 ], [ 2, 2 ], [ 2, 3 ], [ 2, 4 ], [ 1, 2 ],
#!   [ 1, 3 ], [ 1, 4 ] ]
#! gap> Display(SmallAntimagmaClassification(
#! >        AllSmallAntimagmas(4, "up-to-isomorphism"), "translation"));
#! Classified by the translation profile:
#! ---------------------------------------------------------------------------
#! Counted objects      Total       T_1   T_2    T_3 T_4  T_5  T_6 T_7 T_8 T_9
#! ---------------------------------------------------------------------------
#! Iso+antiiso classes   8891      5326   552   2693  20  142  152   2   2   2
#! ---------------------------------------------------------------------------
#! Isomorphism classes  17780     10651  1104   5386  39  284  304   4   4   4
#! ...........................................................................
#! 3-iso classes            2         0     0      0   0    0    0   0   0   2
#! 6-iso classes           29        16     0      0   3    0    8   0   0   2
#! 12-iso classes         383       135     0    184   4   20   36   4   0   0
#! 24-iso classes       17366     10500  1104   5202  32  264  260   0   4   0
#! ---------------------------------------------------------------------------
#! Labelled magmas     421560    253716 26496 127056 834 6576 6720  48  96  18
#! ---------------------------------------------------------------------------
#! @EndExampleSession
#!
#! @Section Classification by product set size
#!
#! The product set of a magma <M>M</M> is <M>M * M = \{ x * y \mid x, y \in M \}</M>,
#! and its size <Ref Attr="ProductSetSize" Label="for IsMagma"/> is an
#! isomorphism invariant. It never equals <M>1</M> for an antiassociative
#! magma, since a magma with a single product is associative. At order 3 the
#! product set is nearly always the whole magma, and at order 4 the size
#! <M>4</M> dominates outright: the sizes <M>2</M> and <M>3</M> together
#! account for only a small fraction of the classes.
#!
#! @BeginExampleSession
#! gap> List(AllSmallAntimagmas(2), M -> ProductSetSize(M));
#! [ 2 ]
#! gap> Ms := AllSmallAntimagmas(3, "up-to-isomorphism");;
#! gap> Display(SmallAntimagmaClassification(Ms, "product-set"));
#! Classified by the size of the product set M * M:
#! ------------------------------------------
#! Counted objects     Total    |MM|=2 |MM|=3
#! ------------------------------------------
#! Iso+antiiso classes     5         1      4
#! ------------------------------------------
#! Isomorphism classes    10         2      8
#! ..........................................
#! 2-iso classes           2         0      2
#! 6-iso classes           8         2      6
#! ------------------------------------------
#! Labelled magmas        52        12     40
#! ------------------------------------------
#! @EndExampleSession
#!
#! @BeginExampleSession
#! gap> Ms := AllSmallAntimagmas(4, "up-to-isomorphism");;
#! gap> Display(SmallAntimagmaClassification(Ms, "product-set"));
#! Classified by the size of the product set M * M:
#! --------------------------------------------------
#! Counted objects      Total    |MM|=2 |MM|=3 |MM|=4
#! --------------------------------------------------
#! Iso+antiiso classes   8891         2    146   8743
#! --------------------------------------------------
#! Isomorphism classes  17780         4    292  17484
#! ..................................................
#! 3-iso classes            2         0      0      2
#! 6-iso classes           29         0      0     29
#! 12-iso classes         383         4      0    379
#! 24-iso classes       17366         0    292  17074
#! --------------------------------------------------
#! Labelled magmas     421560        48   7008 414504
#! --------------------------------------------------
#! @EndExampleSession
#!
#! In both order-4 classes with a product set of size <M>2</M> the rows of the
#! multiplication table coincide, so the product <M>x * y</M> depends on
#! <M>y</M> alone. Every magma of order 4 whose product set has size <M>2</M>
#! is deranged or op-deranged.
#!
#! @BeginExampleSession
#! gap> Display(SmallAntimagmaClassification(
#! >        Filtered(Ms, IsLeftDerangementInducted), "product-set"));
#! Classified by the size of the product set M * M:
#! --------------------------------------------------
#! Counted objects      Total    |MM|=2 |MM|=3 |MM|=4
#! --------------------------------------------------
#! Isomorphism classes   8315         2    135   8178
#! ..................................................
#! 3-iso classes            1         0      0      1
#! 6-iso classes           15         0      0     15
#! 12-iso classes         179         2      0    177
#! 24-iso classes        8120         0    135   7985
#! --------------------------------------------------
#! Labelled magmas     197121        24   3240 193857
#! --------------------------------------------------
#! @EndExampleSession
#!
#! Among the magmas that are neither deranged nor op-deranged, the product set
#! has size at least <M>3</M>.
#!
#! @BeginExampleSession
#! gap> Display(SmallAntimagmaClassification(Filtered(Ms,
#! >        M -> not IsLeftDerangementInducted(M)
#! >             and not IsRightDerangementInducted(M)), "product-set"));
#! Classified by the size of the product set M * M:
#! -------------------------------------------------
#! Counted objects     Total    |MM|=2 |MM|=3 |MM|=4
#! -------------------------------------------------
#! Iso+antiiso classes   576         0     11    565
#! -------------------------------------------------
#! Isomorphism classes  1151         0     22   1129
#! .................................................
#! 12-iso classes         25         0      0     25
#! 24-iso classes       1126         0     22   1104
#! -------------------------------------------------
#! Labelled magmas     27324         0    528  26796
#! -------------------------------------------------
#! @EndExampleSession
#!
#! @Section Classification by rank
#!
#! The rank of a magma is the least number of elements that generate it, the
#! size of a <Ref Attr="MinimalGeneratingSet" Label="for IsMagma"/>. Every
#! antiassociative magma of order 2 or 3 is generated by a single element, and
#! so are all but 183 of the isomorphism classes of order 4, which have rank 2.
#!
#! @BeginExampleSession
#! gap> List([2 .. 3], n -> Collected(List(AllSmallAntimagmas(n), Rank)));
#! [ [ [ 1, 1 ] ], [ [ 1, 5 ] ] ]
#! gap> Display(SmallAntimagmaClassification(Ms, "rank"));
#! Classified by rank, the size of a minimal generating set:
#! ---------------------------------------------------------
#! Counted objects      Total    rank 1 rank 2 rank 3 rank 4
#! ---------------------------------------------------------
#! Iso+antiiso classes   8891      8799     92      0      0
#! ---------------------------------------------------------
#! Isomorphism classes  17780     17597    183      0      0
#! .........................................................
#! 3-iso classes            2         0      2      0      0
#! 6-iso classes           29        23      6      0      0
#! 12-iso classes         383       332     51      0      0
#! 24-iso classes       17366     17242    124      0      0
#! ---------------------------------------------------------
#! Labelled magmas     421560    417930   3630      0      0
#! ---------------------------------------------------------
#! @EndExampleSession
#!
#! Every one of the rank 2 classes has a diagonal digraph of type
#! <M>\Gamma_1</M>, <M>\Gamma_2</M> or <M>\Gamma_6</M>.
#!
#! @BeginExampleSession
#! gap> Display(SmallAntimagmaClassification(
#! >        Filtered(Ms, M -> Rank(M) = 2), "diagonal"));
#! Classified by the isomorphism type of the diagonal digraph:
#! ----------------------------------------------------------------------------
#! Counted objects     Total    Gamma_1 Gamma_2 Gamma_3 Gamma_4 Gamma_5 Gamma_6
#! ----------------------------------------------------------------------------
#! Iso+antiiso classes    92          3      10       0       0       0      79
#! ----------------------------------------------------------------------------
#! Isomorphism classes   183          6      20       0       0       0     157
#! ............................................................................
#! 3-iso classes           2          0       0       0       0       0       2
#! 6-iso classes           6          0       0       0       0       0       6
#! 12-iso classes         51          4       8       0       0       0      39
#! 24-iso classes        124          2      12       0       0       0     110
#! ----------------------------------------------------------------------------
#! Labelled magmas      3630         96     384       0       0       0    3150
#! ----------------------------------------------------------------------------
#! @EndExampleSession
#!
#! @Section Classification by index-period profile
#!
#! The <Ref Attr="IndexPeriodProfile" Label="for IsMagma"/> of a magma collects
#! the left index-periods of its elements, and the right ones, and keeps the two
#! multisets as an unordered pair. It is unchanged by isomorphism and by
#! transposition, so a magma and its opposite always fall into the same profile
#! and the classification by <C>"index-period"</C> counts antiisomorphism
#! classes as well. Unlike the diagonal digraphs, the profiles are not
#! enumerated for an order: the columns <M>P_1, P_2, \ldots</M> are the profiles
#! <Ref Oper="IndexPeriodProfileTypes" Label="for IsList"/> finds among the
#! magmas classified, in the order of GAP lists.
#!
#! At order 2 the two isomorphism classes, each a magma and its transpose, share
#! the one profile.
#!
#! @BeginExampleSession
#! gap> Display(SmallAntimagmaClassification(
#! >        AllSmallAntimagmas(2, "up-to-isomorphism"), "index-period"));
#! Classified by the index-period profile:
#! --------------------------------
#! Counted objects     Total    P_1
#! --------------------------------
#! Iso+antiiso classes     1      1
#! --------------------------------
#! Isomorphism classes     2      2
#! ................................
#! 1-iso classes           2      2
#! --------------------------------
#! Labelled magmas         2      2
#! --------------------------------
#! @EndExampleSession
#!
#! At order 3 the profile separates the five antiisomorphism classes completely:
#! each column holds one class, that is one magma and its transpose. The last
#! profile, <M>P_5</M>, is that of the two cyclic magmas, the only classes of
#! size 2.
#!
#! @BeginExampleSession
#! gap> Ms := AllSmallAntimagmas(3, "up-to-isomorphism");;
#! gap> Display(SmallAntimagmaClassification(Ms, "index-period"));
#! Classified by the index-period profile:
#! ------------------------------------------------
#! Counted objects     Total    P_1 P_2 P_3 P_4 P_5
#! ------------------------------------------------
#! Iso+antiiso classes     5      1   1   1   1   1
#! ------------------------------------------------
#! Isomorphism classes    10      2   2   2   2   2
#! ................................................
#! 2-iso classes           2      0   0   0   0   2
#! 6-iso classes           8      2   2   2   2   0
#! ------------------------------------------------
#! Labelled magmas        52     12  12  12  12   4
#! ------------------------------------------------
#! gap> Ps := IndexPeriodProfileTypes(Ms);;
#! gap> Last(Ps);
#! [ [ [ [ 1, 3 ], 3 ] ], [ [ [ 2, 1 ], 3 ] ] ]
#! gap> List(Filtered(Ms, M -> IndexPeriodProfile(M) = Last(Ps)),
#! >         M -> [IsLeftCyclic(M), IsRightCyclic(M)]);
#! [ [ false, true ], [ true, false ] ]
#! @EndExampleSession
#!
#! At order 4 the profile is much finer than the diagonal digraph, with 535
#! profiles against six digraph types, and the table is too wide to print. Most
#! profiles are small: 159 of them again hold a single antiisomorphism class,
#! while the largest holds 530 isomorphism classes. The profile neither refines
#! nor is refined by the classification by diagonal digraph, so the two
#! invariants are independent.
#!
#! @BeginExampleSession
#! gap> Ms := AllSmallAntimagmas(4, "up-to-isomorphism");;
#! gap> Ps := IndexPeriodProfileTypes(Ms);;
#! gap> Size(Ps);
#! 535
#! gap> counts := List(Ps, P -> Number(Ms, M -> IndexPeriodProfile(M) = P));;
#! gap> Sum(counts);
#! 17780
#! gap> [Number(counts, c -> c = 2), Maximum(counts)];
#! [ 159, 530 ]
#! gap> types := DiagonalDigraphTypes(4);;
#! gap> diagonal := M -> PositionProperty(types,
#! >        D -> IsIsomorphicDigraph(D, DigraphOfDiagonal(M)));;
#! gap> ForAll(Ps, P -> Size(Set(Filtered(Ms,
#! >        M -> IndexPeriodProfile(M) = P), diagonal)) = 1);
#! false
#! gap> List([1 .. 6], t -> Size(Set(Filtered(Ms, M -> diagonal(M) = t),
#! >                                IndexPeriodProfile)));
#! [ 32, 256, 367, 77, 164, 114 ]
#! @EndExampleSession
#!
#! @Section Classification by mediality index
#!
#! A magma is medial when <M>(x * y) * (z * w) = (x * z) * (y * w)</M> for all
#! <M>x, y, z, w</M>, and <Ref Attr="MedialityIndex" Label="for IsMagma"/>
#! counts the quadruples for which the law holds. It is an isomorphism
#! invariant, and it is preserved by transposition, so the classification by
#! it also counts the antiisomorphism classes. Unlike the diagonal digraph,
#! the index does not have a fixed list of types per order: the columns of a
#! table are the values taken by the magmas being classified.
#!
#! Both magmas of order 2 are medial, so the index takes the single value
#! <M>2^4 = 16</M>.
#!
#! @BeginExampleSession
#! gap> Display(SmallAntimagmaClassification(
#! >        AllSmallAntimagmas(2, "up-to-isomorphism"), "mediality"));
#! Classified by the mediality index:
#! -------------------------------
#! Counted objects     Total    16
#! -------------------------------
#! Iso+antiiso classes     1     1
#! -------------------------------
#! Isomorphism classes     2     2
#! ...............................
#! 1-iso classes           2     2
#! -------------------------------
#! Labelled magmas         2     2
#! -------------------------------
#! @EndExampleSession
#!
#! At order 3 the index takes four values, and the two classes of size 2, the
#! magmas with a 3-cycle for diagonal, are exactly the medial ones with a
#! non-trivial automorphism.
#!
#! @BeginExampleSession
#! gap> Ms := AllSmallAntimagmas(3, "up-to-isomorphism");;
#! gap> Display(SmallAntimagmaClassification(Ms, "mediality"));
#! Classified by the mediality index:
#! ----------------------------------------
#! Counted objects     Total    57 65 73 81
#! ----------------------------------------
#! Iso+antiiso classes     5     1  1  1  2
#! ----------------------------------------
#! Isomorphism classes    10     2  2  2  4
#! ........................................
#! 2-iso classes           2     0  0  0  2
#! 6-iso classes           8     2  2  2  2
#! ----------------------------------------
#! Labelled magmas        52    12 12 12 16
#! ----------------------------------------
#! gap> Filtered(Ms, M -> MedialityIndex(M) = 3 ^ 4 and SquaresIndex(M) = 3);
#! [ <magma with 3 generators>, <magma with 3 generators> ]
#! @EndExampleSession
#!
#! At order 4 the index takes 75 distinct values, all even, from 100 up to
#! <M>4^4 = 256</M>, so the full table is too wide to reproduce here. It is
#! obtained as above from <C>AllSmallAntimagmas(4, "up-to-isomorphism")</C>;
#! the examples below show its distribution and its two tails.
#!
#! @BeginExampleSession
#! gap> Ms := AllSmallAntimagmas(4, "up-to-isomorphism");;
#! gap> values := Collected(List(Ms, MedialityIndex));;
#! gap> Size(values);
#! 75
#! gap> ForAll(values, v -> IsEvenInt(v[1]));
#! true
#! gap> List(values{[1 .. 4]}, v -> v[1]);
#! [ 100, 106, 108, 112 ]
#! gap> Display(SmallAntimagmaClassification(
#! >        Filtered(Ms, M -> MedialityIndex(M) <= 112), "mediality"));
#! Classified by the mediality index:
#! --------------------------------------------
#! Counted objects     Total    100 106 108 112
#! --------------------------------------------
#! Iso+antiiso classes     8      1   1   3   3
#! --------------------------------------------
#! Isomorphism classes    16      2   2   6   6
#! ............................................
#! 12-iso classes          8      2   0   2   4
#! 24-iso classes          8      0   2   4   2
#! --------------------------------------------
#! Labelled magmas       288     24  48 120  96
#! --------------------------------------------
#! @EndExampleSession
#!
#! The medial antiassociative magmas of order 4 form 93 isomorphism classes,
#! 47 of them up to antiisomorphism, and they include both classes of size 3.
#!
#! @BeginExampleSession
#! gap> Display(SmallAntimagmaClassification(
#! >        Filtered(Ms, M -> MedialityIndex(M) >= 240), "mediality"));
#! Classified by the mediality index:
#! -------------------------------------------------------------
#! Counted objects     Total    240 242 244 246 248 250 252  256
#! -------------------------------------------------------------
#! Iso+antiiso classes    81      9   4   9   6   3   1   2   47
#! -------------------------------------------------------------
#! Isomorphism classes   161     18   8  18  12   6   2   4   93
#! .............................................................
#! 3-iso classes           2      0   0   0   0   0   0   0    2
#! 6-iso classes           9      0   0   0   0   0   0   0    9
#! 12-iso classes         28      0   0   8   0   4   0   0   16
#! 24-iso classes        122     18   8  10  12   2   2   4   66
#! -------------------------------------------------------------
#! Labelled magmas      3324    432 192 336 288  96  48  96 1836
#! -------------------------------------------------------------
#! gap> Number(Filtered(Ms, IsLeftDerangementInducted), M -> MedialityIndex(M) = 256);
#! 47
#! @EndExampleSession
#!
#! @Section Classification by constant translations
#!
#! A constant row of the multiplication table is a constant left translation
#! and a constant column a constant right translation; their numbers are
#! <Ref Attr="NrConstantLeftTranslations" Label="for IsMagma"/> and
#! <Ref Attr="NrConstantRightTranslations" Label="for IsMagma"/>. An
#! antimagma never has both, so the pair is <M>(0, 0)</M>, <M>(r, 0)</M> or
#! <M>(0, c)</M>, and transposition swaps <M>(r, 0)</M> with <M>(0, r)</M>.
#! The value <M>n</M> on either side is the fixed-point free inducted case.
#!
#! Orders 2 and 3 have no magma without constant translations, and every
#! magma of order 2 is fixed-point free inducted on one side.
#!
#! @BeginExampleSession
#! gap> Display(SmallAntimagmaClassification(
#! >        AllSmallAntimagmas(2, "up-to-isomorphism"), "constant"));
#! Classified by the numbers of constant left and right translations:
#! ----------------------------------------------------------
#! Counted objects     Total    (0,0) (1,0) (2,0) (0,1) (0,2)
#! ----------------------------------------------------------
#! Isomorphism classes     2        0     0     1     0     1
#! ..........................................................
#! 1-iso classes           2        0     0     1     0     1
#! ----------------------------------------------------------
#! Labelled magmas         2        0     0     1     0     1
#! ----------------------------------------------------------
#! @EndExampleSession
#!
#! @BeginExampleSession
#! gap> Display(SmallAntimagmaClassification(
#! >        AllSmallAntimagmas(3, "up-to-isomorphism"), "constant"));
#! Classified by the numbers of constant left and right translations:
#! ----------------------------------------------------------------------
#! Counted objects     Total    (0,0) (1,0) (2,0) (3,0) (0,1) (0,2) (0,3)
#! ----------------------------------------------------------------------
#! Isomorphism classes    10        0     0     3     2     0     3     2
#! ......................................................................
#! 2-iso classes           2        0     0     0     1     0     0     1
#! 6-iso classes           8        0     0     3     1     0     3     1
#! ----------------------------------------------------------------------
#! Labelled magmas        52        0     0    18     8     0    18     8
#! ----------------------------------------------------------------------
#! @EndExampleSession
#!
#! At order 4 all nine types occur. The table is wider than the screen, so
#! the screen is widened for it.
#!
#! @BeginExampleSession
#! gap> SizeScreen([100]);;
#! gap> Display(SmallAntimagmaClassification(Ms, "constant"));
#! Classified by the numbers of constant left and right translations:
#! ------------------------------------------------------------------------------------
#! Counted objects      Total     (0,0) (1,0) (2,0) (3,0) (4,0) (0,1) (0,2) (0,3) (0,4)
#! ------------------------------------------------------------------------------------
#! Isomorphism classes  17780     10154  2925   767   115     6  2925   767   115     6
#! ....................................................................................
#! 3-iso classes            2         0     0     0     0     1     0     0     0     1
#! 6-iso classes           29        27     0     0     0     1     0     0     0     1
#! 12-iso classes         383       281     0    47     2     2     0    47     2     2
#! 24-iso classes       17366      9846  2925   720   113     2  2925   720   113     2
#! ------------------------------------------------------------------------------------
#! Labelled magmas     421560    239838 70200 17844  2736    81 70200 17844  2736    81
#! ------------------------------------------------------------------------------------
#! gap> SizeScreen([80]);;
#! @EndExampleSession
#!
