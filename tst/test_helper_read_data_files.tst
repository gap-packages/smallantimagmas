gap> START_TEST("test_helper_read_data_files.tst");

# ------------------------------------------------------------------
# A data file is a single list literal, e.g.
#
#     local result;result:=[6813,9,234,9,3114];return result;
#
# ForEachBlock walks the numbers of such a file a block at a time,
# never holding the whole of it: it hands every block to <process>,
# which returns false to stop the walk. ReadDeltas collects every
# block, ScanDeltas only sums them, and TableOfKey turns one packed
# number back into the row form of a table.
# ------------------------------------------------------------------

gap> dir := DirectoryTemporary();;

gap> file := function(name, contents)
>     local path;
>     path := Filename(dir, name);
>     PrintTo(path, contents);
>     return path;
> end;;

# A file that fits into a single block is handed over in one piece.
gap> blocks := [];;

gap> __SmallAntimagmaHelper.ForEachBlock(
> file("pair.g", "local result;result:=[6813,3366];return result;"),
> function(block) Add(blocks, block); return true; end);

gap> blocks;
[ [ 6813, 3366 ] ]

gap> __SmallAntimagmaHelper.ReadDeltas(file("single.g", "local result;result:=[10];return result;"));
[ 10 ]

gap> __SmallAntimagmaHelper.ReadDeltas(file("deltas.g", "local result;result:=[6813,9,234,9,3114];return result;"));
[ 6813, 9, 234, 9, 3114 ]

# <process> returning false stops the walk.
gap> blocks := [];;

gap> __SmallAntimagmaHelper.ForEachBlock(
> file("stop.g", "local result;result:=[1,2,3];return result;"),
> function(block) Add(blocks, block); return false; end);

gap> blocks;
[ [ 1, 2, 3 ] ]

# A file that never closes its list is read as far as it goes, and only
# the numbers that are certainly complete are handed over: the walk cuts
# at the last comma, so the trailing 234 is held back rather than split.
gap> blocks := [];;

gap> __SmallAntimagmaHelper.ForEachBlock(
> file("truncated.g", "local result;result:=[6813,9,234"),
> function(block) Add(blocks, block); return true; end);
Error, smallantimagmas: <path> holds no complete list of tables

gap> blocks;
[ [ 6813, 9 ] ]

gap> __SmallAntimagmaHelper.ReadDeltas(file("empty.g", ""));
Error, smallantimagmas: <path> holds no complete list of tables

gap> __SmallAntimagmaHelper.ReadDeltas(Filename(dir, "absent.g"));
Error, smallantimagmas: <path> could not be read

# ScanDeltas reaches one entry, the deltas being a prefix sum:
# 6813, 6813 + 9, 6822 + 234, 7056 + 9, 7065 + 3114.
gap> path := file("deltas.g", "local result;result:=[6813,9,234,9,3114];return result;");;

gap> List([1 .. 5], id -> __SmallAntimagmaHelper.ScanDeltas(path, id));
[ 6813, 6822, 7056, 7065, 10179 ]

# With <id> = fail it counts the entries instead.
gap> __SmallAntimagmaHelper.ScanDeltas(path, fail);
5

gap> __SmallAntimagmaHelper.ScanDeltas(path, 6);
Error, smallantimagmas: <id> is larger than the number of antimagmas of that order

# A packed number is n digits in base n^n, each digit shifted by one.
gap> __SmallAntimagmaHelper.TableOfKey(2, 10);
[ 3, 3 ]

gap> List([6813, 6822, 7056, 7065, 10179], key -> __SmallAntimagmaHelper.TableOfKey(3, key));
[ [ 10, 10, 10 ], [ 10, 10, 19 ], [ 10, 19, 10 ], [ 10, 19, 19 ],
  [ 14, 27, 1 ] ]

# TableOfKey is the inverse of the packing done by TablesEncode: a lone
# table encodes to a single delta, taken from 0, hence to its own key.
gap> ForAll([2 .. 4], n -> ForAll(__SmallAntimagmaHelper.getSmallAntimagmaMetadata(n)(),
> T -> __SmallAntimagmaHelper.TableOfKey(n, __SmallAntimagmaHelper.TablesEncode(n, [T])[1]) = T));
true

# The shipped data, read entry by entry, agrees with reading it whole.
gap> List([2 .. 4], n -> __SmallAntimagmaHelper.CountTables(n));
[ 1, 5, 8891 ]

gap> ForAll([2 .. 4], n -> __SmallAntimagmaHelper.CountTables(n)
> = Length(__SmallAntimagmaHelper.getSmallAntimagmaMetadata(n)()));
true

gap> ForAll([2 .. 3], n -> ForAll([1 .. __SmallAntimagmaHelper.CountTables(n)],
> id -> __SmallAntimagmaHelper.TableAt(n, id)
> = __SmallAntimagmaHelper.getSmallAntimagmaMetadata(n)()[id]));
true

# order 4 holds 8891 tables, so only its ends and a few entries in
# between are checked, one scan of the file being needed per entry.
gap> ForAll([1, 2, 4444, 8890, 8891],
> id -> __SmallAntimagmaHelper.TableAt(4, id)
> = __SmallAntimagmaHelper.getSmallAntimagmaMetadata(4)()[id]);
true

gap> __SmallAntimagmaHelper.TableAt(2, 2);
Error, smallantimagmas: <id> is larger than the number of antimagmas of that order

gap> SmallAntimagma(3, 6);
Error, smallantimagmas: <id> is larger than the number of antimagmas of that order

gap> STOP_TEST("test_helper_read_data_files.tst");
