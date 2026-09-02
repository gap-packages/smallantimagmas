gap> START_TEST("test_properties_magma_isomorphism_invariants.tst");

gap> List([2 .. 3], n -> List(AllSmallAntimagmas(n), M -> MagmaIsomorphismInvariantsMatch(M, TransposedMagma(M))));
[ [ false ], 
  [ false, false, false, false, false ] 
]

## MagmaAntiisomorphism(M, TransposedMagma(M)) <> fail
gap> List(AllSmallAntimagmas([2 .. 3]), M -> MagmaAntiisomorphism(M, TransposedMagma(M)) <> fail);
[ true, true, true, true, true, true ]

## MagmaAntiisomorphism(M, M) = fail
gap> List(AllSmallAntimagmas([2 .. 3]), M -> MagmaAntiisomorphism(M, M) <> fail);
[ false, false, false, false, false, false ]

## MagmaAntiisomorphism(M, N) = fail when Size(M) <> Size(N)
gap> List(Cartesian(AllSmallAntimagmas(2), AllSmallAntimagmas(3)), c -> MagmaAntiisomorphism(c[1], c[2]));
[ fail, fail, fail, fail, fail ]

## psi(x * y) = psi(y) * psi(x) for psi = MagmaAntiisomorphism(M, TransposedMagma(M))
gap> ForAll(AllSmallAntimagmas([2 .. 3]), function(M)
>        local psi;
>        psi := MagmaAntiisomorphism(M, TransposedMagma(M));
>        return ForAll(EnumeratorOfTuples(Elements(M), 2), t -> psi(t[1] * t[2]) = psi(t[2]) * psi(t[1]));
>    end);
true

gap> STOP_TEST("test_properties_magma_isomorphism_invariants.tst");
