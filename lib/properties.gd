#! @Arguments M
#! @Description
#! identifies whether magma <A>M</A> is antiassociative <Cite Key="Rogers1963"/>.
#! A magma <A>M</A> is antiassociative if
#! <M>(x * y) * z \neq x * (y * z)</M> holds for all <M>x, y, z \in M</M>,
#! i.e. associativity fails for every triple of elements.
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
#! identifies whether magma <A>M</A> is left cancellative.
#! A magma <A>M</A> is left cancellative if
#! <M>z * x = z * y</M> implies <M>x = y</M> for all <M>x, y, z \in M</M>,
#! i.e. for each <M>z \in M</M> the left translation <M>x \mapsto z * x</M>
#! is injective.
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
#! identifies whether magma <A>M</A> is right cancellative.
#! A magma <A>M</A> is right cancellative if
#! <M>x * z = y * z</M> implies <M>x = y</M> for all <M>x, y, z \in M</M>,
#! i.e. for each <M>z \in M</M> the right translation <M>x \mapsto x * z</M>
#! is injective.
#!
#! @BeginExampleSession
#! gap> List(AllSmallAntimagmas(2), M -> IsRightCancellative(M));
#! [ false ]
#! gap> M := SmallAntimagma(3, 5);
#! <magma with 3 generators>
#! gap> Display(MultiplicationTable(M));
#! [ [  2,  2,  2 ],
#!   [  3,  3,  3 ],
#!   [  1,  1,  1 ] ]
#! gap> IsRightCancellative(M);
#! true
#! gap> IsLeftCancellative(M);
#! false
#! gap> List(AllSmallAntimagmas(3), M -> IsRightCancellative(M));
#! [ false, false, false, false, true ]
#! @EndExampleSession
#!
DeclareProperty("IsRightCancellative", IsMagma);

#! @Arguments M
#! @Description
#! identifies whether magma <A>M</A> is cancellative.
#! A magma <A>M</A> is cancellative if it is both left cancellative and
#! right cancellative, i.e. <M>z * x = z * y</M> implies <M>x = y</M> and
#! <M>x * z = y * z</M> implies <M>x = y</M> for all <M>x, y, z \in M</M>.
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
#! is a left-hand sided derangment inducted <A>m</A>.
#! The verification follows the endofunction algorithm
#! of <Cite Key="MazurekZabielski2026"/>.
#!
#! @BeginExampleSession
#! gap> M := TransposedMagma(SmallAntimagma(2, 1));
#! <magma with 2 generators>
#! gap> IsLeftFPFInducted(M);
#! true
#! gap> IsRightFPFInducted(M);
#! false
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
