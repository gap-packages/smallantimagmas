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
#! <C>"index-period"</C>, the
#! <Ref Attr="IndexPeriodProfile" Label="for IsMagma"/>, that is the multisets
#! of left and of right index-periods of the elements, as an unordered pair.
#!
#! Each table has a column per type the invariant distinguishes, for
#! <C>"diagonal"</C> the types of
#! <Ref Oper="DiagonalDigraphTypes" Label="for IsPosInt"/> and for
#! <C>"index-period"</C> the profiles
#! <Ref Oper="IndexPeriodProfileTypes" Label="for IsList"/> finds among
#! <A>magmas</A>, named <M>P_1, P_2, \ldots</M> in that order. The rows count
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
#! Classified by the index-period profile:
#! ------------------------------------------------
#! Counted objects     Total    P_1 P_2 P_3 P_4 P_5
#! ------------------------------------------------
#! Iso+antiiso classes     5      1   1   1   1   1
#! ------------------------------------------------
#! Isomorphism classes    10      2   2   2   2   2
#! ................................................
#! 2-iso classes           2      0   0   0   0   2
#! 6-iso classes           8      2   2   2   2   0
#! ------------------------------------------------
#! Labelled magmas        52     12  12  12  12   4
#! ------------------------------------------------
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
#! Classified by the index-period profile:
#! ------------------------------------------------
#! Counted objects     Total    P_1 P_2 P_3 P_4 P_5
#! ------------------------------------------------
#! Iso+antiiso classes     5      1   1   1   1   1
#! ------------------------------------------------
#! Isomorphism classes    10      2   2   2   2   2
#! ................................................
#! 2-iso classes           2      0   0   0   0   2
#! 6-iso classes           8      2   2   2   2   0
#! ------------------------------------------------
#! Labelled magmas        52     12  12  12  12   4
#! ------------------------------------------------
#! @EndExampleSession
#!
DeclareGlobalFunction("SmallAntimagmasInformation");
