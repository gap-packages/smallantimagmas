/* antimagma.c -- the anti-associative magmas of one order, as table numbers.
 *
 * Enumerates the anti-associative tables whose diagonal is a prescribed digraph type
 * -- or all of them -- and prints one number per isomorphism class (or per class up
 * to isomorphism and anti-isomorphism), in increasing order.  The number is the key
 * of the canonical table, the same number the package's data files encode, so the
 * line number of a key is the id of that magma.  Run with -help for the options.
 */
#include "antiassociative/antiassociative.h"
#include "canonical/canonical.h"
#include "digraph_types/digraph_types.h"
#include "generate/generate.h"
#include "input/input.h"
#include "permutation/permutation.h"
#include "store/store.h"
#include "table/table.h"

#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

enum { EXIT_BAD_INPUT = 2 };
#define MAX_ARGUMENTS 64u

typedef struct {
    unsigned order;
    int up_to_anti_isomorphism;    /* default 1 */
    int counts_only;
    int labelled;
    int canonicalise_stdin;
    int list_diagonals;
    int report;
    int help;
    size_t positional_count;
    const char *positionals[MAX_ARGUMENTS];  /* 'all' or diagonal type numbers */
} settings;

typedef struct {
    const settings *chosen;
    permutation_list perms;
    digraph_type_list types;
    store seen;
    unsigned long labelled_found;
    unsigned long classes_found;
} session;

/* ==================================================================== output */

static void print_help(const char *program_name, FILE *out)
{
    fprintf(out,
        "usage: %s -order <n> -list              list the numbered diagonals for that order\n"
        "       %s -order <n> all [options]      every diagonal\n"
        "       %s -order <n> <no> [<no> ...]    only the diagonals with those numbers\n"
        "       %s -canon [options]              canonicalise tables read from stdin\n"
        "\n"
        "A magma is anti-associative when (ab)c != a(bc) for all a,b,c.  Its diagonal\n"
        "x -> x*x then has no fixed point.  Diagonals are grouped into types up to\n"
        "relabelling and numbered; run '%s -order <n> -list' to see them.\n"
        "\n"
        "Each class is printed as one number, the key of its canonical table (the\n"
        "row-major base-n digits of the table), in increasing order.  Pipe the output\n"
        "through 'deltas' to produce a data file.\n"
        "\n"
        "options:\n"
        "  -order <n>  the order n, between 2 and %u\n"
        "  -iso        up to isomorphism only (default: also up to anti-isomorphism)\n"
        "  -count      print counts only\n"
        "  -labelled   print every generated table's key, without canonical reduction\n"
        "  -report     print a detailed report per diagonal type and totals on stderr\n"
        "  -help       print this help and exit\n",
        program_name, program_name, program_name, program_name, program_name, MAX_ORDER);
}

static void fail(const char *message)
{
    fprintf(stderr, "%s\n", message);
    exit(EXIT_BAD_INPUT);
}

static void print_key(uint64_t key)
{
    printf("%" PRIu64 "\n", key);
}

static void print_store(const store *seen)
{
    for (size_t i = 0; i < seen->count; i++) print_key(seen->keys[i]);
}

/* ============================================================= command line */

static int apply_flag(settings *s, const char *argument)
{
    if (!strcmp(argument, "-iso")) s->up_to_anti_isomorphism = 0;
    else if (!strcmp(argument, "-count")) s->counts_only = 1;
    else if (!strcmp(argument, "-labelled")) s->labelled = 1;
    else if (!strcmp(argument, "-canon")) s->canonicalise_stdin = 1;
    else if (!strcmp(argument, "-list")) s->list_diagonals = 1;
    else if (!strcmp(argument, "-report")) s->report = 1;
    else if (!strcmp(argument, "-help") || !strcmp(argument, "--help")) s->help = 1;
    else return 0;
    return 1;
}

/* a decimal number in [1, limit]; anything else fails with the message */
static unsigned long parse_number(const char *argument, unsigned long limit, const char *message)
{
    char *end;
    unsigned long value = strtoul(argument, &end, 10);
    if (*argument == '-' || *end != '\0' || value < 1 || value > limit) fail(message);
    return value;
}

static void parse_arguments(settings *s, int argc, char **argv)
{
    for (int i = 1; i < argc; i++) {
        if (!strcmp(argv[i], "-order")) {
            if (i + 1 >= argc) fail("-order needs a value");
            s->order = (unsigned)parse_number(argv[++i], MAX_ORDER, "order must be between 1 and 6");
        }
        else if (argv[i][0] == '-') { if (!apply_flag(s, argv[i])) fail("unknown option"); }
        else s->positionals[s->positional_count++] = argv[i];
    }
}

static size_t parse_type_number(const session *run, const char *argument)
{
    return (size_t)parse_number(argument, run->types.count,
                                "not a diagonal number for this order; run with -list to see them") - 1;
}

/* ============================================================ classification */

static void canonical_form(const session *run, const table *t, table *canonical)
{
    if (run->chosen->up_to_anti_isomorphism)
        canonical_under_relabelling_and_transposition(t, &run->perms, canonical);
    else
        canonical_under_relabelling(t, &run->perms, canonical);
}

static void record_class(session *run, const table *t)
{
    table canonical;
    canonical_form(run, t, &canonical);
    int added = store_add(&run->seen, table_key(&canonical));
    if (added < 0) fail("out of memory");
    if (added > 0) run->classes_found++;
}

