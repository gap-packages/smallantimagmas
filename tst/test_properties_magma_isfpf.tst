gap> START_TEST( "test_properties_magma_isfpf.tst" );

gap> M := MagmaByMultiplicationTable([ [1, 1], [2, 2] ] );;
gap> IsLeftFPFInducted(MagmaByMultiplicationTable([ [1, 1], [2, 2] ] ));
false
gap> IsRightFPFInducted(MagmaByMultiplicationTable([ [1, 1], [2, 2] ] ));
false

gap> M := SmallAntimagma(2, 1);      
<magma with 2 generators>
gap> IsLeftFPFInducted( M );
false
gap> IsRightFPFInducted( M );
true

gap> Filtered( Filtered(AllSmallAntimagmas([2 .. 3]), M -> IsLeftFPFInducted(M)), M -> IsRightFPFInducted(M) );
[  ]

gap> STOP_TEST( "test_properties_magma_isfpf.tst" );