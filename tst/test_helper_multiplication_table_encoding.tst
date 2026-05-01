gap> START_TEST("test_helper_multiplication_table_encoding.tst");

# ====================================================================
# PowersOfNWithCache
# ====================================================================
gap> __SmallAntimagmaHelper.PowersOfNWithCache(2);
[ 1, 2 ]

gap> __SmallAntimagmaHelper.PowersOfNWithCache(3);
[ 1, 3, 9 ]

gap> __SmallAntimagmaHelper.PowersOfNWithCache(4);
[ 1, 4, 16, 64 ]

gap> __SmallAntimagmaHelper.PowersOfNWithCache(5);
[ 1, 5, 25, 125, 625 ]

# ====================================================================
# PowersOfNNWithCache
# ====================================================================
gap> __SmallAntimagmaHelper.PowersOfNNWithCache(2);
[ 1, 4 ]

gap> __SmallAntimagmaHelper.PowersOfNNWithCache(3);
[ 1, 27, 729 ]

gap> __SmallAntimagmaHelper.PowersOfNNWithCache(4);
[ 1, 256, 65536, 16777216 ]

gap> __SmallAntimagmaHelper.PowersOfNNWithCache(5);
[ 1, 3125, 9765625, 30517578125, 95367431640625 ]

# ====================================================================
# RowDictWithCache: verify dictionary sizes
# ====================================================================
gap> Length(__SmallAntimagmaHelper.RowDictWithCache(2));
4

gap> Length(__SmallAntimagmaHelper.RowDictWithCache(3));
27

gap> Length(__SmallAntimagmaHelper.RowDictWithCache(4));
256

# ====================================================================
# RowDictWithCache: verify specific entries (row ID 0 -> all ones)
# ====================================================================
gap> __SmallAntimagmaHelper.RowDictWithCache(2)[1];
[ 1, 1 ]

gap> __SmallAntimagmaHelper.RowDictWithCache(3)[1];
[ 1, 1, 1 ]

gap> __SmallAntimagmaHelper.RowDictWithCache(4)[1];
[ 1, 1, 1, 1 ]

# ====================================================================
# MultiplicationTableEncode: encode known tables
# ====================================================================
gap> __SmallAntimagmaHelper.MultiplicationTableEncode(
>        [[2, 1], [2, 1]]);
5

gap> __SmallAntimagmaHelper.MultiplicationTableEncode(
>        [[2, 2], [1, 1]]);
3

# ====================================================================
# MultiplicationTableDecode: decode and verify round-trip
# ====================================================================
gap> __SmallAntimagmaHelper.MultiplicationTableDecode(5, 2);
[ [ 2, 1 ], [ 2, 1 ] ]

gap> __SmallAntimagmaHelper.MultiplicationTableDecode(3, 2);
[ [ 2, 2 ], [ 1, 1 ] ]

# ====================================================================
# Round-trip: Encode then Decode for all antimagmas n=2..3
# ====================================================================
gap> ForAll(AllSmallAntimagmas([2 .. 3]), function(M)
>        local T, enc;
>        T := MultiplicationTable(M);
>        enc := __SmallAntimagmaHelper.MultiplicationTableEncode(T);
>        return __SmallAntimagmaHelper.MultiplicationTableDecode(
>                   enc, Size(M)) = T;
>    end);
true

# ====================================================================
# Round-trip: Encode then Decode for really-all antimagmas n=2..3
# ====================================================================
gap> ForAll(ReallyAllSmallAntimagmas([2 .. 3]), function(M)
>        local T, enc;
>        T := MultiplicationTable(M);
>        enc := __SmallAntimagmaHelper.MultiplicationTableEncode(T);
>        return __SmallAntimagmaHelper.MultiplicationTableDecode(
>                   enc, Size(M)) = T;
>    end);
true

# ====================================================================
# MultiplicationTableGetEntry: O(1) access matches full decode
# ====================================================================
gap> ForAll(AllSmallAntimagmas([2 .. 3]), function(M)
>        local T, enc, n;
>        T := MultiplicationTable(M);
>        n := Size(M);
>        enc := __SmallAntimagmaHelper.MultiplicationTableEncode(T);
>        return ForAll([1 .. n], r ->
>            ForAll([1 .. n], c ->
>                __SmallAntimagmaHelper.MultiplicationTableGetEntry(
>                    enc, n, r, c) = T[r][c]));
>    end);
true

# ====================================================================
# Encoding is injective: different tables produce different integers
# ====================================================================
gap> ForAll([2 .. 3], function(n)
>        local encodings;
>        encodings := List(AllSmallAntimagmas(n), M ->
>            __SmallAntimagmaHelper.MultiplicationTableEncode(
>                MultiplicationTable(M)));
>        return Size(Set(encodings)) = Size(encodings);
>    end);
true

# ====================================================================
# Encoding 0 always corresponds to the all-ones table
# ====================================================================
gap> ForAll([2 .. 4], n ->
>        __SmallAntimagmaHelper.MultiplicationTableDecode(0, n)
>        = List([1 .. n], r -> List([1 .. n], c -> 1)));
true

# ====================================================================
# Equivalence: old Convert/Reverse and new Encode/Decode
# produce the same multiplication tables
# ====================================================================
gap> ForAll(AllSmallAntimagmas([2 .. 3]), function(M)
>        local T, old_encoded, old_decoded, new_encoded, new_decoded;
>        T := MultiplicationTable(M);
>        old_encoded := __SmallAntimagmaHelper
>                           .MultiplicationTableConvert(T);
>        old_decoded := __SmallAntimagmaHelper
>                           .MultiplicationTableReverse(old_encoded);
>        new_encoded := __SmallAntimagmaHelper
>                           .MultiplicationTableEncode(T);
>        new_decoded := __SmallAntimagmaHelper
>                           .MultiplicationTableDecode(
>                               new_encoded, Size(M));
>        return old_decoded = new_decoded;
>    end);
true

gap> STOP_TEST("test_helper_multiplication_table_encoding.tst");
