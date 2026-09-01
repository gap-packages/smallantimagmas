#! @Arguments M
#! @Description
#! identifies whether magma <A>M</A> is antiassociative.
#!
#! @BeginExampleSession
#! gap> IsAntiassociative(CyclicGroup(16));
#! false
#! gap> IsAntiassociative(OneSmallAntimagma(2));
#! true
#! gap> IsAntiassociative(OneSmallAntimagma(3));
#! true
#! @EndExampleSession
#!
DeclareProperty("IsAntiassociative", IsMagma);

#! @Arguments M
#! @Description
#! identifies associativity index of <A>M</A>.
#!
#! @BeginExampleSession
#! gap> OneSmallAntimagma(2);
#! <magma with 2 generators>
#! gap> AssociativityIndex(OneSmallAntimagma(2));
#! 0
#! gap> CyclicGroup(4);
#! <pc group of size 4 with 2 generators>
#! gap> AssociativityIndex(CyclicGroup(4));
#! 64
#! gap> AssociativityIndex(CyclicGroup(4)) = 4 ^ 3;
#! true
#! @EndExampleSession
#!
DeclareAttribute("AssociativityIndex", IsMagma);

#! @Arguments M
#! @Description
#! computes diagonal of multiplication table of <A>M</A>.
#!
#! @BeginExampleSession
#! gap> List(AllSmallAntimagmas(3), M -> DiagonalOfMultiplicationTable((M)));
#! [ [ 2, 1, 1 ], [ 2, 1, 1 ],
#!   [ 2, 1, 1 ], [ 2, 1, 1 ],
#!   [ 2, 3, 1 ]
#! ]
#! @EndExampleSession
#!
DeclareAttribute("DiagonalOfMultiplicationTable", IsMagma);

#! @Arguments M
#! @Description
#! identifies commutativity index of <A>M</A>.
#!
#! @BeginExampleSession
#! 
#! @EndExampleSession
#!
DeclareAttribute("CommutativityIndex", IsMagma);

#! @Arguments M
#! @Description
#! calculates anticommutativity index of <A>M</A>.
#!
#! @BeginExampleSession
#! @EndExampleSession
#!
DeclareAttribute("AnticommutativityIndex", IsMagma);

#! @Arguments M
#! @Description
#! computes squares index of <A>M</A> so the order of $\left\{ m^2 | m \in M \right\}$.
#!
#! @BeginExampleSession
#! gap> List(AllSmallAntimagmas(2), M -> List(M, m -> m * m));                
#! [ [ m2, m1 ] ]
#! gap> List(AllSmallAntimagmas(2), M -> SquaresIndex(M));
#! [ 2 ]
#! gap> List(AllSmallAntimagmas(3), M -> SquaresIndex(M));
#! [ 2, 2, 2, 2, 3 ]
#! @EndExampleSession
#!
DeclareAttribute("SquaresIndex", IsMagma);

#! @Arguments M
#! @Description
#! builds a collection of non-isomorphic submagmas of <A>M</A>.
#!
#! @BeginExampleSession
#! gap> AllSmallAntimagmas(2);
#! [ <magma with 2 generators> ]
#! gap> List(AllSmallAntimagmas(2), M -> AllSubmagmas(M));
#! [ [ <magma with 1 generator> ] ]
#! @EndExampleSession
#!
DeclareGlobalFunction("AllSubmagmas");

#! @Arguments M
#! @Description
#! identifies class of antiassociative magma <A>M</A>.
#!
#! @BeginExampleSession
#! gap> IsAntiassociative(CyclicGroup(16));
#! false
#! gap> IsAntiassociative(OneSmallAntimagma(2));
#! true
#! gap> IsAntiassociative(OneSmallAntimagma(3));
#! true
#! @EndExampleSession
#!
DeclareAttribute("IdSmallAntimagma", IsMagma);

#! @Arguments M
#! @Description
#! computes isomorphism invariants of <A>M</A>.
DeclareGlobalFunction("MagmaIsomorphismInvariantsMatch");

