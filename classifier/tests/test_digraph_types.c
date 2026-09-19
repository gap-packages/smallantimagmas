/* Unit tests for digraph_types.c. */
#include "digraph_types/digraph_types.h"
#include "runner.h"

#include <string.h>

static permutation_list perms;
static digraph_type_list types;

static void test_order_3_has_two_types(void)
{
    permutation_build_all(3, &perms);
    CU_ASSERT_TRUE(digraph_types_build(3, &perms, &types));
    CU_ASSERT_EQUAL(types.count, 2);
    CU_ASSERT_EQUAL(memcmp(types.items[0].representative, "\1\0\0", 3), 0);
    CU_ASSERT_EQUAL(types.items[0].orbit_size, 6);
    CU_ASSERT_EQUAL(memcmp(types.items[1].representative, "\1\2\0", 3), 0);
    CU_ASSERT_EQUAL(types.items[1].orbit_size, 2);
}

static void test_orbits_partition_all_loopless_digraphs(void)
{
    for (unsigned order = 2; order <= 5; order++) {
        size_t expected = 1, total = 0;
        for (unsigned x = 0; x < order; x++) expected *= order - 1;
        permutation_build_all(order, &perms);
        CU_ASSERT_TRUE(digraph_types_build(order, &perms, &types));
        for (size_t k = 0; k < types.count; k++) total += types.items[k].orbit_size;
        CU_ASSERT_EQUAL(total, expected);
    }
}

static void test_representatives_are_sorted_and_distinct(void)
{
    permutation_build_all(4, &perms);
    digraph_types_build(4, &perms, &types);
    for (size_t k = 1; k < types.count; k++)
        CU_ASSERT_TRUE(digraph_compare(types.items[k - 1].representative,
                                        types.items[k].representative, 4) < 0);
}

static void test_type_number_of(void)
{
    digraph three_cycle = {1, 2, 0}, unknown = {0, 0, 0};
    size_t number = 99;
    permutation_build_all(3, &perms);
    digraph_types_build(3, &perms, &types);
    CU_ASSERT_TRUE(digraph_types_number_of(&types, three_cycle, 3, &number));
    CU_ASSERT_EQUAL(number, 1);
    CU_ASSERT_FALSE(digraph_types_number_of(&types, unknown, 3, &number));
    CU_ASSERT_EQUAL(number, 1);
}

static void test_record_ignores_duplicates_and_reports_overflow(void)
{
    digraph d = {1, 0};
    permutation_build_all(2, &perms);
    types.count = 0;
    CU_ASSERT_TRUE(digraph_types_record(&types, d, 2, &perms));
    CU_ASSERT_TRUE(digraph_types_record(&types, d, 2, &perms));
    CU_ASSERT_EQUAL(types.count, 1);
    types.count = MAX_TYPES;
    d[0] = 0; d[1] = 1;
    CU_ASSERT_FALSE(digraph_types_record(&types, d, 2, &perms));
}

static void test_total_labelled_tables_weights_by_orbit(void)
{
    permutation_build_all(3, &perms);
    digraph_types_build(3, &perms, &types);
    types.items[0].tables_found = 8;
    types.items[1].tables_found = 2;
    CU_ASSERT_EQUAL(digraph_types_total_labelled_tables(&types), 6 * 8 + 2 * 2);
}

static void test_print_list_header_and_summary(void)
{
    char text[512];
    FILE *out = runner_open_capture();
    permutation_build_all(3, &perms);
    digraph_types_build(3, &perms, &types);
    digraph_types_print(&types, 3, out);
    runner_read_capture(out, text, sizeof text);
    CU_ASSERT_PTR_NOT_NULL(strstr(text, "diagonal types of order 3"));
    CU_ASSERT_PTR_NOT_NULL(strstr(text, "    1  211             6  1->2 2->1 3->1\n"));
    CU_ASSERT_PTR_NOT_NULL(strstr(text, "    2  231             2  1->2 2->3 3->1\n"));
    CU_ASSERT_PTR_NOT_NULL(strstr(text, "2 types, 8 loopless functional digraphs in all ((n-1)^n = 8)"));
}

static const test_case cases[] = {
    {"order 3 has two types", test_order_3_has_two_types},
    {"orbits partition all loopless digraphs", test_orbits_partition_all_loopless_digraphs},
    {"representatives are sorted and distinct", test_representatives_are_sorted_and_distinct},
    {"digraph_types_number_of", test_type_number_of},
    {"record ignores duplicates and reports overflow",
     test_record_ignores_duplicates_and_reports_overflow},
    {"total labelled tables weights by orbit", test_total_labelled_tables_weights_by_orbit},
    {"print list header and summary", test_print_list_header_and_summary},
};

int main(void) { return RUN_SUITE("digraph_types", cases); }
