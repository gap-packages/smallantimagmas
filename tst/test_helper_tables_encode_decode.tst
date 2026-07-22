gap> START_TEST("test_helper_tables_encode_decode.tst");

# ------------------------------------------------------------------
# The data files store, for each order n, a list of "tables in row
# form": every multiplication table is first converted (row by row,
# via MultiplicationTableConvert) into a list of n integers in the
# range [1 .. n^n], each integer being the position of the row in
# EnumeratorOfTuples([1 .. n], n).
#
# TablesEncode then packs each such list into a single integer in
# base n^n, sorts all integers, and stores only the differences
# (deltas) between consecutive ones. TablesDecode is the inverse.
# ------------------------------------------------------------------

# Step 1: a table in row form is a base-(n^n) number.
# For n = 2 the base is 2^2 = 4, digits are (row index - 1).
# [3, 3] -> (3 - 1) * 4 + (3 - 1) = 10, first delta is taken from 0.
gap> __SmallAntimagmaHelper.TablesEncode(2, [[3, 3]]);
[ 10 ]

# Step 2: a singleton decodes right back.
gap> __SmallAntimagmaHelper.TablesDecode(2, [10]);
[ [ 3, 3 ] ]

# Step 3: several tables; encoded numbers are 10, 4 * (2-1) + (4-1) = 7
# and 4 * (4-1) + (1-1) = 12. After sorting (7, 10, 12) the stored
# deltas are 7, 10 - 7 = 3 and 12 - 10 = 2.
gap> __SmallAntimagmaHelper.TablesEncode(2, [[3, 3], [2, 4], [4, 1]]);
[ 7, 3, 2 ]

# Step 4: decoding computes the prefix sums 7, 10, 12 and unpacks
# every number back into base-(n^n) digits; note the sorted order.
gap> __SmallAntimagmaHelper.TablesDecode(2, [7, 3, 2]);
[ [ 2, 4 ], [ 3, 3 ], [ 4, 1 ] ]

# Duplicates survive encoding as deltas equal to 0.
gap> __SmallAntimagmaHelper.TablesEncode(2, [[3, 3], [3, 3]]);
[ 10, 0 ]

gap> __SmallAntimagmaHelper.TablesDecode(2, [10, 0]);
[ [ 3, 3 ], [ 3, 3 ] ]

# Edge cases: the empty list, the smallest and the largest table.
gap> __SmallAntimagmaHelper.TablesEncode(3, []);
[  ]

gap> __SmallAntimagmaHelper.TablesEncode(3, [[1, 1, 1]]);
[ 0 ]

gap> __SmallAntimagmaHelper.TablesEncode(3, [[27, 27, 27]]) = [27 ^ 3 - 1];
true

# The order-3 data as stored in data/3: the tables in
# row form are [10, 10, 10], [10, 10, 19], [10, 19, 10], [10, 19, 19]
# and [14, 27, 1], i.e. the base-27 numbers 6813, 6822, 7056, 7065
# and 10179, hence the deltas below.
gap> __SmallAntimagmaHelper.TablesEncode(3,
> [[10, 10, 10], [10, 10, 19], [10, 19, 10], [10, 19, 19], [14, 27, 1]]);
[ 6813, 9, 234, 9, 3114 ]

gap> __SmallAntimagmaHelper.TablesDecode(3, [6813, 9, 234, 9, 3114]);
[ [ 10, 10, 10 ], [ 10, 10, 19 ], [ 10, 19, 10 ], [ 10, 19, 19 ],
  [ 14, 27, 1 ] ]

# Encoding is invariant under permutations of the input (the encoder
# sorts), so decode-after-encode returns the sorted input.
gap> __SmallAntimagmaHelper.TablesEncode(3, [[14, 27, 1], [10, 10, 10]]);
[ 6813, 3366 ]

gap> __SmallAntimagmaHelper.TablesDecode(3,
> __SmallAntimagmaHelper.TablesEncode(3, [[14, 27, 1], [10, 10, 10]]));
[ [ 10, 10, 10 ], [ 14, 27, 1 ] ]

# Round-trip on all shipped data: for every order the stored tables
# are already sorted, so decode(encode(...)) is the identity.
gap> ForAll([2 .. 4], n -> __SmallAntimagmaHelper.TablesDecode(n,
> __SmallAntimagmaHelper.TablesEncode(n,
> __SmallAntimagmaHelper.getSmallAntimagmaMetadata(n)()))
> = __SmallAntimagmaHelper.getSmallAntimagmaMetadata(n)());
true

gap> ForAll([2 .. 4],
> n -> IsSortedList(__SmallAntimagmaHelper.getSmallAntimagmaMetadata(n)()));
true

# Deltas of sorted non-negative numbers are always non-negative.
gap> ForAll([2 .. 4], n -> ForAll(__SmallAntimagmaHelper.TablesEncode(n,
> __SmallAntimagmaHelper.getSmallAntimagmaMetadata(n)()), d -> d >= 0));
true

# Consistency with the row converter: encoding the row forms of all
# magmas of orders 2 and 3 reproduces exactly the shipped metadata.
gap> ForAll([2 .. 3], n -> __SmallAntimagmaHelper.TablesEncode(n,
> List(AllSmallAntimagmas(n),
> M -> __SmallAntimagmaHelper.MultiplicationTableConvert(MultiplicationTable(M))))
> = __SmallAntimagmaHelper.TablesEncode(n,
> __SmallAntimagmaHelper.getSmallAntimagmaMetadata(n)()));
true

gap> STOP_TEST("test_helper_tables_encode_decode.tst");
