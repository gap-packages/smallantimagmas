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
#! <C>"constant"</C>, the pair
#! <Ref Attr="NrConstantLeftTranslations" Label="for IsMagma"/> and
#! <Ref Attr="NrConstantRightTranslations" Label="for IsMagma"/> counting
#! the constant rows and the constant columns of the multiplication table.
#! In an antimagma one of the two is <M>0</M>, so at order <M>n</M> the
#! types are <M>(0, 0)</M>, <M>(r, 0)</M> and <M>(0, c)</M> for
#! <M>1 \leq r, c \leq n</M>. The value <M>n</M> is the
#! <Ref Prop="IsLeftFPFInducted" Label="for IsMagma"/>, respectively
#! <Ref Prop="IsRightFPFInducted" Label="for IsMagma"/>, case.
#!
#! Each table has a column per type the invariant distinguishes, for
#! <C>"diagonal"</C> the types of
#! <Ref Oper="DiagonalDigraphTypes" Label="for IsPosInt"/>. The rows count
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
#! Classified by the numbers of constant left and right translations:
#! ----------------------------------------------------------------------
#! Counted objects     Total    (0,0) (1,0) (2,0) (3,0) (0,1) (0,2) (0,3)
#! ----------------------------------------------------------------------
#! Isomorphism classes    10        0     0     3     2     0     3     2
#! ......................................................................
#! 2-iso classes           2        0     0     0     1     0     0     1
#! 6-iso classes           8        0     0     3     1     0     3     1
#! ----------------------------------------------------------------------
#! Labelled magmas        52        0     0    18     8     0    18     8
#! ----------------------------------------------------------------------
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
#! Classified by the numbers of constant left and right translations:
#! ----------------------------------------------------------------------
#! Counted objects     Total    (0,0) (1,0) (2,0) (3,0) (0,1) (0,2) (0,3)
#! ----------------------------------------------------------------------
#! Isomorphism classes    10        0     0     3     2     0     3     2
#! ......................................................................
#! 2-iso classes           2        0     0     0     1     0     0     1
#! 6-iso classes           8        0     0     3     1     0     3     1
#! ----------------------------------------------------------------------
#! Labelled magmas        52        0     0    18     8     0    18     8
#! ----------------------------------------------------------------------
#! @EndExampleSession
#!
DeclareGlobalFunction("SmallAntimagmasInformation");
