gap> START_TEST("property_associativity_index.tst");

#@if IsPackageMarkedForLoading( "smallgrp", "" )
gap> ForAll(AllSmallGroups([2 .. 12]), M -> AssociativityIndex(M) = Size(M) ^ 3);
true
#@fi

gap>  ForAll(AllSmallAntimagmas([2 .. 3]), M -> AssociativityIndex(M) = 0);
true

gap> STOP_TEST("property_associativity_index.tst");
