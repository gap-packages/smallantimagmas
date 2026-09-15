# classifier

C tools that produce the package's data files. `antimagma` enumerates
the anti-associative magmas of a given order and prints the number of
the canonical multiplication table of every class, in increasing
order; the line number of a key is the id of that magma. `deltas`
turns that list into a data file.

A magma is anti-associative when `(ab)c != a(bc)` for all `a, b, c`.
Its diagonal map `d(x) = x*x` then has no fixed point, so the diagonal
of a multiplication table is a loopless functional digraph on `{1..n}`.
The tool groups those digraphs into types up to relabelling and
enumerates the tables type by type. By default it prints nothing but
the data; `-report` adds a detailed report on stderr. Run
`./antimagma -help` for the options.

```sh
make classify ORDER=4
```

This writes `../data/4/small_4.g.gz`. To split the work by diagonal
type, for instance across machines, print the commands, run the
per-type ones in any order, then combine the parts:

```sh
make plan ORDER=4
make combine ORDER=4
```

The same split runs on GitHub Actions: the `Classify` workflow takes
the order as input, classifies every diagonal type in its own job,
combines the parts, and opens a pull request with the new data file.

The single-command form of `classify` is

```sh
./antimagma -order 4 all | ./deltas | gzip > ../data/4/small_4.g.gz
```

## Building and testing

The tests need the CUnit development package (`libcunit1-dev` on
Debian and Ubuntu). The Makefile in this directory is the single source
of truth for how these files are built. From this directory:

```sh
make
make test
make coverage
make classify ORDER=<n>
make plan ORDER=<n>
make combine ORDER=<n>
make clean
```