#! @Arguments M, N
#! @Description
#! computes an isomoprhism between magmas <A>M</A>, <A>N</A>.
#!
#! @BeginExampleSession
#! gap> M := SmallAntimagma(2, 1);
#! <magma with 2 generators>
#! gap> N := MagmaByMultiplicationTable([[2, 1], [2, 1]]);
#! <magma with 2 generators>
#! gap> MagmaIsomorphism(M, N);
#! <general mapping: Domain([ m1, m2 ]) -> Domain([ m1, m2 ]) >
#! @EndExampleSession
#!
DeclareOperation("MagmaIsomorphism", [IsMagma, IsMagma]);

#! @Arguments M, N
#! @Description
#!  creates an antiisomoprhism between magmas <A>M</A>, <A>N</A>.
#!
#! @BeginExampleSession
#! gap> M := SmallAntimagma(2, 1);
#! <magma with 2 generators>
#! gap> N := TransposedMagma(M);
#! <magma with 2 generators>
#! gap> MagmaAntiisomorphism(M, N);
#! <mapping: Domain([ m1, m2 ]) -> Domain([ m1, m2 ]) >
#! @EndExampleSession
#!
DeclareOperation("MagmaAntiisomorphism", [IsMagma, IsMagma]);

#! @Arguments M, N
#! @Description
#!  identifies whether magmas <A>M</A>, <A>N</A> are isomorphic.
#!
#! @BeginExampleSession
#! gap> M := SmallAntimagma(2, 1);
#! <magma with 2 generators>
#! gap> N := TransposedMagma(M);
#! <magma with 2 generators>
#! gap> T := MagmaByMultiplicationTable([[2, 1], [2, 1]]);
#! <magma with 2 generators>
#! gap> IsMagmaIsomorphic(M, M);
#! true
#! gap> IsMagmaIsomorphic(M, T);
#! true
#! gap> IsMagmaIsomorphic(M, N);
#! false
#! @EndExampleSession
#!
DeclareGlobalFunction("IsMagmaIsomorphic");

#! @Arguments M, N
#! @Description
#! identifies whether magmas <A>M</A>, <A>N</A> are antiisomorphic.
#!
#! @BeginExampleSession
#! gap> N := SmallAntimagma(2, 1);
#! <magma with 2 generators>
#! gap> M := SmallAntimagma(2, 1);
#! <magma with 2 generators>
#! gap> N := TransposedMagma(M);
#! <magma with 2 generators>
#! gap> IsMagmaAntiisomorphic(M, M);
#! false
#! gap> IsMagmaAntiisomorphic(M, N);
#! true
#! gap> IsMagmaAntiisomorphic(M, TransposedMagma(M));
#! true
#! @EndExampleSession
#!
DeclareGlobalFunction("IsMagmaAntiisomorphic");

#! @Arguments M
#! @Description
#! generates transposed magma <A>M</A>.
#!
#! @BeginExampleSession
#! gap> M := SmallAntimagma(2, 1);
#! <magma with 2 generators>
#! gap> IsMagmaAntiisomorphic(M, TransposedMagma(M));
#! true
#! gap> IsMagmaIsomorphic(M, TransposedMagma(TransposedMagma(M)));
#! true
#! gap> M := SmallAntimagma(2, 1);
#! <magma with 2 generators>
#! gap> Display(MultiplicationTable(M));
#! [ [  2,  1 ],
#!   [  2,  1 ] ]
#! gap> Display(MultiplicationTable(TransposedMagma(M)));
#! [ [  2,  2 ],
#!   [  1,  1 ] ]
#! @EndExampleSession
#!
DeclareGlobalFunction("TransposedMagma");

#! @Arguments m, k
#! @Description
#! returns a left $k$-power of element <A>m</A>.
DeclareGlobalFunction("LeftPower");

#! @Arguments m, k
#! @Description
#!  returns a right $k$-power of element <A>m</A>.
DeclareGlobalFunction("RightPower");

#! @Arguments m
#! @Description
#! returns a left order of element <A>m</A>.
DeclareAttribute("LeftOrder", IsExtLElement);

#! @Arguments m
#! @Description
#!  returns a right order of element <A>m</A>.
DeclareAttribute("RightOrder", IsExtRElement);

#! @Arguments m
#! @Description
#! returns a left order of element <A>m</A>.
DeclareAttribute("LeftOrdersOfElements", IsMagma);

