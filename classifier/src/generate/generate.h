/* generate.h -- enumerate the anti-associative tables with a prescribed diagonal. */
#ifndef GENERATE_H
#define GENERATE_H

#include "digraph/digraph.h"
#include "table/table.h"

typedef void (*table_visitor)(const table *t, void *context);

void generate_tables_with_diagonal(const digraph d, unsigned order, table_visitor visit,
                                   void *context);

#endif
