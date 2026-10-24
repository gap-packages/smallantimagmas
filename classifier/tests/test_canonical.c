/* Unit tests for canonical.c. */
#include "canonical/canonical.h"
#include "runner.h"

static permutation_list perms;

/* order 3: rows 2 1 1 / 3 1 1 / 2 1 1, an anti-associative magma that is not
   isomorphic to its opposite */
static void make_sample(table *t)
{
    static const element rows[3][3] = {{1, 0, 0}, {2, 0, 0}, {1, 0, 0}};
    table_clear(t, 3);
    for (element i = 0; i < 3; i++)
        for (element j = 0; j < 3; j++) table_set_product(t, i, j, rows[i][j]);
}

static void test_canonical_is_never_larger_than_input(void)
{
    table t, c;
    make_sample(&t);
    permutation_build_all(3, &perms);
    canonical_under_relabelling(&t, &perms, &c);
    CU_ASSERT_TRUE(table_compare(&c, &t) <= 0);
}

static void test_relabelled_tables_share_a_canonical_form(void)
{
    table t, r, ct, cr;
    make_sample(&t);
    permutation_build_all(3, &perms);
    for (size_t k = 0; k < perms.count; k++) {
        table_relabel(&t, perms.items[k], &r);
        canonical_under_relabelling(&t, &perms, &ct);
        canonical_under_relabelling(&r, &perms, &cr);
        CU_ASSERT_EQUAL(table_compare(&ct, &cr), 0);
    }
}

static void test_canonical_form_is_a_relabelling_of_the_input(void)
{
    table t, c, r;
    int found = 0;
    make_sample(&t);
    permutation_build_all(3, &perms);
    canonical_under_relabelling(&t, &perms, &c);
    for (size_t k = 0; k < perms.count; k++) {
        table_relabel(&t, perms.items[k], &r);
        if (table_compare(&r, &c) == 0) found = 1;
    }
    CU_ASSERT_TRUE(found);
}

static void test_transposition_variant_is_the_smaller_of_both(void)
{
    table t, s, from_t, from_s, both;
    make_sample(&t);
    permutation_build_all(3, &perms);
    table_transpose(&t, &s);
    canonical_under_relabelling(&t, &perms, &from_t);
    canonical_under_relabelling(&s, &perms, &from_s);
    canonical_under_relabelling_and_transposition(&t, &perms, &both);
    CU_ASSERT_TRUE(table_compare(&both, &from_t) <= 0);
    CU_ASSERT_TRUE(table_compare(&both, &from_s) <= 0);
    CU_ASSERT_TRUE(table_compare(&both, &from_t) == 0 || table_compare(&both, &from_s) == 0);
}

static void test_table_and_its_opposite_agree_up_to_anti_isomorphism(void)
{
    table t, s, ct, cs;
    make_sample(&t);
    permutation_build_all(3, &perms);
    table_transpose(&t, &s);
    canonical_under_relabelling_and_transposition(&t, &perms, &ct);
    canonical_under_relabelling_and_transposition(&s, &perms, &cs);
    CU_ASSERT_EQUAL(table_compare(&ct, &cs), 0);
}

static const test_case cases[] = {
    {"canonical is never larger than input", test_canonical_is_never_larger_than_input},
    {"relabelled tables share a canonical form",
     test_relabelled_tables_share_a_canonical_form},
    {"canonical form is a relabelling of the input",
     test_canonical_form_is_a_relabelling_of_the_input},
    {"transposition variant is the smaller of both",
     test_transposition_variant_is_the_smaller_of_both},
    {"table and its opposite agree up to anti-isomorphism",
     test_table_and_its_opposite_agree_up_to_anti_isomorphism},
};

int main(void) { return RUN_SUITE("canonical", cases); }
