(lang dune 3.5)

(name euler)

(generate_opam_files true)

(source
 (github FreerGit/euler-ocaml))

(authors "Fredrik Eriksson <Freer320@student.liu.se>")

(maintainers "Fredrik Eriksson <Freer320@student.liu.se>")

(documentation https://github.com/FreerGit/euler-ocaml)

(package
 (name euler)
 (synopsis "Solutions to https://projecteuler.net/")
 (description "")
 (depends dune async core core_bench cmdliner ppx_jane ppx_string ppx_expect ppx_bench bignum)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
