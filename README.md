# euler-ocaml

https://projecteuler.net/archives

## Benchmarks

cd to ~root~/bench and run:
```properties
./runner.sh
```

You may have to chmod it
```properties
chmod u+x runner.sh
```


## What i've learned
jane streets ppx libraries are really great so far really enjoying writing inline tests and benchmarks per file

Hard to see a usecase for List, Sequence are generally faster (does seem to allocate more however) and Iter is way faster and allocate less. Handcrafted, imperative for-loop with a mutable variable definitely wins out though.

Need extreme speed and it's ok with local mutability -> imperative for/while loops
Need to use a sum type/ operations that can fail -> Sequence
Otherwise -> Iter

### Dune
When running tests that require the filesystem, remember that by default your in the _build folder with no other files then what is going to be tested. To add files/folders add:  (inline_tests (deps (glob_files some_folder/*)))


### ppx_bench
Look at bench/runner.sh to understand how it's linked, the exports are important.

### Core - random learnings
  * Base.With_return is great for wrapping imperative loops, for-loop that needs an exit case is an great example. (See solution_009)

### Async
Kind of struggling, very little documentation but here's what i've gathered so far:
  * The scheduler has to be turned on at some point
    * In benches i've used Thread_safe to turn on/off scheduler automatically
    * In expect's it's handled automagically
    * I have not started a program manually yet (need to understand Scheduler lib)
  * let%bind is just <-
