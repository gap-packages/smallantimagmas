/* antiassociative.h -- the anti-associativity test (ab)c != a(bc). */
#ifndef ANTIASSOCIATIVE_H
#define ANTIASSOCIATIVE_H

#include "table/table.h"

int antiassociative_triple_is_associative(const table *t, element a, element b, element c);
int antiassociative_holds(const table *t);
int antiassociative_partial_holds(const table *t);

#endif
