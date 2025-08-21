gap> START_TEST("test_smallantimagmas_information.tst");

# Test NrSmallAntimagmasUpToAntiisomorphism function exists and returns positive integers
gap> n2 := NrSmallAntimagmasUpToAntiisomorphism(2);;
gap> IsInt(n2) and n2 > 0;
true
gap> n3 := NrSmallAntimagmasUpToAntiisomorphism(3);;
gap> IsInt(n3) and n3 > 0;
true

# Test SmallAntimagmasInformation function
gap> info2 := SmallAntimagmasInformation(2);;
gap> IsRecord(info2);
true
gap> IsBound(info2.total) and IsBound(info2.upToIsomorphism) and IsBound(info2.upToIsomorphismAndAntiisomorphism);
true

gap> info3 := SmallAntimagmasInformation(3);;
gap> IsRecord(info3);
true
gap> IsBound(info3.total) and IsBound(info3.upToIsomorphism) and IsBound(info3.upToIsomorphismAndAntiisomorphism);
true

# Verify the relationships hold (these should always be true mathematically)
gap> info2.upToIsomorphismAndAntiisomorphism <= info2.upToIsomorphism;
true
gap> info2.upToIsomorphism <= info2.total;
true
gap> info3.upToIsomorphismAndAntiisomorphism <= info3.upToIsomorphism;
true
gap> info3.upToIsomorphism <= info3.total;
true

# Verify consistency with known counts
gap> info2.total = ReallyNrSmallAntimagmas(2);
true
gap> info2.upToIsomorphism = NrSmallAntimagmas(2);
true
gap> info3.total = ReallyNrSmallAntimagmas(3);
true
gap> info3.upToIsomorphism = NrSmallAntimagmas(3);
true

# Test that NrSmallAntimagmasUpToAntiisomorphism returns the correct value
gap> info2.upToIsomorphismAndAntiisomorphism = NrSmallAntimagmasUpToAntiisomorphism(2);
true
gap> info3.upToIsomorphismAndAntiisomorphism = NrSmallAntimagmasUpToAntiisomorphism(3);
true

gap> STOP_TEST("test_smallantimagmas_information.tst");