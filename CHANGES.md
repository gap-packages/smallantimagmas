This file describes changes in the smallantimagmas package.

## Unreleased

- Store one representative per class of isomorphic or anti-isomorphic
  antimagmas; `AllSmallAntimagmas`, `NrSmallAntimagmas`, `SmallAntimagma`
  and `IdSmallAntimagma` now refer to these, e.g. `NrSmallAntimagmas(4)` is
  8891 instead of 17780; add `UpToIsomorphismAndAntiisomorphism` (#261)
- Remove `ReallyAllSmallAntimagmas` and `ReallyNrSmallAntimagmas`; instead
  `AllSmallAntimagmas` and `NrSmallAntimagmas` take an optional view
  `"up-to-isomorphism"`, `"labelled"` or `"self-dual"` and accept a list of
  orders (#260, #310, #353)
- Add the antimagmas of order 5 (#290)
- Add `SmallAntimagmaClassification`, `SmallAntimagmasInformation` and
  `DiagonalDigraphTypes` to classify antimagmas by invariants (#311, #314,
  #315, #316, #318, #326, #327, #355, #359)
- Add `NrConstantLeftTranslations`, `NrConstantRightTranslations`,
  `MedialityIndex`, `IndexPeriodProfile`, `IndexPeriodProfileTypes`,
  `TranslationProfile`, `TranslationProfileTypes`, `MinimalGeneratingSet`,
  `Rank`, `ProductSetSize`, `LeftZeroIndex`, `RightZeroIndex`,
  `AbsorptionIndex` and `CancellativityDegree` for magmas
- Replace `LeftOrder`, `RightOrder`, `LeftOrdersOfElements` and
  `RightOrdersOfElements` by `LeftIndexPeriod` and `RightIndexPeriod` (#309)
- Make `IdSmallAntimagma` return `fail` for magmas that are not
  antiassociative or have fewer than two elements (#346)
- Speed up `MagmaIsomorphism`, `MagmaAntiisomorphism` (#272) and
  `NrSmallAntimagmas` (#351)
- Split the manual into chapters and add examples (#333, #364)

## 0.6.0 (2026-07-05)

- Require the Digraphs package; add `DigraphOfDiagonal` (#198)
- Allow `SmallAntimagma` to take the identifier as a list `[n, i]` (#230)

## 0.5.1 (2025-09-26)

- Turn `UpToIsomorphism` and `AntimagmaGeneratorPossibleDiagonals` into
  operations (#194)

## 0.5.0 (2025-09-12)

- Rename `AntimagmaGeneratorFilterNonIsomorphicMagmas` to `UpToIsomorphism`
  (#169)

## 0.4.1 (2025-05-14)

- Add a Jupyter notebook with examples (#164)

## 0.4.0 (2025-05-12)

- Add `IsLeftDistributive` and `IsRightDistributive`, also used as
  isomorphism invariants (#154, #155)

## 0.3.0 (2025-01-04)

- Add `IsLeftFPFInducted`, `IsRightFPFInducted`, `IsLeftAlternative`,
  `IsRightAlternative`, `IsLeftDerangementInducted` and
  `IsRightDerangementInducted` (#89, #91, #92)

## 0.2.12 (2024-08-28)

- Janitorial changes

## 0.2.11 (2024-08-28)

- Janitorial changes

## 0.2.10 (2024-08-28)

- Fix the package subtitle (#77) and the LICENSE file (#72)

## 0.2.9 (2024-08-28)

- Janitorial changes

## 0.2.8 (2024-08-28)

- Janitorial changes

## 0.2.7 (2024-08-28)

- Janitorial changes

## 0.2.6 (2024-08-28)

- Janitorial changes

## 0.2.5 (2024-08-28)

- Janitorial changes

## 0.2.4 (2024-08-28)

- Add `IsDeranged` (#62)

## 0.2.3 (2024-08-28)

- Janitorial changes

## 0.2.2 (2024-08-28)

- Janitorial changes

## 0.2.1 (2024-08-28)

- Janitorial changes

## 0.2.0 (2024-08-28)

- Turn `MagmaIsomorphism` and `MagmaAntiisomorphism` into operations (#51)
- Store the multiplication tables in a more compact format (#48)
- Improve the documentation (#50)

## 0.1.3 (2024-08-27)

- Janitorial changes

## 0.1.2 (2024-08-27)

- Janitorial changes

## 0.1.1 (2024-08-27)

- Janitorial changes

## 0.1.0 (2024-08-26)

- Add `DiagonalOfMultiplicationTable` (#40)
- Add `CommutativityIndex`, `AnticommutativityIndex` and `SquaresIndex`
  (#34)
- Add `LeftOrdersOfElements`, `RightOrdersOfElements`,
  `MagmaIsomorphismInvariantsMatch`, `AntimagmaGeneratorPossibleDiagonals`
  and `AntimagmaGeneratorFilterNonIsomorphicMagmas`; turn `LeftOrder` and
  `RightOrder` into attributes (#33)
- Allow a list of orders in `ReallyAllSmallAntimagmas` (#36)
- Fix `IdSmallAntimagma` only working for magmas of order 3 (#35)

## 0.0.18 (2024-08-18)

- Add `IdSmallAntimagma`, `MagmaIsomorphismInvariants` and
  `GeneratePossibleDiagonals` (#32)
- Require GAP >= 4.12

## 0.0.17 (2024-08-18)

- Turn `IsAntiassociative`, `IsCancellative`, `IsLeftCancellative`,
  `IsRightCancellative`, `IsLeftCyclic` and `IsRightCyclic` into properties
  and `AssociativityIndex` into an attribute (#30, #31)
- Add installation instructions to the manual (#25)

## 0.0.16 (2024-08-12)

- Add `ReallyAllSmallAntimagmas` and `ReallyNrSmallAntimagmas` (#24)

## 0.0.15 (2024-08-08)

- Janitorial changes

## 0.0.14 (2024-07-21)

- Add `AllSubmagmas` (#20)
- Make `MagmaIsomorphism` and `MagmaAntiisomorphism` return `fail` instead
  of `false` for magmas of different sizes (#19)

## 0.0.13 (2024-05-24)

- Add `AssociativityIndex` (#17)

## 0.0.12 (2024-04-01)

- Add basic documentation (#15)

## 0.0.11 (2024-04-01)

- Add `IsLeftCancellative`, `IsRightCancellative` and `IsCancellative` (#13)

## 0.0.10 (2024-04-01)

- Janitorial changes

## 0.0.8 (2024-04-01)

- Janitorial changes

## 0.0.7 (2024-04-01)

- Add `LeftOrder`, `RightOrder`, `IsLeftCyclic` and `IsRightCyclic`; fix
  `LeftPower` and `RightPower` (#11)

## 0.0.6 (2024-04-01)

- Add `OneSmallAntimagma` (#9)

## 0.0.5 (2024-04-01)

- Add `LeftPower` and `RightPower` (#8)

## 0.0.4 (2024-04-01)

- Add `TransposedMagma`; fix a missing local variable (#6)

## 0.0.3 (2024-04-01)

- Janitorial changes

## 0.0.2 (2024-04-01)

- Janitorial changes

## 0.0.1 (2024-04-01)

- Initial release
