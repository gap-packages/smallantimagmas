#include "deltas/deltas.h"

#include <inttypes.h>

void deltas_begin(deltas_writer *w, FILE *out)
{
    w->previous = 0;
    w->count = 0;
    fputs("local result;result:=[", out);
}

int deltas_add(deltas_writer *w, uint64_t key, FILE *out)
{
    if (w->count > 0 && key <= w->previous) return 0;
    fprintf(out, "%s%" PRIu64, w->count > 0 ? "," : "", key - w->previous);
    w->previous = key;
    w->count++;
    return 1;
}

void deltas_end(const deltas_writer *w, FILE *out)
{
    (void)w;
    fputs("];return result;", out);
}
