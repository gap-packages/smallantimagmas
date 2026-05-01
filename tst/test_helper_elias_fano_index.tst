gap> START_TEST("test_helper_elias_fano_index.tst");

gap> ef := __SmallAntimagmaHelper.EliasFanoIndexOfSet([5, 3]);;

gap> __SmallAntimagmaHelper.EliasFanoIndexDecode(ef);
[ 3, 5 ]

gap> List([1 .. ef.size], i -> __SmallAntimagmaHelper.EliasFanoIndexGet(ef, i));
[ 3, 5 ]

gap> __SmallAntimagmaHelper.EliasFanoIndexContains(ef, 3);
true

gap> __SmallAntimagmaHelper.EliasFanoIndexContains(ef, 4);
false

gap> ef_list := __SmallAntimagmaHelper.EliasFanoIndexOfList([5, 3]);;

gap> __SmallAntimagmaHelper.EliasFanoIndexListDecode(ef_list);
[ 5, 3 ]

gap> List([1 .. ef_list.size], i -> __SmallAntimagmaHelper.EliasFanoIndexListGet(ef_list, i));
[ 5, 3 ]

gap> ForAll([2 .. 4], function(n)
>        local metadata, index;
>        metadata := __SmallAntimagmaHelper.getSmallAntimagmaMetadata(n)();
>        index := __SmallAntimagmaHelper.EliasFanoIndexOfSet(metadata);
>        return __SmallAntimagmaHelper.EliasFanoIndexDecode(index) = Set(metadata);
>    end);
true

gap> ForAll([2 .. 4], function(n)
>        local metadata, index;
>        metadata := __SmallAntimagmaHelper.getSmallAntimagmaMetadata(n)();
>        index := __SmallAntimagmaHelper.EliasFanoIndexOfSet(metadata);
>        return ForAll(metadata,
>            value -> __SmallAntimagmaHelper.EliasFanoIndexContains(index, value));
>    end);
true

gap> ForAll([2 .. 4], function(n)
>        local metadata, index;
>        metadata := __SmallAntimagmaHelper.getSmallAntimagmaMetadata(n)();
>        index := __SmallAntimagmaHelper.EliasFanoIndexOfList(metadata);
>        return __SmallAntimagmaHelper.EliasFanoIndexListDecode(index) = metadata;
>    end);
true

gap> NrSmallAntimagmas(2);
2

gap> ReallyNrSmallAntimagmas(3);
52

gap> STOP_TEST("test_helper_elias_fano_index.tst");
