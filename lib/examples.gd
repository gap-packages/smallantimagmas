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
