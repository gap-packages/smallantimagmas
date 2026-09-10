__SmallAntimagmaHelper.Invariants := [

    rec(name := "diagonal",
        description := "the isomorphism type of the diagonal digraph",
        types := {order, magmas} -> DiagonalDigraphTypes(order),
        headers := types -> List([1 .. Size(types)], i -> Concatenation("Gamma_", String(i))),
        typeOf := {types, M} -> PositionProperty(types,
            type -> IsIsomorphicDigraph(type, DigraphOfDiagonal(M)))),

    rec(name := "cancellativity",
        description := "left and right cancellativity",
        types := {order, magmas} -> [[false, false], [true, false], [false, true], [true, true]],
        headers := types -> ["neither", "left", "right", "both"],
        typeOf := {types, M} -> Position(types,
            [IsLeftCancellative(M), IsRightCancellative(M)])),

    rec(name := "commutativity",
        description := "the commutativity index",
        types := {order, magmas} -> Set(magmas, CommutativityIndex),
        headers := types -> List(types, String),
        typeOf := {types, M} -> Position(types, CommutativityIndex(M)))
];

__SmallAntimagmaHelper.AllInvariants := "all";

__SmallAntimagmaHelper.checkInvariants := function(rest)
    local name, chosen;

    if IsEmpty(rest) then
        name := __SmallAntimagmaHelper.AllInvariants;
    elif Size(rest) = 1 and IsString(First(rest)) then
        name := First(rest);
    else
        ErrorNoReturn("smallantimagmas: ", "expected (<magmas>) or (<magmas>, <by>)");
    fi;

    if name = __SmallAntimagmaHelper.AllInvariants then
        return __SmallAntimagmaHelper.Invariants;
    fi;

    chosen := Filtered(__SmallAntimagmaHelper.Invariants, candidate -> candidate.name = name);
    if IsEmpty(chosen) then
        ErrorNoReturn("smallantimagmas: ", "<by> must be one of ", JoinStringsWithSeparator(
            Concatenation([__SmallAntimagmaHelper.AllInvariants],
                List(__SmallAntimagmaHelper.Invariants, candidate -> candidate.name)), ", "));
    fi;
    return chosen;
end;

__SmallAntimagmaHelper.PrintTable := function(header, cells, rules)
    local table, widths, line, rule, i;

    table := Concatenation([header], cells);
    widths := List([1 .. Size(header)], i -> Maximum(List(table, row -> Size(row[i]))));

    line := row -> Concatenation(String(row[1], -widths[1]),
        JoinStringsWithSeparator(List([2 .. Size(row)], i -> String(row[i], widths[i] + 1)), ""));

    rule := char -> ListWithIdenticalEntries(Size(line(header)), char);

    Print(rule('-'), "\n", line(header), "\n", rule('-'), "\n");
    for i in [1 .. Size(cells)] do
        Print(line(cells[i]), "\n");
        if rules[i] <> "" then
            Print(rule(rules[i][1]), "\n");
        fi;
    od;
    Print(rule('-'), "\n");
end;

