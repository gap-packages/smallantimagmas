DeclareCategory("__IsSmallAntimagmaClassification", IsObject);

BindGlobal("__SmallAntimagmaClassificationFamily",
    NewFamily("__SmallAntimagmaClassificationFamily"));

BindGlobal("__SmallAntimagmaClassificationType",
    NewType(__SmallAntimagmaClassificationFamily,
        __IsSmallAntimagmaClassification and IsComponentObjectRep));

#! @Arguments magmas[, by]
#! @Description
#! classifies <A>magmas</A>, given as one magma per isomorphism class, by the
#! invariant named in <A>by</A>, as in <Cite Key="MazurekZabielski2025"/>. The
#! default <C>"all"</C> classifies by every invariant in turn, one table each.
#! The invariants are <C>"diagonal"</C>, the isomorphism type of the diagonal
#! digraph, that is of the map <M>x \mapsto x * x</M>, and
#! <C>"cancellativity"</C>, the pair of truth values
#! <Ref Prop="IsLeftCancellative" Label="for IsMagma"/> and
#! <Ref Prop="IsRightCancellative" Label="for IsMagma"/>, and
#! <C>"cancellativity-degree"</C>, the pair
#! <Ref Attr="CancellativityDegree" Label="for IsMagma"/> counting the injective
#! left and right translations, of which <C>"cancellativity"</C> is the
#! coarsening that only asks whether each count is full,
#! <C>"commutativity"</C>, the value of
#! <Ref Attr="CommutativityIndex" Label="for IsMagma"/>, and
#! <C>"translation"</C>, the
#! <Ref Attr="TranslationProfile" Label="for IsMagma"/> taken up to the swap
#! of its two entries, and
#! <C>"product-set"</C>, the size of the product set <M>M * M</M>, that is
#! <Ref Attr="ProductSetSize" Label="for IsMagma"/>, and <C>"rank"</C>,
#! the size of a <Ref Attr="MinimalGeneratingSet" Label="for IsMagma"/>.
#!
#! Each table has a column per type the invariant distinguishes, for
#! <C>"diagonal"</C> the types of
#! <Ref Oper="DiagonalDigraphTypes" Label="for IsPosInt"/>, for
#! <C>"cancellativity-degree"</C> and <C>"commutativity"</C> the degrees
#! and values that occur among <A>magmas</A>, so that no column is empty,
#! and for <C>"translation"</C> those of
#! <Ref Oper="TranslationProfileTypes" Label="for IsPosInt"/>. The rows count
#! increasing collections: the antiisomorphism classes, the isomorphism classes
#! and those of each size that occurs, and finally the labelled magmas. The
#! <C>Total</C> column comes first, set off from the per-type columns.
#!
#! Every magma falls into exactly one type, so each row's type columns sum to
#! its <C>Total</C>, and the rows counting classes by size sum to the
#! <C>Isomorphism classes</C> row above them.
#!
#! @BeginExampleSession
#! gap> Ms := AllSmallAntimagmas(3, "up-to-isomorphism");;
#! gap> Display(SmallAntimagmaClassification(Ms));
#! Classified by the isomorphism type of the diagonal digraph:
#! --------------------------------------------
#! Counted objects     Total    Gamma_1 Gamma_2
#! --------------------------------------------
#! Iso+antiiso classes     5          4       1
#! --------------------------------------------
#! Isomorphism classes    10          8       2
#! ............................................
#! 2-iso classes           2          0       2
#! 6-iso classes           8          8       0
#! --------------------------------------------
#! Labelled magmas        52         48       4
#! --------------------------------------------
#!
#! Classified by left and right cancellativity:
#! ----------------------------------------------------
#! Counted objects     Total    neither left right both
#! ----------------------------------------------------
#! Isomorphism classes    10          8    1     1    0
#! ....................................................
#! 2-iso classes           2          0    1     1    0
#! 6-iso classes           8          8    0     0    0
#! ----------------------------------------------------
#! Labelled magmas        52         48    2     2    0
#! ----------------------------------------------------
#!
#! Classified by the cancellativity degree:
#! ----------------------------------------------
#! Counted objects     Total    (0,0) (0,3) (3,0)
#! ----------------------------------------------
#! Isomorphism classes    10        8     1     1
#! ..............................................
#! 2-iso classes           2        0     1     1
#! 6-iso classes           8        8     0     0
#! ----------------------------------------------
#! Labelled magmas        52       48     2     2
#! ----------------------------------------------
#!
#! Classified by the commutativity index:
#! ---------------------------------
#! Counted objects     Total    0  1
#! ---------------------------------
#! Iso+antiiso classes     5    1  4
#! ---------------------------------
#! Isomorphism classes    10    2  8
#! .................................
#! 2-iso classes           2    2  0
#! 6-iso classes           8    0  8
#! ---------------------------------
#! Labelled magmas        52    4 48
#! ---------------------------------
#!
#! Classified by the translation profile:
#! ----------------------------------------
#! Counted objects     Total    T_1 T_2 T_3
#! ----------------------------------------
#! Iso+antiiso classes     5      3   1   1
#! ----------------------------------------
#! Isomorphism classes    10      6   2   2
#! ........................................
#! 2-iso classes           2      0   0   2
#! 6-iso classes           8      6   2   0
#! ----------------------------------------
#! Labelled magmas        52     36  12   4
#! ----------------------------------------
#!
#! Classified by the size of the product set M * M:
#! ------------------------------------------
#! Counted objects     Total    |MM|=2 |MM|=3
#! ------------------------------------------
#! Iso+antiiso classes     5         1      4
#! ------------------------------------------
#! Isomorphism classes    10         2      8
#! ..........................................
#! 2-iso classes           2         0      2
#! 6-iso classes           8         2      6
#! ------------------------------------------
#! Labelled magmas        52        12     40
#! ------------------------------------------
#!
#! Classified by rank, the size of a minimal generating set:
#! -------------------------------------------------
#! Counted objects     Total    rank 1 rank 2 rank 3
#! -------------------------------------------------
#! Iso+antiiso classes     5         5      0      0
#! -------------------------------------------------
#! Isomorphism classes    10        10      0      0
#! .................................................
#! 2-iso classes           2         2      0      0
#! 6-iso classes           8         8      0      0
#! -------------------------------------------------
#! Labelled magmas        52        52      0      0
#! -------------------------------------------------
#! gap> Display(SmallAntimagmaClassification(Ms, "cancellativity"));
#! Classified by left and right cancellativity:
#! ----------------------------------------------------
#! Counted objects     Total    neither left right both
#! ----------------------------------------------------
#! Isomorphism classes    10          8    1     1    0
#! ....................................................
#! 2-iso classes           2          0    1     1    0
#! 6-iso classes           8          8    0     0    0
#! ----------------------------------------------------
#! Labelled magmas        52         48    2     2    0
#! ----------------------------------------------------
#! @EndExampleSession
#!
DeclareGlobalFunction("SmallAntimagmaClassification");