static void visit_labelled_table(const table *t, void *context)
{
    session *run = context;
    run->labelled_found++;
    if (run->chosen->counts_only) return;
    if (run->chosen->labelled) print_key(table_key(t));
    else record_class(run, t);
}

/* ================================================================== reports

   Reports are optional; the counts-only mode has nothing else to show, so it
   always reports.                                                             */

static int reports_wanted(const settings *chosen)
{
    return chosen->report || chosen->counts_only;
}

static void report_one_type(const session *run, size_t type_number, unsigned long before_labelled,
                            unsigned long before_classes)
{
    const digraph_type *entry = &run->types.items[type_number];
    fprintf(stderr, "diagonal %zu (", type_number + 1);
    digraph_print(entry->representative, run->chosen->order, stderr);
    fprintf(stderr, "): %lu tables with this diagonal, %zu digraphs in the type",
            run->labelled_found - before_labelled, entry->orbit_size);
    if (!run->chosen->labelled && !run->chosen->counts_only)
        fprintf(stderr, ", %lu new classes", run->classes_found - before_classes);
    fputc('\n', stderr);
}

static void report_totals(const session *run, int ran_all_types)
{
    unsigned order = run->chosen->order;
    fprintf(stderr, "order %u: %lu tables generated from the type representatives\n",
            order, run->labelled_found);
    if (ran_all_types)
        fprintf(stderr, "order %u: %lu labelled anti-associative tables in all\n",
                order, digraph_types_total_labelled_tables(&run->types));
    if (!run->chosen->labelled && !run->chosen->counts_only)
        fprintf(stderr, "order %u: %lu classes %s\n", order, run->classes_found,
                run->chosen->up_to_anti_isomorphism ? "up to isomorphism and anti-isomorphism"
                                                    : "up to isomorphism");
}

/* ===================================================================== runs */

static void run_one_type(session *run, size_t type_number)
{
    unsigned long before_labelled = run->labelled_found, before_classes = run->classes_found;
    digraph_type *entry = &run->types.items[type_number];
    generate_tables_with_diagonal(entry->representative, run->chosen->order,
                                  visit_labelled_table, run);
    entry->tables_found = run->labelled_found - before_labelled;
    if (reports_wanted(run->chosen)) report_one_type(run, type_number, before_labelled, before_classes);
}

static void run_all_types(session *run)
{
    for (size_t k = 0; k < run->types.count; k++) run_one_type(run, k);
}

/* returns 1 when 'all' was among the selections */
static int run_selected_types(session *run)
{
    int ran_all_types = 0;
    for (size_t i = 0; i < run->chosen->positional_count; i++) {
        const char *selection = run->chosen->positionals[i];
        if (!strcmp(selection, "all")) { run_all_types(run); ran_all_types = 1; }
        else run_one_type(run, parse_type_number(run, selection));
    }
    return ran_all_types;
}

static int canonicalise_tables_from_stdin(const settings *chosen)
{
    session run = { chosen, {0}, {0}, {NULL, 0, 0}, 0, 0 };
    table t, canonical;
    int status;
    while ((status = input_read_table(stdin, &t)) > 0) {
        permutation_build_all(table_order(&t), &run.perms);
        canonical_form(&run, &t, &canonical);
        if (!antiassociative_holds(&t)) fprintf(stderr, "warning: table is not anti-associative\n");
        print_key(table_key(&canonical));
    }
    return status < 0 ? EXIT_BAD_INPUT : EXIT_SUCCESS;
}

static void prepare_session(session *run, const settings *chosen)
{
    run->chosen = chosen;
    run->labelled_found = run->classes_found = 0;
    permutation_build_all(chosen->order, &run->perms);
    if (!digraph_types_build(chosen->order, &run->perms, &run->types))
        fail("too many digraph types");
    store_start(&run->seen);
}

static int classify(const settings *chosen)
{
    session run;
    if (chosen->order == 1) { fprintf(stderr, "order 1: no anti-associative magma exists\n"); return EXIT_SUCCESS; }
    prepare_session(&run, chosen);
    if (chosen->list_diagonals || chosen->positional_count == 0) {
        digraph_types_print(&run.types, chosen->order, stdout);
        if (!chosen->list_diagonals) printf("\nGive one or more of these numbers, or 'all'.\n");
        return EXIT_SUCCESS;
    }
    int ran_all_types = run_selected_types(&run);
    if (reports_wanted(chosen)) report_totals(&run, ran_all_types);
    if (!chosen->labelled && !chosen->counts_only) print_store(&run.seen);
    store_free(&run.seen);
    return EXIT_SUCCESS;
}

int main(int argc, char **argv)
{
    settings chosen = {0};
    chosen.up_to_anti_isomorphism = 1;
    if (argc < 1 || (unsigned)argc > MAX_ARGUMENTS) fail("too many arguments");
    parse_arguments(&chosen, argc, argv);
    if (chosen.help) { print_help(argv[0], stdout); return EXIT_SUCCESS; }
    if (chosen.canonicalise_stdin) return canonicalise_tables_from_stdin(&chosen);
    if (chosen.order == 0) { print_help(argv[0], stderr); return EXIT_BAD_INPUT; }
    return classify(&chosen);
}