#! @Arguments m
#! @Description
#! returns a left order of element <A>m</A>.
DeclareAttribute("RightOrdersOfElements", IsMagma);

#! @Arguments M
#! @Description
#!  if magma is left cyclic <A>m</A>.
DeclareProperty("IsLeftCyclic", IsMagma);

#! @Arguments M
#! @Description
#!  if magma is right cyclic <A>m</A>.
DeclareProperty("IsRightCyclic", IsMagma);

#! @Arguments M
#! @Description
#!  if magma is left distributive <A>m</A>.
#!
#! @BeginExampleSession
#! gap> List(AllSmallAntimagmas(3), M -> IsLeftDistributive(M));
#! [ true, false, false, false, false ]
#! @EndExampleSession
#!
DeclareProperty("IsLeftDistributive", IsMagma);

#! @Arguments M
#! @Description
#!  if magma is right distributive <A>m</A>.
#!
#! @BeginExampleSession
#! gap> List(AllSmallAntimagmas(3), M -> IsRightDistributive(M));
#! [ false, false, false, false, true ]
#! @EndExampleSession
#!
DeclareProperty("IsRightDistributive", IsMagma);

#! @Arguments M
#! @Description
#!  if magma is left cancellative <A>m</A>.
#!
#! @BeginExampleSession
#! gap> M := SmallAntimagma(2, 1);
#! <magma with 2 generators>
#! gap> Display(MultiplicationTable(M));
#! [ [  2,  1 ],
#!   [  2,  1 ] ]
#! gap> IsRightCancellative(M);
#! false
#! gap> IsLeftCancellative(M);
#! true
#! gap> List(AllSmallAntimagmas(2), M -> IsLeftCancellative(M));
#! [ true ]
#! @EndExampleSession
#!
DeclareProperty("IsLeftCancellative", IsMagma);

#! @Arguments M
#! @Description
#!  if magma is right cancellative <A>m</A>.
#!
#! @BeginExampleSession
#! gap> List(AllSmallAntimagmas(2), M -> IsRightCancellative(M));
#! [ false ]
#! @EndExampleSession
#!
DeclareProperty("IsRightCancellative", IsMagma);

#! @Arguments M
#! @Description
#! if magma is cancellative <A>m</A>.
#!
#! @BeginExampleSession
#! gap> List(AllSmallAntimagmas(2), M -> IsCancellative(M));
#! [ false ]
#! @EndExampleSession
#!
DeclareProperty("IsCancellative", IsMagma);

#! @Arguments M
#! @Description
#! is a left-hand sided fixed-point free inducted <A>m</A>.
#!
#! @BeginExampleSession
#! gap> Display(MultiplicationTable(TransposedMagma(SmallAntimagma(2, 1))));
#! [ [  2,  2 ],
#!   [  1,  1 ] ]
#! gap> IsLeftFPFInducted(TransposedMagma(SmallAntimagma(2, 1)));
#! true
#! @EndExampleSession
#!
DeclareProperty("IsLeftFPFInducted", IsMagma);

#! @Arguments M
#! @Description
#! is a right-hand sided fixed-point free inducted <A>m</A>.
#!
#! @BeginExampleSession
#! gap> Display(MultiplicationTable(SmallAntimagma(2, 1)));
#! [ [  2,  1 ],
#!   [  2,  1 ] ]
#! gap> IsRightFPFInducted(SmallAntimagma(2, 1));
#! true
#! @EndExampleSession
#!
#!
DeclareProperty("IsRightFPFInducted", IsMagma);

