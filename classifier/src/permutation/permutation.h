/* permutation.h -- all permutations of {0..n-1} in lexicographic order. */
#ifndef PERMUTATION_H
#define PERMUTATION_H

#include "table/table.h"

#include <stddef.h>

#define MAX_PERMUTATIONS 720u /* MAX_ORDER! */

typedef struct { size_t count; permutation items[MAX_PERMUTATIONS]; } permutation_list;

void permutation_set_identity(permutation p, unsigned order);
int permutation_advance(permutation p, unsigned order);
void permutation_build_all(unsigned order, permutation_list *list);

#endif
