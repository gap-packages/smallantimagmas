# Demo of SmallAntimagmasInformation functionality
# This demonstrates the new functions added to the smallantimagmas package

# Load the package
LoadPackage("smallantimagmas");

# Demonstrate SmallAntimagmasInformation for small orders
Print("=== SmallAntimagmasInformation Demo ===\n");

for n in [2, 3] do
    info := SmallAntimagmasInformation(n);
    Print("Order ", n, ":\n");
    Print("  Total antiassociative magmas: ", info.total, "\n");
    Print("  Up to isomorphism: ", info.upToIsomorphism, "\n");
    Print("  Up to isomorphism and anti-isomorphism: ", info.upToIsomorphismAndAntiisomorphism, "\n");
    Print("\n");
od;

# Show individual function calls
Print("=== Individual Function Calls ===\n");
Print("NrSmallAntimagmas(3) = ", NrSmallAntimagmas(3), "\n");
Print("ReallyNrSmallAntimagmas(3) = ", ReallyNrSmallAntimagmas(3), "\n");
Print("NrSmallAntimagmasUpToAntiisomorphism(3) = ", NrSmallAntimagmasUpToAntiisomorphism(3), "\n");

# Demonstrate the mathematical relationships
Print("\n=== Mathematical Relationships ===\n");
for n in [2, 3] do
    info := SmallAntimagmasInformation(n);
    Print("Order ", n, ": ");
    Print(info.upToIsomorphismAndAntiisomorphism, " <= ", info.upToIsomorphism, " <= ", info.total);
    if info.upToIsomorphismAndAntiisomorphism <= info.upToIsomorphism and info.upToIsomorphism <= info.total then
        Print(" ✓\n");
    else
        Print(" ✗\n");
    fi;
od;