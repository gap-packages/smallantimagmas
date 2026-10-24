/* Unit tests for table.c. */
#include "table/table.h"
#include "runner.h"

#include <string.h>

/* the order-2 table 0*0=1 0*1=0 1*0=1 1*1=0 */
static void make_sample(table *t)
{
    table_clear(t, 2);
    table_set_product(t, 0, 0, 1); table_set_product(t, 0, 1, 0);
    table_set_product(t, 1, 0, 1); table_set_product(t, 1, 1, 0);
}

static void test_order_of_is_clamped(void)
{
    table t;
    t.order = 0;  CU_ASSERT_EQUAL(table_order(&t), 1);
    t.order = 3;  CU_ASSERT_EQUAL(table_order(&t), 3);
    t.order = 99; CU_ASSERT_EQUAL(table_order(&t), MAX_ORDER);
}

static void test_clear_table_unsets_every_cell(void)
{
    table t;
    table_clear(&t, 3);
    CU_ASSERT_EQUAL(t.order, 3);
    for (element i = 0; i < MAX_ORDER; i++)
        for (element j = 0; j < MAX_ORDER; j++) CU_ASSERT_EQUAL(table_product(&t, i, j), UNSET);
}

static void test_set_and_get_product(void)
{
    table t;
    table_clear(&t, 2);
    table_set_product(&t, 1, 0, 1);
    CU_ASSERT_EQUAL(table_product(&t, 1, 0), 1);
    CU_ASSERT_EQUAL(table_product(&t, 0, 1), UNSET);
}

static void test_relabel_by_swap(void)
{
    table t, r;
    permutation swap = {1, 0};
    make_sample(&t);
    table_relabel(&t, swap, &r);
    /* r[p(i)][p(j)] = p(t[i][j]) */
    CU_ASSERT_EQUAL(table_product(&r, 1, 1), 0);
    CU_ASSERT_EQUAL(table_product(&r, 1, 0), 1);
    CU_ASSERT_EQUAL(table_product(&r, 0, 1), 0);
    CU_ASSERT_EQUAL(table_product(&r, 0, 0), 1);
}

static void test_relabel_by_identity_is_identity(void)
{
    table t, r;
    permutation identity = {0, 1};
    make_sample(&t);
    table_relabel(&t, identity, &r);
    CU_ASSERT_EQUAL(table_compare(&t, &r), 0);
}

static void test_transpose(void)
{
    table t, s;
    make_sample(&t);
    table_transpose(&t, &s);
    CU_ASSERT_EQUAL(s.order, 2);
    CU_ASSERT_EQUAL(table_product(&s, 0, 1), table_product(&t, 1, 0));
    CU_ASSERT_EQUAL(table_product(&s, 1, 0), table_product(&t, 0, 1));
    CU_ASSERT_EQUAL(table_product(&s, 0, 0), table_product(&t, 0, 0));
}

static void test_compare_is_row_major_lexicographic(void)
{
    table a, b;
    make_sample(&a);
    b = a;
    CU_ASSERT_EQUAL(table_compare(&a, &b), 0);
    CU_ASSERT_FALSE(table_is_smaller(&a, &b));
    table_set_product(&b, 0, 1, 1);
    CU_ASSERT_EQUAL(table_compare(&a, &b), -1);
    CU_ASSERT_EQUAL(table_compare(&b, &a), 1);
    CU_ASSERT_TRUE(table_is_smaller(&a, &b));
}

static void test_key_is_base_n_row_major(void)
{
    table t;
    make_sample(&t);
    /* digits 1 0 1 0 in base 2 */
    CU_ASSERT_EQUAL(table_key(&t), 10);
}

static const test_case cases[] = {
    {"table_order is clamped", test_order_of_is_clamped},
    {"table_clear unsets every cell", test_clear_table_unsets_every_cell},
    {"set and get product", test_set_and_get_product},
    {"relabel by swap", test_relabel_by_swap},
    {"relabel by identity", test_relabel_by_identity_is_identity},
    {"transpose", test_transpose},
    {"compare is row-major lexicographic", test_compare_is_row_major_lexicographic},
    {"key is base-n row-major", test_key_is_base_n_row_major},
};

int main(void) { return RUN_SUITE("table", cases); }