#! @Arguments M
#! @Description
#! whether <A>M</A> has property (A2) of <Cite Key="Mazurek2025"/>: there
#! is a partition <M>P</M> of <A>M</A> and a derangement <M>d</M> of
#! <M>P</M> with <M>xM \subseteq d(B)</M> for all <M>B \in P</M>,
#! <M>x \in B</M>.
#!
#! Any <M>x \in xM</M> refutes (A2). Below, <M>f</M> denotes the diagonal
#! endofunction <M>x \mapsto xx</M> of <A>M</A>.
#!
#! <M>n = 2</M>, <M>f</M> the transposition:
#!
#! @BeginExampleSession
#! gap> M := TransposedMagma(SmallAntimagma(2, 1));;
#! gap> Display(MultiplicationTable(M));
#! [ [  2,  2 ],
#!   [  1,  1 ] ]
#! gap> partition := List(Elements(M), x -> [x]);;
#! gap> List(partition, B -> List(Unique(B[1] * Elements(M)),
#! >      y -> Position(Elements(M), y)));
#! [ [ 2 ], [ 1 ] ]
#! gap> IsLeftDerangementInducted(M);
#! true
#! @EndExampleSession
#!
#! <M>n = 3</M>, <M>f</M> a 3-cycle:
#!
#! @BeginExampleSession
#! gap> M := SmallAntimagma(3, 5);;
#! gap> Display(MultiplicationTable(M));
#! [ [  2,  2,  2 ],
#!   [  3,  3,  3 ],
#!   [  1,  1,  1 ] ]
#! gap> partition := List(Elements(M), x -> [x]);;
#! gap> List(partition, B -> List(Unique(B[1] * Elements(M)),
#! >      y -> Position(Elements(M), y)));
#! [ [ 2 ], [ 3 ], [ 1 ] ]
#! gap> IsLeftDerangementInducted(M);
#! true
#! @EndExampleSession
#!
#! <M>n = 4</M>, failing (A2) although <M>x \notin xM</M> for all
#! <M>x</M>: here <M>f</M> alone does not decide, since <M>m_2</M> and
#! <M>m_3</M> have non-constant left translations. From
#! <M>m_2 M = \{m_1, m_3\}</M> the block <M>C \ni m_1</M> also contains
#! <M>m_3</M>, whence
#! <M>d(C) \supseteq m_1 M \cup m_3 M = \{m_1, m_2, m_4\}</M> meets
#! <M>C</M>, so <M>d(C) = C</M>.
#!
#! @BeginExampleSession
#! gap> M := SmallAntimagma(4, 8313);;
#! gap> Display(MultiplicationTable(M));
#! [ [  2,  2,  2,  2 ],
#!   [  3,  3,  1,  1 ],
#!   [  4,  4,  1,  1 ],
#!   [  2,  2,  2,  2 ] ]
#! gap> List(Elements(M), x -> List(Set(x * Elements(M)),
#! >      y -> Position(Elements(M), y)));
#! [ [ 2 ], [ 1, 3 ], [ 1, 4 ], [ 2 ] ]
#! gap> ForAny(Elements(M), x -> x in Set(x * Elements(M)));
#! false
#! gap> IsLeftDerangementInducted(M);
#! false
#! @EndExampleSession
#!
#! (A2) is not left-right symmetric:
#!
#! @BeginExampleSession
#! gap> M := TransposedMagma(SmallAntimagma(2, 1));;
#! gap> IsLeftDerangementInducted(M);
#! true
#! gap> IsRightDerangementInducted(M);
#! false
#! @EndExampleSession
#!
DeclareProperty("IsLeftDerangementInducted", IsMagma);

#! @Arguments M
#! @Description
#! is a right-hand sided derangment inducted <A>m</A>.
#! The verification follows the endofunction algorithm
#! of <Cite Key="MazurekZabielski2026"/>.
#!
#! @BeginExampleSession
#! gap> M := SmallAntimagma(2, 1);
#! <magma with 2 generators>
#! gap> IsLeftFPFInducted(M);
#! false
#! gap> IsRightFPFInducted(M);
#! true
#! gap> IsRightDerangementInducted(M);
#! true
#! @EndExampleSession
#!
#!
DeclareProperty("IsRightDerangementInducted", IsMagma);

#! @Arguments M
#! @Description
#! is a left-alternatve magma <A>M</A>.
#!
#! @BeginExampleSession
#! @EndExampleSession
#!
DeclareProperty("IsLeftAlternative", IsMagma);

#! @Arguments M
#! @Description
#! is a right-alternatve magma <A>M</A>.
#!
#! @BeginExampleSession
#! @EndExampleSession
#!
DeclareProperty("IsRightAlternative", IsMagma);

#! @Arguments M
#! @Description
#! builds a digraph from the diagonal of <A>M</A>.
#!
#! @BeginExampleSession
#! @EndExampleSession
#!
DeclareAttribute("DigraphOfDiagonal", IsMagma);
