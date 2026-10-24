/* runner.h -- the shared CUnit driver for the test programs. */
#ifndef RUNNER_H
#define RUNNER_H

#include <CUnit/Basic.h>
#include <stddef.h>
#include <stdio.h>

typedef struct { const char *name; CU_TestFunc run; } test_case;

/* runs one suite and returns the process exit status */
int runner_run_suite(const char *name, const test_case *cases, size_t count);
#define RUN_SUITE(name, cases) runner_run_suite(name, cases, sizeof cases / sizeof *cases)

/* a temporary stream to print into; runner_read_capture copies its contents and closes it */
FILE *runner_open_capture(void);
size_t runner_read_capture(FILE *capture, char *buffer, size_t size);

#endif
