/* Unit tests for input.c. */
#include "input/input.h"
#include "runner.h"

#include <string.h>

static FILE *stream_of(const char *text)
{
    FILE *in = tmpfile();
    fputs(text, in);
    rewind(in);
    return in;
}

static void test_read_integers_skips_separators(void)
{
    FILE *in = stream_of("12, 3\n\n  45x7");
    uint64_t value;
    CU_ASSERT_EQUAL(input_read_integer(in, &value), 1); CU_ASSERT_EQUAL(value, 12);
    CU_ASSERT_EQUAL(input_read_integer(in, &value), 1); CU_ASSERT_EQUAL(value, 3);
    CU_ASSERT_EQUAL(input_read_integer(in, &value), 1); CU_ASSERT_EQUAL(value, 45);
    CU_ASSERT_EQUAL(input_read_integer(in, &value), 1); CU_ASSERT_EQUAL(value, 7);
    CU_ASSERT_EQUAL(input_read_integer(in, &value), 0);
    fclose(in);
}

static void test_read_table_converts_to_zero_based(void)
{
    FILE *in = stream_of("2 2 1 2 1");
    table t;
    CU_ASSERT_EQUAL(input_read_table(in, &t), 1);
    CU_ASSERT_EQUAL(t.order, 2);
    CU_ASSERT_EQUAL(table_product(&t, 0, 0), 1); CU_ASSERT_EQUAL(table_product(&t, 0, 1), 0);
    CU_ASSERT_EQUAL(table_product(&t, 1, 0), 1); CU_ASSERT_EQUAL(table_product(&t, 1, 1), 0);
    CU_ASSERT_EQUAL(input_read_table(in, &t), 0);
    fclose(in);
}

static void test_read_table_reads_several_in_sequence(void)
{
    FILE *in = stream_of("2 2 1 2 1\n2 2 2 1 1\n");
    table t;
    CU_ASSERT_EQUAL(input_read_table(in, &t), 1);
    CU_ASSERT_EQUAL(input_read_table(in, &t), 1);
    CU_ASSERT_EQUAL(table_product(&t, 0, 1), 1);
    CU_ASSERT_EQUAL(input_read_table(in, &t), 0);
    fclose(in);
}

static void test_read_table_rejects_bad_input(void)
{
    table t;
    FILE *in;
    in = stream_of("7 1");        CU_ASSERT_EQUAL(input_read_table(in, &t), -1); fclose(in);
    in = stream_of("2 1 2 3");    CU_ASSERT_EQUAL(input_read_table(in, &t), -1); fclose(in);
    in = stream_of("2 1 2 3 1");  CU_ASSERT_EQUAL(input_read_table(in, &t), -1); fclose(in);
}

static const test_case cases[] = {
    {"read integers skips separators", test_read_integers_skips_separators},
    {"read table converts to zero-based", test_read_table_converts_to_zero_based},
    {"read table reads several in sequence", test_read_table_reads_several_in_sequence},
    {"read table rejects bad input", test_read_table_rejects_bad_input},
};

int main(void) { return RUN_SUITE("input", cases); }
