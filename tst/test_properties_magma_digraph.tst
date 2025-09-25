gap> START_TEST("test_properties_magma_digraph.tst");

## all digraps must have as many edges as number of elements in antimagma
gap> ForAll(AllSmallAntimagmas([2..3]), M -> DigraphNrEdges(DigraphOfDiagonal(M)) = Size(M));
true

## all digraps must have as many vertices as number of elements in antimagma
gap> ForAll(AllSmallAntimagmas([2..3]), M -> DigraphNrVertices(DigraphOfDiagonal(M)) = Size(M));
true

## all digraps must not have loops
gap> ForAll(AllSmallAntimagmas([2..3]), M -> DigraphNrLoops(DigraphOfDiagonal(M)) = 0 );
true

## transposed antimagma have equal diagonal digraphs
gap> ForAll(AllSmallAntimagmas([2..3]), M -> DigraphOfDiagonal(M) = DigraphOfDiagonal(TransposedMagma(M)) );
true

## all isomorphisc magmas must have isomorphic digraphs
gap> ForAll(AllSmallAntimagmas([2..3]), M -> ForAll(Filtered(ReallyAllSmallAntimagmas(Size(M)), N -> IsMagmaIsomorphic(M, N)), N -> IsIsomorphicDigraph(DigraphOfDiagonal(N), DigraphOfDiagonal(M))));
true

gap> STOP_TEST("test_properties_magma_digraph.tst");