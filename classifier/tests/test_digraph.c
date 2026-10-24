/* Unit tests for digraph.c. */
#include "digraph/digraph.h"
#include "runner.h"

#include <string.h>

static permutation_list perms;

static void test_no_fixed_point_basic_cases(void)
{
    element single[] = {0}, swap[] = {1, 0}, loop_at_end[] = {1, 2, 2};
    CU_ASSERT_EQUAL(digraph_has_no_fixed_point(single, 0), 1);
    CU_ASSERT_EQUAL(digraph_has_no_fixed_point(single, 1), 0);
    CU_ASSERT_EQUAL(digraph_has_no_fixed_point(swap, 2), 1);
    CU_ASSERT_EQUAL(digraph_has_no_fixed_point(loop_at_end, 3), 0);
}

static void test_no_fixed_point_ignores_entries_beyond_order(void)
{
    element d[] = {1, 2, 0, 3};
    CU_ASSERT_EQUAL(digraph_has_no_fixed_point(d, 3), 1);
    CU_ASSERT_EQUAL(digraph_has_no_fixed_point(d, 4), 0);
}

static void test_no_fixed_point_agrees_with_brute_force_over_order_4(void)
{
    element d[4] = {0};
    unsigned loopless = 0;
    for (;;) {
        int expected = 1;
        for (element x = 0; x < 4; x++) if (d[x] == x) expected = 0;
        CU_ASSERT_EQUAL(digraph_has_no_fixed_point(d, 4), expected);
        loopless += (unsigned)expected;
        unsigned x = 4;
        while (x > 0 && ++d[x - 1] == 4) d[--x] = 0;
        if (x == 0) break;
    }
    CU_ASSERT_EQUAL(loopless, 81); /* (n-1)^n = 3^4 */
}

static void test_print_is_one_based_word(void)
{
    digraph d = {1, 0, 0, 2, 3};
    char text[16];
    FILE *out = runner_open_capture();
    digraph_print(d, 5, out);
    runner_read_capture(out, text, sizeof text);
    CU_ASSERT_STRING_EQUAL(text, "21134");
}

static void test_compare_is_lexicographic(void)
{
    digraph a = {1, 0, 0}, b = {1, 2, 0};
    CU_ASSERT_EQUAL(digraph_compare(a, a, 3), 0);
    CU_ASSERT_EQUAL(digraph_compare(a, b, 3), -1);
    CU_ASSERT_EQUAL(digraph_compare(b, a, 3), 1);
}

static void test_conjugate_by_identity_and_by_swap(void)
{
    digraph d = {1, 2, 0}, out;
    permutation identity = {0, 1, 2}, swap01 = {1, 0, 2};
    digraph_conjugate(d, identity, 3, out);
    CU_ASSERT_EQUAL(memcmp(out, d, 3), 0);
    /* 0->1,1->2,2->0 under (0 1) becomes 1->0,0->2,2->1, the word 2 0 1 */
    digraph_conjugate(d, swap01, 3, out);
    CU_ASSERT_EQUAL(out[0], 2); CU_ASSERT_EQUAL(out[1], 0); CU_ASSERT_EQUAL(out[2], 1);
}

static void test_least_in_type_of_a_3_cycle(void)
{
    digraph d = {2, 0, 1}, out;
    permutation_build_all(3, &perms);
    digraph_least_in_type(d, 3, &perms, out);
    CU_ASSERT_EQUAL(out[0], 1); CU_ASSERT_EQUAL(out[1], 2); CU_ASSERT_EQUAL(out[2], 0);
}

static void test_orbit_sizes_of_order_3_types(void)
{
    digraph two_cycle_plus_tail = {1, 0, 0}, three_cycle = {1, 2, 0};
    permutation_build_all(3, &perms);
    CU_ASSERT_EQUAL(digraph_count_in_type(two_cycle_plus_tail, 3, &perms), 6);
    CU_ASSERT_EQUAL(digraph_count_in_type(three_cycle, 3, &perms), 2);
}

static void test_enumeration_visits_every_loopless_word_once(void)
{
    digraph d;
    unsigned count;
    for (unsigned order = 2; order <= 4; order++) {
        unsigned expected = 1;
        for (unsigned x = 0; x < order; x++) expected *= order - 1;
        count = 0;
        digraph_first(d, order);
        do {
            CU_ASSERT_TRUE(digraph_has_no_fixed_point(d, order));
            count++;
        } while (digraph_next(d, order));
        CU_ASSERT_EQUAL(count, expected);
    }
}

static const test_case cases[] = {
    {"no fixed point basic cases", test_no_fixed_point_basic_cases},
    {"no fixed point ignores entries beyond order",
     test_no_fixed_point_ignores_entries_beyond_order},
    {"no fixed point agrees with brute force over order 4",
     test_no_fixed_point_agrees_with_brute_force_over_order_4},
    {"print is one-based word", test_print_is_one_based_word},
    {"compare is lexicographic", test_compare_is_lexicographic},
    {"conjugate by identity and by swap", test_conjugate_by_identity_and_by_swap},
    {"least in type of a 3-cycle", test_least_in_type_of_a_3_cycle},
    {"orbit sizes of order-3 types", test_orbit_sizes_of_order_3_types},
    {"enumeration visits every loopless word once",
     test_enumeration_visits_every_loopless_word_once},
};

int main(void) { return RUN_SUITE("digraph", cases); }
