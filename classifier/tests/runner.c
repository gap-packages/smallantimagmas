#include "runner.h"

static int register_cases(CU_pSuite suite, const test_case *cases, size_t count)
{
    for (size_t k = 0; k < count; k++)
        if (!CU_add_test(suite, cases[k].name, cases[k].run)) return 0;
    return 1;
}

int runner_run_suite(const char *name, const test_case *cases, size_t count)
{
    if (CU_initialize_registry() != CUE_SUCCESS) return (int)CU_get_error();
    CU_pSuite suite = CU_add_suite(name, NULL, NULL);
    if (!suite || !register_cases(suite, cases, count)) {
        CU_cleanup_registry();
        return (int)CU_get_error();
    }
    CU_basic_set_mode(CU_BRM_VERBOSE);
    CU_basic_run_tests();
    unsigned failures = CU_get_number_of_failures();
    CU_cleanup_registry();
    return failures ? 1 : 0;
}

FILE *runner_open_capture(void)
{
    return tmpfile();
}

size_t runner_read_capture(FILE *capture, char *buffer, size_t size)
{
    rewind(capture);
    size_t length = fread(buffer, 1, size - 1, capture);
    buffer[length] = '\0';
    fclose(capture);
    return length;
}
