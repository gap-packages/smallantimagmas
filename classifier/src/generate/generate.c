#include "generate/generate.h"

#include "antiassociative/antiassociative.h"

typedef struct {
    size_t count;
    element row[MAX_ORDER * MAX_ORDER];
    element column[MAX_ORDER * MAX_ORDER];
} cell_plan;

typedef struct {
    cell_plan cells;
    table_visitor visit;
    void *context;
} generation;

/* the off-diagonal cells in row-major order; the diagonal is fixed in advance */
static void plan_cells(cell_plan *plan, unsigned order)
{
    plan->count = 0;
    for (element i = 0; i < order; i++)
        for (element j = 0; j < order; j++)
            if (i != j) {
                plan->row[plan->count] = i;
                plan->column[plan->count] = j;
                plan->count++;
            }
}

static void fill_cells_from(generation *g, table *t, size_t next_cell)
{
    if (next_cell == g->cells.count) { g->visit(t, g->context); return; }
    element row = g->cells.row[next_cell], column = g->cells.column[next_cell];
    unsigned n = table_order(t);
    for (element value = 0; value < n; value++) {
        table_set_product(t, row, column, value);
        if (antiassociative_partial_holds(t)) fill_cells_from(g, t, next_cell + 1);
    }
    table_set_product(t, row, column, UNSET);
}

static void place_diagonal(table *t, const digraph d, unsigned order)
{
    table_clear(t, order);
    for (element x = 0; x < order; x++) table_set_product(t, x, x, d[x]);
}

void generate_tables_with_diagonal(const digraph d, unsigned order, table_visitor visit,
                                   void *context)
{
    generation g;
    table t;
    g.visit = visit;
    g.context = context;
    plan_cells(&g.cells, order);
    place_diagonal(&t, d, order);
    fill_cells_from(&g, &t, 0);
}
