/* canonical.h -- least table in an isomorphism class. */
#ifndef CANONICAL_H
#define CANONICAL_H

#include "permutation/permutation.h"
#include "table/table.h"

void canonical_under_relabelling(const table *t, const permutation_list *perms,
                                   table *destination);
void canonical_under_relabelling_and_transposition(const table *t,
                                                     const permutation_list *perms,
                                                     table *destination);

#endif
