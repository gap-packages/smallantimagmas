/* deltas.h -- the package's data file format.

   A data file is the GAP fragment  local result;result:=[d1,d2,...];return result;
   where the d_k are the successive differences of the sorted table keys.  The writer
   streams, so a file of any length needs constant memory. */
#ifndef DELTAS_H
#define DELTAS_H

#include <stddef.h>
#include <stdint.h>
#include <stdio.h>

typedef struct { uint64_t previous; size_t count; } deltas_writer;

void deltas_begin(deltas_writer *w, FILE *out);
/* 0 when the key is not larger than the previous one */
int deltas_add(deltas_writer *w, uint64_t key, FILE *out);
void deltas_end(const deltas_writer *w, FILE *out);

#endif
