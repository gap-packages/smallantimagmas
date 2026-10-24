#include "table/table.h"

#include <string.h>

unsigned table_order(const table *t)
{
    unsigned n = t->order;
    return (n < 1) ? 1 : (n > MAX_ORDER ? MAX_ORDER : n);
}

element table_product(const table *t, element left, element right)
{
    return t->product[left][right];
}

void table_set_product(table *t, element left, element right, element value)
{
    t->product[left][right] = value;
}

void table_clear(table *t, unsigned order)
{
    t->order = order;
    memset(t->product, UNSET, sizeof t->product);
}

void table_relabel(const table *source, const permutation renaming, table *destination)
{
    unsigned n = table_order(source);
    destination->order = n;
    for (element i = 0; i < n; i++)
        for (element j = 0; j < n; j++)
            destination->product[renaming[i]][renaming[j]] = renaming[table_product(source, i, j)];
}

void table_transpose(const table *source, table *destination)
{
    unsigned n = table_order(source);
    destination->order = n;
    for (element i = 0; i < n; i++)
        for (element j = 0; j < n; j++)
            destination->product[j][i] = table_product(source, i, j);
}

int table_compare(const table *left, const table *right)
{
    unsigned n = table_order(left);
    for (element i = 0; i < n; i++)
        for (element j = 0; j < n; j++) {
            if (left->product[i][j] < right->product[i][j]) return -1;
            if (left->product[i][j] > right->product[i][j]) return 1;
        }
    return 0;
}

int table_is_smaller(const table *candidate, const table *incumbent)
{
    return table_compare(candidate, incumbent) < 0;
}

/* the key is the row-major base-n digit string; its order matches the order on tables.
   It fits in 64 bits for every enumerable order (n <= 5). */
uint64_t table_key(const table *t)
{
    unsigned n = table_order(t);
    uint64_t key = 0;
    for (element i = 0; i < n; i++)
        for (element j = 0; j < n; j++) key = key * n + table_product(t, i, j);
    return key;
}
