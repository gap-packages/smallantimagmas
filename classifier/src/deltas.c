/* deltas.c -- turns the keys printed by antimagma into a package data file.
 *
 * Reads one key per line from stdin, in increasing order, and writes the data file
 * to stdout; gzip it into data/<n>/small_<n>.g.gz.
 */
#include "deltas/deltas.h"
#include "input/input.h"

#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    deltas_writer w;
    uint64_t key;
    deltas_begin(&w, stdout);
    while (input_read_integer(stdin, &key))
        if (!deltas_add(&w, key, stdout)) {
            fprintf(stderr, "keys must be strictly increasing\n");
            return 2;
        }
    deltas_end(&w, stdout);
    return EXIT_SUCCESS;
}
