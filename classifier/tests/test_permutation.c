/* Unit tests for permutation.c. */
#include "permutation/permutation.h"
#include "runner.h"

#include <string.h>

static void test_identity(void)
{
    permutation p;
    permutation_set_identity(p, 4);
    for (element i = 0; i < 4; i++) CU_ASSERT_EQUAL(p[i], i);
}

static void test_advance_follows_lexicographic_order(void)
{
    permutation p = {0, 1, 2};
    static const element expected[6][3] = {
        {0, 1, 2}, {0, 2, 1}, {1, 0, 2}, {1, 2, 0}, {2, 0, 1}, {2, 1, 0}};
    for (unsigned k = 0; k < 6; k++) {
        CU_ASSERT_EQUAL(memcmp(p, expected[k], 3), 0);
        CU_ASSERT_EQUAL(permutation_advance(p, 3), k < 5);
    }
}

static void test_advance_from_last_returns_zero_and_leaves_it(void)
{
    permutation p = {2, 1, 0};
    CU_ASSERT_EQUAL(permutation_advance(p, 3), 0);
}

static void test_build_counts_factorials(void)
{
    static permutation_list list;
    static const size_t factorial[] = {1, 1, 2, 6, 24, 120, 720};
    for (unsigned order = 1; order <= MAX_ORDER; order++) {
        permutation_build_all(order, &list);
        CU_ASSERT_EQUAL(list.count, factorial[order]);
    }
}

static void test_build_starts_with_identity_and_ends_reversed(void)
{
    static permutation_list list;
    permutation_build_all(4, &list);
    for (element i = 0; i < 4; i++) {
        CU_ASSERT_EQUAL(list.items[0][i], i);
        CU_ASSERT_EQUAL(list.items[list.count - 1][i], 3 - i);
    }
}

static void test_build_clamps_order(void)
{
    static permutation_list list;
    permutation_build_all(0, &list);
    CU_ASSERT_EQUAL(list.count, 1);
    permutation_build_all(MAX_ORDER + 1, &list);
    CU_ASSERT_EQUAL(list.count, MAX_PERMUTATIONS);
}

static const test_case cases[] = {
    {"identity", test_identity},
    {"advance follows lexicographic order", test_advance_follows_lexicographic_order},
    {"advance from last returns zero", test_advance_from_last_returns_zero_and_leaves_it},
    {"build counts factorials", test_build_counts_factorials},
    {"build starts with identity and ends reversed",
     test_build_starts_with_identity_and_ends_reversed},
    {"build clamps order", test_build_clamps_order},
};

int main(void) { return RUN_SUITE("permutation", cases); }
