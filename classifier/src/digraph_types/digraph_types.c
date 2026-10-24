#include "digraph_types/digraph_types.h"

#include <stdlib.h>
#include <string.h>

int digraph_types_number_of(const digraph_type_list *list, const digraph representative,
                            unsigned order, size_t *number)
{
    for (size_t k = 0; k < list->count; k++)
        if (digraph_compare(representative, list->items[k].representative, order) == 0) {
            *number = k;
            return 1;
        }
    return 0;
}

int digraph_types_record(digraph_type_list *list, const digraph representative, unsigned order,
                         const permutation_list *perms)
{
    size_t existing;
    if (digraph_types_number_of(list, representative, order, &existing)) return 1;
    if (list->count == MAX_TYPES) return 0;
    digraph_type *entry = &list->items[list->count++];
    memset(entry->representative, 0, sizeof entry->representative);
    memcpy(entry->representative, representative, order);
    entry->orbit_size = digraph_count_in_type(representative, order, perms);
    entry->tables_found = 0;
    return 1;
}

static int compare_types_by_representative(const void *left, const void *right)
{
    const digraph_type *a = left, *b = right;
    return digraph_compare(a->representative, b->representative, MAX_ORDER);
}

int digraph_types_build(unsigned order, const permutation_list *perms, digraph_type_list *list)
{
    digraph d, representative;
    list->count = 0;
    digraph_first(d, order);
    do {
        digraph_least_in_type(d, order, perms, representative);
        if (!digraph_types_record(list, representative, order, perms)) return 0;
    } while (digraph_next(d, order));
    qsort(list->items, list->count, sizeof *list->items, compare_types_by_representative);
    return 1;
}

static void print_type_row(const digraph_type *entry, size_t number, unsigned order, FILE *out)
{
    fprintf(out, "  %3zu  ", number);
    digraph_print(entry->representative, order, out);
    for (unsigned pad = order; pad < 9; pad++) fputc(' ', out);
    fprintf(out, "%8zu  ", entry->orbit_size);
    for (element x = 0; x < order; x++)
        fprintf(out, "%u->%u%s", x + 1u, entry->representative[x] + 1u, x + 1u < order ? " " : "");
    fputc('\n', out);
}

static unsigned long loopless_digraph_count(unsigned order)
{
    unsigned long expected = 1;
    for (unsigned x = 0; x < order; x++) expected *= order - 1;
    return expected;
}

void digraph_types_print(const digraph_type_list *list, unsigned order, FILE *out)
{
    size_t total_digraphs = 0;
    fprintf(out, "diagonal types of order %u (select with the number in the first column)\n\n",
            order);
    fprintf(out, "  no.  diagonal  digraphs  edges\n");
    for (size_t k = 0; k < list->count; k++) {
        print_type_row(&list->items[k], k + 1, order, out);
        total_digraphs += list->items[k].orbit_size;
    }
    fprintf(out, "\n  %zu types, %zu loopless functional digraphs in all ((n-1)^n = %lu)\n",
            list->count, total_digraphs, loopless_digraph_count(order));
}

/* the tables actually generated use one representative per type, so the number of
   labelled tables is the sum over types of (orbit size) * (tables with that diagonal) */
unsigned long digraph_types_total_labelled_tables(const digraph_type_list *list)
{
    unsigned long total = 0;
    for (size_t k = 0; k < list->count; k++)
        total += list->items[k].orbit_size * list->items[k].tables_found;
    return total;
}
