#include "store/store.h"

#include <stdlib.h>
#include <string.h>

void store_start(store *s)
{
    s->keys = NULL;
    s->count = 0;
    s->capacity = 0;
}

void store_free(store *s)
{
    free(s->keys);
    store_start(s);
}

static int grow_store_if_needed(store *s)
{
    if (s->count < s->capacity) return 1;
    size_t capacity = s->capacity ? 2 * s->capacity : 1024;
    uint64_t *keys = realloc(s->keys, capacity * sizeof *keys);
    if (!keys) return 0;
    s->keys = keys;
    s->capacity = capacity;
    return 1;
}

size_t store_position_of(const store *s, uint64_t key)
{
    size_t low = 0, high = s->count;
    while (low < high) {
        size_t middle = low + (high - low) / 2;
        if (s->keys[middle] < key) low = middle + 1; else high = middle;
    }
    return low;
}

int store_add(store *s, uint64_t key)
{
    size_t at = store_position_of(s, key);
    if (at < s->count && s->keys[at] == key) return 0;
    if (!grow_store_if_needed(s)) return -1;
    memmove(s->keys + at + 1, s->keys + at, (s->count - at) * sizeof *s->keys);
    s->keys[at] = key;
    s->count++;
    return 1;
}
