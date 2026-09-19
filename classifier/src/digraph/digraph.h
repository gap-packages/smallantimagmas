/* digraph.h -- functional digraphs on {0..n-1}, written as the word d(0)d(1)...d(n-1). */
#ifndef DIGRAPH_H
#define DIGRAPH_H

#include <stddef.h>
#include <stdio.h>

#include "permutation/permutation.h"
#include "table/table.h"

typedef element digraph[MAX_ORDER];

int digraph_has_no_fixed_point(const element *d, unsigned order);
void digraph_print(const digraph d, unsigned order, FILE *out);
/* -1, 0 or 1, comparing the words lexicographically */
int digraph_compare(const digraph left, const digraph right, unsigned order);
void digraph_conjugate(const digraph d, const permutation p, unsigned order, digraph out);
void digraph_least_in_type(const digraph d, unsigned order, const permutation_list *perms,
                           digraph out);
size_t digraph_count_in_type(const digraph d, unsigned order, const permutation_list *perms);
void digraph_first(digraph d, unsigned order);
int digraph_next(digraph d, unsigned order);

#endif
