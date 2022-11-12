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
Need to use a sum type -> Sequence
Otherwise -> Iter