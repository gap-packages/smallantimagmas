/* Unit tests for deltas.c. */
#include "deltas/deltas.h"
#include "runner.h"

static void write_keys(const uint64_t *keys, size_t count, char *text, size_t size, int *accepted)
{
    deltas_writer w;
    FILE *out = runner_open_capture();
    *accepted = 1;
    deltas_begin(&w, out);
    for (size_t k = 0; k < count; k++)
        if (!deltas_add(&w, keys[k], out)) *accepted = 0;
    deltas_end(&w, out);
    runner_read_capture(out, text, size);
}

static void test_empty_list(void)
{
    char text[64];
    int accepted;
    write_keys(NULL, 0, text, sizeof text, &accepted);
    CU_ASSERT_STRING_EQUAL(text, "local result;result:=[];return result;");
}

static void test_order_2_data_file(void)
{
    static const uint64_t keys[] = {10};
    char text[64];
    int accepted;
    write_keys(keys, 1, text, sizeof text, &accepted);
    CU_ASSERT_TRUE(accepted);
    CU_ASSERT_STRING_EQUAL(text, "local result;result:=[10];return result;");
}

static void test_order_3_data_file(void)
{
    static const uint64_t keys[] = {6813, 6822, 7056, 7065, 10179};
    char text[128];
    int accepted;
    write_keys(keys, 5, text, sizeof text, &accepted);
    CU_ASSERT_TRUE(accepted);
    CU_ASSERT_STRING_EQUAL(text, "local result;result:=[6813,9,234,9,3114];return result;");
}

static void test_keys_must_strictly_increase(void)
{
    static const uint64_t repeated[] = {5, 5}, decreasing[] = {5, 4};
    char text[64];
    int accepted;
    write_keys(repeated, 2, text, sizeof text, &accepted);
    CU_ASSERT_FALSE(accepted);
    write_keys(decreasing, 2, text, sizeof text, &accepted);
    CU_ASSERT_FALSE(accepted);
}

static void test_no_trailing_newline(void)
{
    static const uint64_t keys[] = {1};
    char text[64];
    int accepted;
    size_t length;
    deltas_writer w;
    FILE *out = runner_open_capture();
    deltas_begin(&w, out);
    deltas_add(&w, keys[0], out);
    deltas_end(&w, out);
    length = runner_read_capture(out, text, sizeof text);
    CU_ASSERT_EQUAL(text[length - 1], ';');
    (void)accepted;
}

static const test_case cases[] = {
    {"empty list", test_empty_list},
    {"order 2 data file", test_order_2_data_file},
    {"order 3 data file", test_order_3_data_file},
    {"keys must strictly increase", test_keys_must_strictly_increase},
    {"no trailing newline", test_no_trailing_newline},
};

int main(void) { return RUN_SUITE("deltas", cases); }
