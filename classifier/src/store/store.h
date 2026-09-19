/* store.h -- a sorted set of 64-bit canonical keys, so each class is printed once. */
#ifndef STORE_H
#define STORE_H

#include <stddef.h>
#include <stdint.h>

typedef struct {
    uint64_t *keys;
    size_t count;
    size_t capacity;
} store;

void store_start(store *s);
void store_free(store *s);
/* index of the first key not less than `key` */
size_t store_position_of(const store *s, uint64_t key);
/* 1 if the key was new, 0 if already present, -1 when out of memory */
int store_add(store *s, uint64_t key);

#endif
