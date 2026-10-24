/* digraph_types.h -- loopless functional digraphs grouped up to relabelling.

   The diagonal of an anti-associative table is a loopless functional digraph.
   Relabelling the magma conjugates the digraph, so the digraphs are grouped into
   types (conjugacy classes), and each type is given a number. */
#ifndef DIGRAPH_TYPES_H
#define DIGRAPH_TYPES_H

#include <stddef.h>
#include <stdio.h>

#include "digraph/digraph.h"

#define MAX_TYPES 128u

typedef struct {
    digraph representative;     /* lexicographically least word in the type */
    size_t orbit_size;          /* number of digraphs in the type */
    unsigned long tables_found; /* labelled tables with this exact diagonal */
} digraph_type;

typedef struct { size_t count; digraph_type items[MAX_TYPES]; } digraph_type_list;

/* 1 and the type number in *number when the representative is listed, else 0 */
int digraph_types_number_of(const digraph_type_list *list, const digraph representative,
                            unsigned order, size_t *number);
/* 0 when the list is full */
int digraph_types_record(digraph_type_list *list, const digraph representative, unsigned order,
                         const permutation_list *perms);
/* 0 when the list overflows */
int digraph_types_build(unsigned order, const permutation_list *perms, digraph_type_list *list);
void digraph_types_print(const digraph_type_list *list, unsigned order, FILE *out);
unsigned long digraph_types_total_labelled_tables(const digraph_type_list *list);

#endif
