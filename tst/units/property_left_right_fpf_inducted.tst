gap> START_TEST("property_left_right_fpf_inducted.tst");

## fixed-point-free failes for operations with fixed points
gap> IsLeftFPFInducted(MagmaByMultiplicationTable([[1, 1], [2, 2]]));
false

## fixed-point-free failes for operations with fixed points
gap> IsRightFPFInducted(MagmaByMultiplicationTable([[1, 2], [1, 2]]));
false

## fixed-point-free failes for operations with fixed points
gap> IsRightFPFInducted(MagmaByMultiplicationTable([[1, 1], [2, 2]]));
false

## no-fixed-point-free-antimagma-is-both-left-hand-and-right-hand
gap> Filtered(Filtered(AllSmallAntimagmas([2 .. 3]), M -> IsLeftFPFInducted(M)), M -> IsRightFPFInducted(M));
[  ]

gap> STOP_TEST("property_left_right_fpf_inducted.tst");
