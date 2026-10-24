#include "antiassociative/antiassociative.h"

int antiassociative_triple_is_associative(const table *t, element a, element b, element c)
{
    return table_product(t, table_product(t, a, b), c) == table_product(t, a, table_product(t, b, c));
}

int antiassociative_holds(const table *t)
{
    unsigned n = table_order(t);
    for (element a = 0; a < n; a++)
        for (element b = 0; b < n; b++)
            for (element c = 0; c < n; c++)
                if (antiassociative_triple_is_associative(t, a, b, c)) return 0;
    return 1;
}

/* 1 when all four products of the triple are assigned and (ab)c = a(bc) */
static int triple_is_already_associative(const table *t, element a, element b, element c)
{
    element ab = table_product(t, a, b), bc = table_product(t, b, c);
    if (ab == UNSET || bc == UNSET) return 0;
    element left = table_product(t, ab, c), right = table_product(t, a, bc);
    return left != UNSET && left == right;
}

/* a partial table is rejected as soon as one triple is associative with all four
   products already assigned */
int antiassociative_partial_holds(const table *t)
{
    unsigned n = table_order(t);
    for (element a = 0; a < n; a++)
        for (element b = 0; b < n; b++)
            for (element c = 0; c < n; c++)
                if (triple_is_already_associative(t, a, b, c)) return 0;
    return 1;
}
