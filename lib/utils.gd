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
#!  generates transposed magma <A>M</A> (a string) 
DeclareGlobalFunction( "TransposedMagma" );

#! @Arguments [m, k]
#! @Description
#!  returns a left $k$-power of element <A>m</A>.
DeclareGlobalFunction( "LeftPower" );

#! @Arguments [m, k]
#! @Description
#!  returns a right $k$-power of element <A>m</A>.
DeclareGlobalFunction( "RightPower" );

#! @Arguments [m, k]
#! @Description
#!  returns a left order of element <A>m</A>.
DeclareGlobalFunction( "LeftOrder" );

#! @Arguments [m, k]
#! @Description
#!  returns a right order of element <A>m</A>.
DeclareGlobalFunction( "RightOrder" );

#! @Arguments [m, k]
#! @Description
#!  if magma is left cyclic <A>m</A>.
DeclareGlobalFunction( "IsLeftCyclic" );

#! @Arguments [m, k]
#! @Description
#!  if magma is left cyclic <A>m</A>.
DeclareGlobalFunction( "IsRightCyclic" );

#! @Arguments [m, k]
#! @Description
#!  if magma is right cancellative <A>m</A>.
DeclareGlobalFunction( "IsRightCancellative" );

#! @Arguments [m, k]
#! @Description
#!  if magma is left cancellative <A>m</A>.
DeclareGlobalFunction( "IsLeftCancellative" );

#! @Arguments [m, k]
#! @Description
#!  if magma is cancellative <A>m</A>.
DeclareGlobalFunction( "IsCancellative" );

#! @Arguments [M]
#! @Description
#!  identifies whether magma <A>M</A> (a string) 
#!  has property A3.
DeclareGlobalFunction( "HasPropertyA3" );
