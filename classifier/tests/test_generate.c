/* Unit tests for generate.c. */
#include "generate/generate.h"
#include "antiassociative/antiassociative.h"
#include "runner.h"

typedef struct { unsigned long count; int all_anti_associative; int diagonal_kept; digraph d; unsigned order; } tally;

static void count_table(const table *t, void *context)
{
    tally *seen = context;
    seen->count++;
    if (!antiassociative_holds(t)) seen->all_anti_associative = 0;
    for (element x = 0; x < seen->order; x++)
        if (table_product(t, x, x) != seen->d[x]) seen->diagonal_kept = 0;
}

static void run(tally *seen, const element *d, unsigned order)
{
    seen->count = 0;
    seen->all_anti_associative = 1;
    seen->diagonal_kept = 1;
    seen->order = order;
    for (element x = 0; x < order; x++) seen->d[x] = d[x];
    generate_tables_with_diagonal(seen->d, order, count_table, seen);
}

static void test_order_2_has_two_tables(void)
{
    static const element swap[] = {1, 0};
    tally seen;
    run(&seen, swap, 2);
    CU_ASSERT_EQUAL(seen.count, 2);
    CU_ASSERT_TRUE(seen.all_anti_associative);
    CU_ASSERT_TRUE(seen.diagonal_kept);
}

static void test_order_3_counts_per_diagonal_type(void)
{
    static const element two_cycle_plus_tail[] = {1, 0, 0}, three_cycle[] = {1, 2, 0};
    tally seen;
    run(&seen, two_cycle_plus_tail, 3);
    CU_ASSERT_EQUAL(seen.count, 8);
    CU_ASSERT_TRUE(seen.all_anti_associative && seen.diagonal_kept);
    run(&seen, three_cycle, 3);
    CU_ASSERT_EQUAL(seen.count, 2);
    CU_ASSERT_TRUE(seen.all_anti_associative && seen.diagonal_kept);
}

static void test_a_diagonal_with_a_fixed_point_yields_nothing(void)
{
    static const element loop[] = {0, 0};
    tally seen;
    run(&seen, loop, 2);
    CU_ASSERT_EQUAL(seen.count, 0);
}

static const test_case cases[] = {
    {"order 2 has two tables", test_order_2_has_two_tables},
    {"order 3 counts per diagonal type", test_order_3_counts_per_diagonal_type},
    {"a diagonal with a fixed point yields nothing",
     test_a_diagonal_with_a_fixed_point_yields_nothing},
};

int main(void) { return RUN_SUITE("generate", cases); }
