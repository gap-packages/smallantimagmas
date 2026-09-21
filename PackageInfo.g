#############################################################################
##
##  PackageInfo.g for the package `smallantimagmas'           Kamil Zabielski
##  (created from Frank Lübeck's PackageInfo.g template file)
##
#############################################################################

SetPackageInfo(rec(

PackageName := "smallantimagmas",

Subtitle := "A library of antiassociative magmas of small order",

Version := "0.6.0",

Date := "05/07/2026",

License := "GPL-3.0-or-later",
PackageWWWHome :=
  Concatenation("https://gap-packages.github.io/", LowercaseString(~.PackageName)),
SourceRepository := rec(
    Type := "git",
    URL := Concatenation("https://github.com/gap-packages/", LowercaseString(~.PackageName)),
),
IssueTrackerURL := Concatenation(~.SourceRepository.URL, "/issues"),
SupportEmail := "kamil@zabielscy.com",

ArchiveURL := Concatenation(~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-v", ~.Version),

ArchiveFormats := ".tar.gz",

Persons := [
  rec(
    LastName      := "Zabielski",
    FirstNames    := "Kamil",
    IsAuthor      := true,
    IsMaintainer  := true,
    GitHubUsername := "limakzi",
    WWWHome       := "https://limakzi.me/",
    PostalAddress := Concatenation([
                       "Department of Theoretical Computer Science\n",
                       "Białystok University of Technology\n",
                       "Wiejska 45A\n",
                       "15-325 Białystok\n",
                       "Poland"]),
    Place         := "Białystok, Poland",
    Institution   := "Białystok University of Technology"
),
  rec(
    LastName      := "Mazurek",
    FirstNames    := "Ryszard",
    IsAuthor      := true,
    IsMaintainer  := false,
    PostalAddress := Concatenation([
                       "Department of Theoretical Computer Science\n",
                       "Białystok University of Technology\n",
                       "Wiejska 45A\n",
                       "15-325 Białystok\n",
                       "Poland"]),
    Place         := "Białystok, Poland",
    Institution   := "Białystok University of Technology"
),
  rec(
    LastName      := "Konovalov",
    FirstNames    := "Olexandr",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "obk1@st-andrews.ac.uk",
    WWWHome       := "https://olexandr-konovalov.github.io/",
    GitHubUsername := "olexandr-konovalov",
    PostalAddress := Concatenation([
                       "School of Computer Science\n",
                       "University of St Andrews\n",
                       "Jack Cole Building, North Haugh,\n",
                       "St Andrews, Fife, KY16 9SX, Scotland"]),
    Place         := "St Andrews",
    Institution   := "University of St Andrews"
)
],

Status := "accepted",

CommunicatedBy := "Kamil Zabielski (Białystok)",

AcceptDate := "08/2025",

README_URL :=
  Concatenation(~.PackageWWWHome, "/README.md"),
PackageInfoURL :=
  Concatenation(~.PackageWWWHome, "/PackageInfo.g"),

AbstractHTML :=
  "The <span class=\"pkgname\">smallantimagmas</span> package, \
   classifies finite, antiassociative magmas of small order \
   up to isomorphism and antiisomorphism.",

PackageDoc := rec(
  BookName  := "smallantimagmas",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0_mj.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "smallantimagmas/Antimagmas package"
),

Dependencies := rec(
  GAP := "4.12",

  NeededOtherPackages := [["GAPDoc", "1.5"], ["Digraphs", "1.8.3"]],

  SuggestedOtherPackages := [],

  ExternalConditions := []

),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

Keywords := ["smallantimagmas", "antiassociative"],

AutoDoc := rec(
  TitlePage := rec(
    Copyright := """
      <Index>License</Index>
      &copyright; 2024-2026 by Kamil Zabielski<P/>
      &smallantimagmas; package is free software;
      you can redistribute it and/or modify it under the terms of the
      <URL Text="GNU General Public License">http://www.fsf.org/licenses/gpl.html</URL>
      as published by the Free Software Foundation; either version 3 of the License,
      or (at your option) any later version.
      """,
    Acknowledgements := """
      We appreciate very much all past and future comments, suggestions and
      contributions to this package and its documentation provided by &GAP;
      users and developers.
      """,
),
),

));
