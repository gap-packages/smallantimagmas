CC       = gcc
CFLAGS  ?= -O2 -Wall -Wextra -Wpedantic -Werror -std=c99
LDLIBS  ?= -lcunit
COVFLAGS ?= -O0 --coverage
CPPFLAGS += -Isrc
DATA_DIR ?= ../data
PARTS_DIR ?= parts

PROGRAMS      := antimagma deltas
LIB_SOURCES   := $(wildcard src/*/*.c)
LIB_OBJECTS   := $(LIB_SOURCES:.c=.o)
TEST_PROGRAMS := $(patsubst %.c,%,$(wildcard tests/test_*.c))

all: $(PROGRAMS)

$(PROGRAMS): %: src/%.o $(LIB_OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^

tests/test_%: tests/test_%.o tests/runner.o $(LIB_OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^ $(LDLIBS)

# classifies the whole order and writes the package's data file for it:
#   make classify ORDER=4
classify: $(PROGRAMS)
	@test -n "$(ORDER)" || { echo "usage: make classify ORDER=<n>"; exit 2; }
	mkdir -p $(DATA_DIR)/$(ORDER)
	./antimagma -order $(ORDER) all | ./deltas | gzip -n -9 > $(DATA_DIR)/$(ORDER)/small_$(ORDER).g.gz

# prints the commands that classify the order one diagonal type at a time and
# then combine the parts into the data file; pipe into sh, or run them in parallel:
#   make plan ORDER=4 | sh
plan: $(PROGRAMS)
	@test -n "$(ORDER)" || { echo "usage: make plan ORDER=<n>"; exit 2; }
	@types=$$(./antimagma -order $(ORDER) -list | sed -n 's/^  \([0-9]*\) types.*/\1/p'); \
	echo "mkdir -p $(PARTS_DIR)/$(ORDER)"; \
	for type in $$(seq 1 $$types); do \
	    echo "./antimagma -order $(ORDER) $$type > $(PARTS_DIR)/$(ORDER)/$$type.keys"; \
	done; \
	echo "$(MAKE) combine ORDER=$(ORDER) PARTS_DIR=$(PARTS_DIR) DATA_DIR=$(DATA_DIR)"

# merges the per-type parts written by the plan into the data file of the order
combine: $(PROGRAMS)
	@test -n "$(ORDER)" || { echo "usage: make combine ORDER=<n>"; exit 2; }
	@test -d $(PARTS_DIR)/$(ORDER) || { echo "no parts in $(PARTS_DIR)/$(ORDER); run the plan first"; exit 2; }
	mkdir -p $(DATA_DIR)/$(ORDER)
	LC_ALL=C sort -n -m $(PARTS_DIR)/$(ORDER)/*.keys | ./deltas | gzip -n -9 > $(DATA_DIR)/$(ORDER)/small_$(ORDER).g.gz

test: $(TEST_PROGRAMS)
	@for program in $(TEST_PROGRAMS); do ./$$program || exit 1; done

# rebuilds and runs the tests with gcov instrumentation added to CFLAGS, then
# writes one .gcov file per source into this directory for the coverage upload
coverage: override CFLAGS += $(COVFLAGS)
coverage: clean test
	@for source in $(LIB_SOURCES); do gcov -o $$(dirname $$source) $$source || exit 1; done

clean:
	rm -f $(PROGRAMS) $(TEST_PROGRAMS)
	rm -f src/*.o src/*/*.o tests/*.o *.gcov
	rm -f src/*.gcno src/*.gcda src/*/*.gcno src/*/*.gcda tests/*.gcno tests/*.gcda

.PHONY: all classify plan combine test coverage clean
.NOTPARALLEL: coverage
