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
