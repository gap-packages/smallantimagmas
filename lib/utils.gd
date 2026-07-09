#! @Arguments n
#! @Description
#! returns all possible diagonals of multiplication table for <A>[n]</A>-antimagma.
#!
#! @BeginExampleSession
#! gap> AntimagmaGeneratorPossibleDiagonals(2);
#! [ [ 2, 1 ] ]
#! gap> AntimagmaGeneratorPossibleDiagonals(3);
#! [
#!   [ 2, 1, 1 ], [ 2, 1, 2 ], [ 2, 3, 1 ], [ 2, 3, 2 ],
#!   [ 3, 1, 1 ], [ 3, 1, 2 ], [ 3, 3, 1 ], [ 3, 3, 2 ]
#! ]
#! @EndExampleSession
#!

DeclareOperation("AntimagmaGeneratorPossibleDiagonals", [IsInt]);

#! @Arguments Ms
#! @Description
#! filters non-isomorphic magmas <A>Ms</A>.

DeclareOperation("UpToIsomorphism", [IsList]);

#! @Arguments Ms
#! @Description
#! filters magmas <A>Ms</A> up to isomorphism and anti-isomorphism, i.e. keeps
#! a single representative for every class of magmas that are pairwise
#! isomorphic or anti-isomorphic.
#!
#! @BeginExampleSession
#! gap> UpToIsomorphismAndAntiisomorphism(AllSmallAntimagmas(2));
#! [ <magma with 2 generators> ]
#! @EndExampleSession

DeclareOperation("UpToIsomorphismAndAntiisomorphism", [IsList]);
