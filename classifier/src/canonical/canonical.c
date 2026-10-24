#include "canonical/canonical.h"

void canonical_under_relabelling(const table *t, const permutation_list *perms,
                                 table *destination)
{
    table_relabel(t, perms->items[0], destination);
    for (size_t k = 1; k < perms->count; k++) {
        table candidate;
        table_relabel(t, perms->items[k], &candidate);
        if (table_is_smaller(&candidate, destination)) *destination = candidate;
    }
}

void canonical_under_relabelling_and_transposition(const table *t,
                                                   const permutation_list *perms,
                                                   table *destination)
{
    table opposite, from_opposite;
    canonical_under_relabelling(t, perms, destination);
    table_transpose(t, &opposite);
    canonical_under_relabelling(&opposite, perms, &from_opposite);
    if (table_is_smaller(&from_opposite, destination)) *destination = from_opposite;
}
