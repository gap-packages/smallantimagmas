gap> START_TEST("test_properties_magma_digraph.tst");

## all diagonal digraphs must have as many edges as number of elements in antimagma
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> DigraphNrEdges(DigraphOfDiagonal(M)) = Size(M));
true

## all diagonal digraphs must have as many edges as number of elements in antimagma
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> DigraphNrVertices(DigraphOfDiagonal(M)) = Size(M));
true

## all diagonal digraphs must not have loops
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> DigraphNrLoops(DigraphOfDiagonal(M)) = 0);
true

## for any antimagma it is true its that its transposition have equal diagonal digraph
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> DigraphOfDiagonal(M) = DigraphOfDiagonal(TransposedMagma(M)));
true

## all isomorphic magmas must have isomorphic digraphs
gap> ForAll(AllSmallAntimagmas([2 .. 3]), M -> ForAll(Filtered(ReallyAllSmallAntimagmas(Size(M)), N -> IsMagmaIsomorphic(M, N)), N -> IsIsomorphicDigraph(DigraphOfDiagonal(N), DigraphOfDiagonal(M))));
true

gap> STOP_TEST("test_properties_magma_digraph.tst");