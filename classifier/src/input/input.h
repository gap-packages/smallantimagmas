/* input.h -- reading tables as whitespace-separated integers: n, then n*n entries. */
#ifndef INPUT_H
#define INPUT_H

#include <stdint.h>
#include <stdio.h>

#include "table/table.h"

/* 1 when an unsigned integer was read, 0 at end of input */
int input_read_integer(FILE *in, uint64_t *value);
/* 1 when a table was read, 0 at end of input, -1 on malformed input (message on stderr) */
int input_read_table(FILE *in, table *t);

#endif
