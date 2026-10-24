/* Unit tests for antiassociative.c. */
#include "antiassociative/antiassociative.h"
#include "runner.h"

static void fill(table *t, unsigned order, const element *rows)
{
    table_clear(t, order);
    for (element i = 0; i < order; i++)
        for (element j = 0; j < order; j++)
            table_set_product(t, i, j, rows[i * order + j]);
}

static void test_the_two_order_2_anti_associative_tables(void)
{
    static const element first[] = {1, 0, 1, 0}, second[] = {1, 1, 0, 0};
    table t;
    fill(&t, 2, first);  CU_ASSERT_TRUE(antiassociative_holds(&t));
    fill(&t, 2, second); CU_ASSERT_TRUE(antiassociative_holds(&t));
}

static void test_a_group_table_is_not_anti_associative(void)
{
    static const element z2[] = {0, 1, 1, 0};
    table t;
    fill(&t, 2, z2);
    CU_ASSERT_FALSE(antiassociative_holds(&t));
    CU_ASSERT_TRUE(antiassociative_triple_is_associative(&t, 0, 1, 1));
}

static void test_a_fixed_point_on_the_diagonal_breaks_it(void)
{
    static const element rows[] = {0, 1, 1, 0};
    table t;
    fill(&t, 2, rows);
    /* x*x = x gives (xx)x = xx = x(xx) */
    CU_ASSERT_TRUE(antiassociative_triple_is_associative(&t, 0, 0, 0));
    CU_ASSERT_FALSE(antiassociative_holds(&t));
}

static void test_partial_table_with_unset_cells_is_not_rejected(void)
{
    table t;
    table_clear(&t, 2);
    table_set_product(&t, 0, 0, 1);
    table_set_product(&t, 1, 1, 0);
    CU_ASSERT_TRUE(antiassociative_partial_holds(&t));
}

static void test_partial_table_is_rejected_once_a_triple_closes(void)
{
    table t;
    table_clear(&t, 2);
    table_set_product(&t, 0, 0, 1);
    table_set_product(&t, 1, 1, 0);
    /* 0*1 = 1: then (0*0)*1 = 1*1 = 0 and 0*(0*1) = 0*1 = 1, still fine */
    table_set_product(&t, 0, 1, 1);
    CU_ASSERT_TRUE(antiassociative_partial_holds(&t));
    /* 1*0 = 1: then (1*1)*0 = 0*0 = 1 and 1*(1*0) = 1*1 = 0, fine;
       but (0*1)*0 = 1*0 = 1 and 0*(1*0) = 0*1 = 1, associative */
    table_set_product(&t, 1, 0, 1);
    CU_ASSERT_FALSE(antiassociative_partial_holds(&t));
}

static void test_partial_check_agrees_with_full_check_on_complete_tables(void)
{
    static const element first[] = {1, 0, 1, 0}, z2[] = {0, 1, 1, 0};
    table t;
    fill(&t, 2, first); CU_ASSERT_TRUE(antiassociative_partial_holds(&t));
    fill(&t, 2, z2);    CU_ASSERT_FALSE(antiassociative_partial_holds(&t));
}

static const test_case cases[] = {
    {"the two order-2 anti-associative tables", test_the_two_order_2_anti_associative_tables},
    {"a group table is not anti-associative", test_a_group_table_is_not_anti_associative},
    {"a fixed point on the diagonal breaks it", test_a_fixed_point_on_the_diagonal_breaks_it},
    {"partial table with unset cells is not rejected",
     test_partial_table_with_unset_cells_is_not_rejected},
    {"partial table is rejected once a triple closes",
     test_partial_table_is_rejected_once_a_triple_closes},
    {"partial check agrees with full check on complete tables",
     test_partial_check_agrees_with_full_check_on_complete_tables},
};

int main(void) { return RUN_SUITE("antiassociative", cases); }
