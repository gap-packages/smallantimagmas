# SmallAntimagmasInformation Implementation

This implementation adds functionality similar to `SmallGroupInformation` from the `smallgrp` package.

## New Functions

### `SmallAntimagmasInformation(n)`
Returns a record with information about antiassociative magmas of order `n`:
- `total`: Total number of antiassociative magmas (including isomorphic copies)
- `upToIsomorphism`: Number of antiassociative magmas up to isomorphism
- `upToIsomorphismAndAntiisomorphism`: Number of antiassociative magmas up to isomorphism and anti-isomorphism

### `NrSmallAntimagmasUpToAntiisomorphism(n)`
Returns the number of antiassociative magmas of order `n` up to isomorphism and anti-isomorphism.

## Mathematical Relationships

The following relationships always hold:
```
upToIsomorphismAndAntiisomorphism ≤ upToIsomorphism ≤ total
```

This is because:
1. Anti-isomorphism provides an additional equivalence relation beyond isomorphism
2. Considering anti-isomorphism can only reduce or maintain the number of equivalence classes
3. Isomorphism alone partitions the set of all magmas into equivalence classes

## Implementation Details

The `NrSmallAntimagmasUpToAntiisomorphism` function:
1. Starts with all magmas up to isomorphism (using `AllSmallAntimagmas`)
2. Iteratively checks if each magma is anti-isomorphic to any previously processed magma
3. Only counts magmas that are not anti-isomorphic to any previous magma
4. Returns the count of equivalence classes under both isomorphism and anti-isomorphism

## Usage Example

```gap
gap> info := SmallAntimagmasInformation(3);
rec( total := 52, upToIsomorphism := 10, upToIsomorphismAndAntiisomorphism := 7 )

gap> NrSmallAntimagmasUpToAntiisomorphism(2);
1
```

## Files Modified

- `lib/smallantimagmas.gd`: Added function declarations
- `lib/smallantimagmas.gi`: Added function implementations  
- `tst/test_smallantimagmas_information.tst`: Added comprehensive tests