InstallGlobalFunction(SmallAntimagmaClassification,
    function(arg...)
        local magmas, n, perms, orbitOf, shapes, keys, closed, tableOf;

        magmas := First(arg);
        if not IsList(magmas) or IsEmpty(magmas) then
            ErrorNoReturn("smallantimagmas: ", "<magmas> must be a non-empty list");
        fi;

        n := Size(First(magmas));
        perms := Elements(SymmetricGroup(n));

        orbitOf := function(M)
            local table, relabel;
            table := MultiplicationTable(M);
            relabel := p -> List([1 .. n], i -> List([1 .. n], j -> (table[i / p][j / p]) ^ p));
            return Set(perms, relabel);
        end;

        shapes := List(magmas, function(M)
            local orbit;
            orbit := orbitOf(M);
            return rec(size := Size(orbit), iso := orbit[1],
                       transposed := Minimum(List(orbit, TransposedMat)));
        end);

        # antiisomorphism classes can only be counted from <magmas> when every
        # transpose is itself represented there
        keys := Set(shapes, shape -> shape.iso);
        closed := ForAll(shapes, shape -> shape.transposed in keys);

        tableOf := function(invariant)
            local types, classes, columns, rows, rules, typeAt, size, i;

            types := invariant.types(n, magmas);
            classes := List([1 .. Size(magmas)],
                i -> rec(type := invariant.typeOf(types, magmas[i]),
                         size := shapes[i].size,
                         opposite := Minimum(shapes[i].iso, shapes[i].transposed)));

            columns := count -> List([1 .. Size(types)],
                type -> count(Filtered(classes, class -> class.type = type)));

            # the counts grow down the table: antiisomorphism classes, then
            # isomorphism classes with their breakdown by size, then the magmas.
            # "-" closes a group, "." separates a breakdown from its own row
            rows := [];
            rules := [];

            typeAt := [];
            for i in [1 .. Size(magmas)] do
                typeAt[Position(keys, shapes[i].iso)] := classes[i].type;
            od;

            if closed and ForAll([1 .. Size(magmas)],
                    i -> typeAt[Position(keys, shapes[i].transposed)] = classes[i].type) then
                Add(rows, ["Iso+antiiso classes",
                           columns(column -> Size(Set(column, class -> class.opposite)))]);
                Add(rules, "-");
            fi;

            Add(rows, ["Isomorphism classes", columns(Size)]);
            Add(rules, ".");

            for size in Set(classes, class -> class.size) do
                Add(rows, [Concatenation(String(size), "-iso classes"),
                           columns(column -> Number(column, class -> class.size = size))]);
                Add(rules, "");
            od;
            rules[Size(rules)] := "-";

            Add(rows, ["Labelled magmas", columns(column -> Sum(column, class -> class.size, 0))]);
            Add(rules, "");

            return rec(headers := invariant.headers(types), description := invariant.description,
                       rows := rows, rules := rules);
        end;

        return Objectify(__SmallAntimagmaClassificationType,
            rec(classes := Size(magmas),
                tables := List(__SmallAntimagmaHelper.checkInvariants(arg{[2 .. Size(arg)]}), tableOf)));
end);

InstallMethod(ViewObj, "for a small antimagma classification", [__IsSmallAntimagmaClassification],
    function(C)
        Print("<classification of ", C!.classes, " isomorphism classes>");
end);

InstallMethod(Display, "for a small antimagma classification", [__IsSmallAntimagmaClassification],
    function(C)
        local show, i;

        show := function(T)
            local gutter;

            # an empty column, so that Total reads as the sum of its row
            gutter := "  ";

            Print("Classified by ", T.description, ":\n");
            __SmallAntimagmaHelper.PrintTable(
                Concatenation(["Counted objects", "Total", gutter], T.headers),
                List(T.rows, row -> Concatenation([row[1], String(Sum(row[2])), gutter],
                    List(row[2], String))),
                T.rules);
        end;

        for i in [1 .. Size(C!.tables)] do
            if i > 1 then
                Print("\n");
            fi;
            show(C!.tables[i]);
        od;
end);

InstallGlobalFunction(SmallAntimagmasInformation,
    function(arg...)
        local order, count;

        order := First(arg);
        __SmallAntimagmaHelper.checkOrder(order);
        __SmallAntimagmaHelper.checkInvariants(arg{[2 .. Size(arg)]});

        count := {view, what} -> [what, String(NrSmallAntimagmas(order, view))];

        __SmallAntimagmaHelper.PrintTable(
            [Concatenation("Antiassociative magmas of order ", String(order)), "Total"],
            [count("up-to-isomorphism-antiisomorphism", "up to isomorphism and antiisomorphism"),
             count("up-to-isomorphism", "up to isomorphism"),
             count("labelled", "labelled")],
            ListWithIdenticalEntries(3, ""));
        Print("\n");

        Display(CallFuncList(SmallAntimagmaClassification,
            Concatenation([AllSmallAntimagmas(order, "up-to-isomorphism")], arg{[2 .. Size(arg)]})));
end);
