#! @Arguments [M]
#! @Description
#!  identifies whether magma <A>M</A> (a string) 
#!  is antiassociative magma.
DeclareGlobalFunction( "IsAntiassociative" );

#! @Arguments [M, N]
#! @Description
#!  creates an isomoprhism between magmas <A>M</A>, <A>N</A> (a string) .
DeclareGlobalFunction( "MagmaIsomorphism" );

#! @Arguments [M, N]
#! @Description
#!  creates an antiisomoprhism between magmas <A>M</A>, <A>N</A> (a string) .
DeclareGlobalFunction( "MagmaAntiisomorphism" );

#! @Arguments [M, N]
#! @Description
#!  identifies whether magmas <A>M</A>, <A>N</A> (a string) 
#!  are isomorphic.
DeclareGlobalFunction( "IsMagmaIsomorphic" );


#! @Arguments [M, N]
#! @Description
#!  identifies whether magmas <A>M</A>, <A>N</A> (a string) 
#!  are anti-isomorphic.
DeclareGlobalFunction( "IsMagmaAntiisomorphic" );


#! @Arguments [M]
#! @Description
#!  identifies whether magma <A>M</A> (a string) 
#!  has property A3.
DeclareGlobalFunction( "HasPropertyA3" );
