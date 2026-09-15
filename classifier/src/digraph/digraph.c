#include "digraph/digraph.h"

#include <string.h>

int digraph_has_no_fixed_point(const element *d, unsigned order)
{
    for (element x = 0; x < order; x++)
        if (d[x] == x) return 0;
    return 1;
}

void digraph_print(const digraph d, unsigned order, FILE *out)
{
    for (element x = 0; x < order; x++) fprintf(out, "%u", d[x] + 1u);
}

int digraph_compare(const digraph left, const digraph right, unsigned order)
{
    for (element x = 0; x < order; x++) {
        if (left[x] < right[x]) return -1;
        if (left[x] > right[x]) return 1;
    }
    return 0;
}

/* (conjugate(d,p))[p(x)] = p(d(x)) */
void digraph_conjugate(const digraph d, const permutation p, unsigned order, digraph out)
{
    for (element x = 0; x < order; x++) out[p[x]] = p[d[x]];
}

void digraph_least_in_type(const digraph d, unsigned order, const permutation_list *perms,
                           digraph out)
{
    digraph_conjugate(d, perms->items[0], order, out);
    for (size_t k = 1; k < perms->count; k++) {
        digraph candidate;
        digraph_conjugate(d, perms->items[k], order, candidate);
        if (digraph_compare(candidate, out, order) < 0) memcpy(out, candidate, order);
    }
}

/* `list` holds `count` digraphs back to back, MAX_ORDER entries each */
static int digraph_is_among(const digraph d, const element *list, size_t count, unsigned order)
{
    for (size_t i = 0; i < count; i++)
        if (digraph_compare(d, list + i * MAX_ORDER, order) == 0) return 1;
    return 0;
}

size_t digraph_count_in_type(const digraph d, unsigned order, const permutation_list *perms)
{
    digraph seen[MAX_PERMUTATIONS];
    size_t distinct = 0;
    for (size_t k = 0; k < perms->count; k++) {
        digraph candidate;
        digraph_conjugate(d, perms->items[k], order, candidate);
        if (!digraph_is_among(candidate, seen[0], distinct, order))
            memcpy(seen[distinct++], candidate, order);
    }
    return distinct;
}

/* the least loopless word: 1 0 0 ... 0 */
void digraph_first(digraph d, unsigned order)
{
    for (element x = 0; x < order; x++) d[x] = (x == 0);
}

static int advance_entry_skipping_loop(digraph d, element x, unsigned order)
{
    do { d[x]++; } while (d[x] == x);
    return d[x] < order;
}

/* the next loopless word in lexicographic order; 0 after the last one */
int digraph_next(digraph d, unsigned order)
{
    for (element x = (element)order; x-- > 0;) {
        if (advance_entry_skipping_loop(d, x, order)) return 1;
        d[x] = (x == 0);
    }
    return 0;
}
