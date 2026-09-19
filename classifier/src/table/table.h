/* table.h -- multiplication tables of small magmas. */
#ifndef TABLE_H
#define TABLE_H

#include <stdint.h>

/* the classifier targets 64-bit processors only */
typedef char table_requires_a_64_bit_target[sizeof(void *) == 8 ? 1 : -1];

/* largest order the fixed-size tables support; n^(n*n) tables exist for order n,
   so nothing beyond 6 is ever enumerable */
#define MAX_ORDER 6u
#define UNSET 255u

typedef unsigned char element;
typedef struct { unsigned order; element product[MAX_ORDER][MAX_ORDER]; } table;
typedef element permutation[MAX_ORDER];

unsigned table_order(const table *t);
element table_product(const table *t, element left, element right);
void table_set_product(table *t, element left, element right, element value);
void table_clear(table *t, unsigned order);
void table_relabel(const table *source, const permutation renaming, table *destination);
void table_transpose(const table *source, table *destination);
/* -1, 0 or 1, comparing row by row */
int table_compare(const table *left, const table *right);
int table_is_smaller(const table *candidate, const table *incumbent);
uint64_t table_key(const table *t);

#endif
