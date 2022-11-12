#!/bin/bash
export BENCHMARKS_RUNNER=TRUE
export BENCH_LIB=euler_solutions
exec dune exec -- ./main.exe -fork -run-without-cross-library-inlining "$@" -quota 5 -stabilize-gc
