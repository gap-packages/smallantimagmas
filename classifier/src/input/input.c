#include "input/input.h"

int input_read_integer(FILE *in, uint64_t *value)
{
    int c, started = 0;
    uint64_t accumulated = 0;
    while ((c = fgetc(in)) != EOF) {
        if (c >= '0' && c <= '9') { accumulated = accumulated * 10 + (unsigned)(c - '0'); started = 1; }
        else if (started) break;
    }
    if (!started) return 0;
    *value = accumulated;
    return 1;
}

static int read_entry(FILE *in, table *t, element i, element j)
{
    uint64_t value;
    if (!input_read_integer(in, &value)) { fprintf(stderr, "table truncated\n"); return 0; }
    if (value < 1 || value > t->order) { fprintf(stderr, "entry out of range\n"); return 0; }
    t->product[i][j] = (element)(value - 1);
    return 1;
}

int input_read_table(FILE *in, table *t)
{
    uint64_t order;
    if (!input_read_integer(in, &order)) return 0;
    if (order < 1 || order > MAX_ORDER) { fprintf(stderr, "order out of range\n"); return -1; }
    t->order = (unsigned)order;
    for (element i = 0; i < t->order; i++)
        for (element j = 0; j < t->order; j++)
            if (!read_entry(in, t, i, j)) return -1;
    return 1;
}
