gap> START_TEST("test_properties_magma_translation_profile.tst");

## the profile counts the distinct rows and the distinct columns
gap> M := MagmaByMultiplicationTable([[2, 1, 1], [2, 1, 1], [3, 1, 1]]);;
gap> TranslationProfile(M);
[ 2, 2 ]
gap> TranslationProfile(SmallAntimagma(2, 1));
[ 1, 2 ]

## transposing swaps the entries
gap> ForAll([2 .. 4], n -> ForAll(AllSmallAntimagmas(n),
>     M -> TranslationProfile(TransposedMagma(M)) = Reversed(TranslationProfile(M))));
true

## the sorted profile is shared with the library representative of the class
gap> ForAll(AllSmallAntimagmas(3, "labelled"),
>     M -> SortedList(TranslationProfile(M))
>          = SortedList(TranslationProfile(SmallAntimagma(IdSmallAntimagma(M)))));
true

## one side has a single translation exactly when that side is fpf inducted
gap> ForAll([2 .. 4], n -> ForAll(AllSmallAntimagmas(n, "up-to-isomorphism"),
>     M -> (TranslationProfile(M)[1] = 1) = IsRightFPFInducted(M)
>          and (TranslationProfile(M)[2] = 1) = IsLeftFPFInducted(M)));
true

## the types are the profiles that occur, sorted pairs without [1, 1]
gap> ForAll([2 .. 4], n -> Set(TranslationProfileTypes(n))
>     = Set(AllSmallAntimagmas(n, "up-to-isomorphism"), M -> SortedList(TranslationProfile(M))));
true
gap> ForAll([2 .. 4], n -> not [1, 1] in TranslationProfileTypes(n));
true

## TranslationProfileTypes(n) rejects a non-integer order
gap> TranslationProfileTypes(true);
Error, no method found! For debugging hints type ?Recovery from NoMethodFound
Error, no 1st choice method found for `TranslationProfileTypes' on 1 arguments

gap> STOP_TEST("test_properties_magma_translation_profile.tst");
