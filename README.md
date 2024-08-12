## smallantimagmas

`smallgrp` alternative for _antiassociative magmas_.


### Installation

To install the `smallantimagmas` package, simply place it into the `pkg` directory.


### Prover9

To classify all antimagmas, one can use `mace4`.

```
mace4 < ./.prover9/antimagma.in
```

To classify all antimagmas up to the isomorphism.

```
mace4 < ./.prover9/antimagma.in | interpformat standard > antimagma.interps
isofilter < antimagma.interps > antimagma.interps_uptoisomorphism
```
