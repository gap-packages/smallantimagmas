LoadPackage("AutoDoc");

# scanned in this order: a chapter opened by one file stays open for the next,
# so the Examples chapter, which ends inside a subsection, has to come last
AutoDoc(rec(
    scaffold := true,
    extract_examples := true,
    autodoc := rec(files := [
        "lib/helper.gd",
        "lib/utils.gd",
        "lib/smallantimagmas.gd",
        "lib/properties.gd",
        "lib/classification.gd",
        "lib/examples.gd"])
));

QUIT;
