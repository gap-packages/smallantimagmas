#include "permutation/permutation.h"

#include <string.h>

void permutation_set_identity(permutation p, unsigned order)
{
    for (element i = 0; i < order; i++) p[i] = i;
}

static void swap_elements(element *left, element *right)
{
    element held = *left;
    *left = *right;
    *right = held;
}

static void reverse_tail(permutation p, unsigned from, unsigned order)
{
    for (unsigned left = from, right = order; left + 1 < right; left++, right--)
        swap_elements(&p[left], &p[right - 1]);
}

/* the last position whose entry is smaller than its successor, plus one; 0 if none */
static unsigned pivot_after(const permutation p, unsigned order)
{
    unsigned pivot = order - 1;
    while (pivot > 0 && p[pivot - 1] > p[pivot]) pivot--;
    return pivot;
}

/* rewrites p as the lexicographically next permutation; 0 when p was the last one */
int permutation_advance(permutation p, unsigned order)
{
    unsigned pivot = pivot_after(p, order);
    if (pivot == 0) return 0;
    pivot--;
    unsigned successor = order - 1;
    while (p[successor] < p[pivot]) successor--;
    swap_elements(&p[pivot], &p[successor]);
    reverse_tail(p, pivot + 1, order);
    return 1;
}

void permutation_build_all(unsigned order, permutation_list *list)
{
    permutation p;
    if (order < 1) order = 1;
    if (order > MAX_ORDER) order = MAX_ORDER;
    permutation_set_identity(p, order);
    list->count = 0;
    do {
        memcpy(list->items[list->count++], p, order);
    } while (permutation_advance(p, order));
}
