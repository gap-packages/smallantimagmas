/* Unit tests for store.c. */
#include "store/store.h"
#include "runner.h"

static void test_new_store_is_empty(void)
{
    store s;
    store_start(&s);
    CU_ASSERT_EQUAL(s.count, 0);
    CU_ASSERT_PTR_NULL(s.keys);
    store_free(&s);
}

static void test_add_reports_new_and_duplicate(void)
{
    store s;
    store_start(&s);
    CU_ASSERT_EQUAL(store_add(&s, 7), 1);
    CU_ASSERT_EQUAL(store_add(&s, 7), 0);
    CU_ASSERT_EQUAL(s.count, 1);
    store_free(&s);
}

static void test_keys_are_kept_sorted(void)
{
    store s;
    static const uint64_t keys[] = {5, 1, 9, 3, 7};
    store_start(&s);
    for (size_t k = 0; k < 5; k++) store_add(&s, keys[k]);
    for (size_t i = 1; i < s.count; i++) CU_ASSERT_TRUE(s.keys[i - 1] < s.keys[i]);
    CU_ASSERT_EQUAL(store_position_of(&s, 4), 2);
    CU_ASSERT_EQUAL(store_position_of(&s, 0), 0);
    CU_ASSERT_EQUAL(store_position_of(&s, 10), 5);
    store_free(&s);
}

static void test_store_grows_past_initial_capacity(void)
{
    store s;
    store_start(&s);
    for (uint64_t key = 0; key < 5000; key++) CU_ASSERT_EQUAL(store_add(&s, key), 1);
    CU_ASSERT_EQUAL(s.count, 5000);
    CU_ASSERT_TRUE(s.capacity >= 5000);
    CU_ASSERT_EQUAL(store_add(&s, 4999), 0);
    store_free(&s);
    CU_ASSERT_EQUAL(s.count, 0);
}

static const test_case cases[] = {
    {"new store is empty", test_new_store_is_empty},
    {"add reports new and duplicate", test_add_reports_new_and_duplicate},
    {"keys are kept sorted", test_keys_are_kept_sorted},
    {"store grows past initial capacity", test_store_grows_past_initial_capacity},
};

int main(void) { return RUN_SUITE("store", cases); }
