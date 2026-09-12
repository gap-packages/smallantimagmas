gap> START_TEST("test_helper_argument_checks.tst");

## NrSmallAntimagmas(order) rejects non-integer order
gap> NrSmallAntimagmas("2");
Error, smallantimagmas: <order> must be an integer

## NrSmallAntimagmas(order) rejects order < 2
gap> NrSmallAntimagmas(1);
Error, smallantimagmas: <order> must be greater than or equal to 2

## NrSmallAntimagmas(order) rejects order with no data directory
gap> NrSmallAntimagmas(9);
Error, smallantimagmas: <order> is not yet implemented

## AllSmallAntimagmas(order) reaches checkOrder
gap> AllSmallAntimagmas(0);
Error, smallantimagmas: <order> must be greater than or equal to 2

## SmallAntimagma(order, id) reaches checkOrder
gap> SmallAntimagma(1, 1);
Error, smallantimagmas: <order> must be greater than or equal to 2

## getSmallAntimagmaMetadataDirectory(order) rejects order with no data directory
gap> __SmallAntimagmaHelper.getSmallAntimagmaMetadataDirectory(9);
Error, smallantimagmas: <order> is not yet implemented

## AllSmallAntimagmas(order, view) rejects a non-string view
gap> AllSmallAntimagmas(2, 7);
Error, smallantimagmas: expected (<order>) or (<order>, <view>)

## AllSmallAntimagmas(order, view) rejects more than one view
gap> AllSmallAntimagmas(2, "labelled", "labelled");
Error, smallantimagmas: expected (<order>) or (<order>, <view>)

## NrSmallAntimagmas(order, view) rejects an unknown view
gap> width := SizeScreen();;
gap> SizeScreen([256, 24]);;
gap> NrSmallAntimagmas(2, "nope");
Error, smallantimagmas: <view> must be one of labelled, up-to-isomorphism, up-to-isomorphism-antiisomorphism
gap> SizeScreen(width);;

## SmallAntimagma(arg...) rejects a single non-list argument
gap> SmallAntimagma(2);
Error, SmallAntimagma: expected (n, i) or [n, i]

## SmallAntimagma(arg...) rejects a list of length <> 2
gap> SmallAntimagma([2, 1, 1]);
Error, SmallAntimagma: expected (n, i) or [n, i]

## SmallAntimagma(arg...) rejects non-integer entries
gap> SmallAntimagma(2, "1");
Error, SmallAntimagma: expected (n, i) or [n, i]

## SmallAntimagma(order, id) rejects id < 1
gap> SmallAntimagma(2, 0);
Error, smallantimagmas: <id> must be greater than or equal to 1

gap> SmallAntimagma([3, -1]);
Error, smallantimagmas: <id> must be greater than or equal to 1

## checkId rejects a non-integer id
gap> __SmallAntimagmaHelper.checkId("1");
Error, smallantimagmas: <id> must be an integer

## checkOrderId checks the order first, then the id
gap> __SmallAntimagmaHelper.checkOrderId(1, 0);
Error, smallantimagmas: <order> must be greater than or equal to 2

gap> __SmallAntimagmaHelper.checkOrderId(2, 0);
Error, smallantimagmas: <id> must be greater than or equal to 1

gap> STOP_TEST("test_helper_argument_checks.tst");