#! @Arguments n[, by]
#! @Description
#! prints what the library knows about the antiassociative magmas of order
#! <A>n</A>: how many there are in each of the three views of
#! <Ref Func="AllSmallAntimagmas"/>, and the table classifying them by the
#! invariant named in <A>by</A>, as accepted by
#! <Ref Func="SmallAntimagmaClassification"/>.
#!
#! @BeginExampleSession
#! gap> SmallAntimagmasInformation(3);
#! -------------------------------------------
#! Antiassociative magmas of order 3     Total
#! -------------------------------------------
#! up to isomorphism and antiisomorphism     5
#! up to isomorphism                        10
#! labelled                                 52
#! -------------------------------------------
#!
#! Classified by the isomorphism type of the diagonal digraph:
#! --------------------------------------------
#! Counted objects     Total    Gamma_1 Gamma_2
#! --------------------------------------------
#! Iso+antiiso classes     5          4       1
#! --------------------------------------------
#! Isomorphism classes    10          8       2
#! ............................................
#! 2-iso classes           2          0       2
#! 6-iso classes           8          8       0
#! --------------------------------------------
#! Labelled magmas        52         48       4
#! --------------------------------------------
#!
#! Classified by left and right cancellativity:
#! ----------------------------------------------------
#! Counted objects     Total    neither left right both
#! ----------------------------------------------------
#! Isomorphism classes    10          8    1     1    0
#! ....................................................
#! 2-iso classes           2          0    1     1    0
#! 6-iso classes           8          8    0     0    0
#! ----------------------------------------------------
#! Labelled magmas        52         48    2     2    0
#! ----------------------------------------------------
#!
#! Classified by the cancellativity degree:
#! ----------------------------------------------
#! Counted objects     Total    (0,0) (0,3) (3,0)
#! ----------------------------------------------
#! Isomorphism classes    10        8     1     1
#! ..............................................
#! 2-iso classes           2        0     1     1
#! 6-iso classes           8        8     0     0
#! ----------------------------------------------
#! Labelled magmas        52       48     2     2
#! ----------------------------------------------
#!
#! Classified by the commutativity index:
#! ---------------------------------
#! Counted objects     Total    0  1
#! ---------------------------------
#! Iso+antiiso classes     5    1  4
#! ---------------------------------
#! Isomorphism classes    10    2  8
#! .................................
#! 2-iso classes           2    2  0
#! 6-iso classes           8    0  8
#! ---------------------------------
#! Labelled magmas        52    4 48
#! ---------------------------------
#!
#! Classified by the translation profile:
#! ----------------------------------------
#! Counted objects     Total    T_1 T_2 T_3
#! ----------------------------------------
#! Iso+antiiso classes     5      3   1   1
#! ----------------------------------------
#! Isomorphism classes    10      6   2   2
#! ........................................
#! 2-iso classes           2      0   0   2
#! 6-iso classes           8      6   2   0
#! ----------------------------------------
#! Labelled magmas        52     36  12   4
#! ----------------------------------------
#!
#! Classified by the size of the product set M * M:
#! ------------------------------------------
#! Counted objects     Total    |MM|=2 |MM|=3
#! ------------------------------------------
#! Iso+antiiso classes     5         1      4
#! ------------------------------------------
#! Isomorphism classes    10         2      8
#! ..........................................
#! 2-iso classes           2         0      2
#! 6-iso classes           8         2      6
#! ------------------------------------------
#! Labelled magmas        52        12     40
#! ------------------------------------------
#!
#! Classified by rank, the size of a minimal generating set:
#! -------------------------------------------------
#! Counted objects     Total    rank 1 rank 2 rank 3
#! -------------------------------------------------
#! Iso+antiiso classes     5         5      0      0
#! -------------------------------------------------
#! Isomorphism classes    10        10      0      0
#! .................................................
#! 2-iso classes           2         2      0      0
#! 6-iso classes           8         8      0      0
#! -------------------------------------------------
#! Labelled magmas        52        52      0      0
#! -------------------------------------------------
#! @EndExampleSession
#!
DeclareGlobalFunction("SmallAntimagmasInformation");
