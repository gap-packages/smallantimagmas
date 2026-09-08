#! @Arguments n[, view]
#! @Description
#! returns all antiassociative magmas of specified size <A>n</A> (a number, or a
#! list of numbers), in one of three views:
#!
#! <List>
#! <Item><C>"up-to-isomorphism-antiisomorphism"</C>, the default: a single
#! representative for every class of magmas that are pairwise isomorphic or
#! anti-isomorphic, which is what the library stores.</Item>
#! <Item><C>"up-to-isomorphism"</C>: a single representative for every class of
#! pairwise isomorphic magmas. An anti-isomorphism <M>M \to N</M> is an
#! isomorphism from the transpose of <M>M</M> to <M>N</M>, and a composite of two
#! anti-isomorphisms is an isomorphism, so a class of the view above is the
#! isomorphism class of <M>M</M> together with the one of its transpose, and
#! splits into nothing else.</Item>
#! <Item><C>"labelled"</C>: every magma with underlying set
#! <M>\{ 1, \ldots, n \}</M>, one per multiplication table. Renaming the
#! elements of a magma by a permutation gives an isomorphic magma on the same
#! set, so an isomorphism class contributes <M>n! / |\mathrm{Aut}(M)|</M> of
#! them.</Item>
#! </List>
#!
#! Only the default view is stored, and so only it is numbered: the index
#! <A>i</A> of <Ref Func="SmallAntimagma"/> and the identifier returned by
#! <Ref Attr="IdSmallAntimagma" Label="for IsMagma"/> are positions in it. The
#! other two views are derived from it when asked for and carry no identifiers.
#!
#! @BeginExampleSession
#! gap> AllSmallAntimagmas(2);
#! [ <magma with 2 generators> ]
#! gap> AllSmallAntimagmas(2, "up-to-isomorphism");
#! [ <magma with 2 generators>, <magma with 2 generators> ]
#! gap> List(AllSmallAntimagmas(2, "labelled"), MultiplicationTable);
#! [ [ [ 2, 1 ], [ 2, 1 ] ], [ [ 2, 2 ], [ 1, 1 ] ] ]
#! gap> AllSmallAntimagmas(3);
#! [ 
#!   <magma with 3 generators>, <magma with 3 generators>, <magma with 3 generators>,
#!   <magma with 3 generators>, <magma with 3 generators>
#! ]
#! @EndExampleSession
#!
DeclareGlobalFunction("AllSmallAntimagmas");

#! @Arguments n[, view]
#! @Description
#! counts the antiassociative magmas of specified size <A>n</A> (a number, or a
#! list of numbers) in the same three views as
#! <Ref Func="AllSmallAntimagmas"/>, without building any of them in the default
#! view. Counting and listing agree, that is
#! <C>NrSmallAntimagmas(n, view) = Size(AllSmallAntimagmas(n, view))</C>.
#!
#! @BeginExampleSession
#! gap> NrSmallAntimagmas(4);
#! 8891
#! gap> NrSmallAntimagmas(4, "up-to-isomorphism");
#! 17780
#! gap> NrSmallAntimagmas(4, "labelled");
#! 421560
#! gap> List([2 .. 4], NrSmallAntimagmas);
#! [ 1, 5, 8891 ]
#! gap> NrSmallAntimagmas([2, 3]);
#! 6
#! @EndExampleSession
#!
DeclareGlobalFunction("NrSmallAntimagmas");

#! @Arguments n, i
#! @Description
#! returns antiassociative magma of id <A>[n, i]</A>, up to isomorphism and anti-isomorphism.
#!
#! @BeginExampleSession
#! gap> SmallAntimagma(2, 1);
#! <magma with 2 generators>
#! gap> SmallAntimagma(4, 5);
#! <magma with 4 generators>
#! gap> SmallAntimagma([4, 5]);
#! <magma with 4 generators>
#! @EndExampleSession
#!
DeclareGlobalFunction("SmallAntimagma");

#! @Arguments n
#! @Description
#! returns a random antiassociative magma of size <A>n</A>, up to isomorphism and anti-isomorphism.
#!
#! @BeginExampleSession
#! gap> OneSmallAntimagma(2);
#! <magma with 2 generators>
#!
#! gap> OneSmallAntimagma(3);
#! <magma with 3 generators>
#! @EndExampleSessions
#!
DeclareGlobalFunction("OneSmallAntimagma");
