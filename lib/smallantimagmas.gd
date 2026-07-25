#! @Arguments n
#! @Description
#! returns all antiassociative magmas of specified size <A>n</A> (a number), up to
#! isomorphism and anti-isomorphism, i.e. keeping a single representative for every
#! class of magmas that are pairwise isomorphic or anti-isomorphic.
#!
#! @BeginExampleSession
#! gap> AllSmallAntimagmas(2);
#! [ <magma with 2 generators> ]
#! gap> AllSmallAntimagmas(3);
#! [ 
#!   <magma with 3 generators>, <magma with 3 generators>, <magma with 3 generators>,
#!   <magma with 3 generators>, <magma with 3 generators>
#! ]
#! @EndExampleSession
#!
DeclareGlobalFunction("AllSmallAntimagmas");

#! @Arguments n
#! @Description
#! counts number of antiassociative magmas of specified size <A>n</A> (a number), up to
#! isomorphism and anti-isomorphism.
#!
#! @BeginExampleSession
#! gap> NrSmallAntimagmas(2);
#! 1
#! gap> NrSmallAntimagmas(3);
#! 5
#! gap> NrSmallAntimagmas(4);
#! 8891
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

