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

## SmallAntimagma(arg...) rejects a single non-list argument
gap> SmallAntimagma(2);
Error, SmallAntimagma: expected (n, i) or [n, i]

## SmallAntimagma(arg...) rejects a list of length <> 2
gap> SmallAntimagma([2, 1, 1]);
Error, SmallAntimagma: expected (n, i) or [n, i]

## SmallAntimagma(arg...) rejects non-integer entries
gap> SmallAntimagma(2, "1");
Error, SmallAntimagma: expected (n, i) or [n, i]

gap> STOP_TEST("test_helper_argument_checks.tst");
