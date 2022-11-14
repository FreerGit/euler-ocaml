open! Core
open! Import

let sum_of_primes n =
  let primes = Primes.generate_primes_upto n in
  Sequence.sum (module Int) primes ~f:Fn.id
;;

let%test_unit "sum of primes" = [%test_result: int] (sum_of_primes 1000) ~expect:76127

let%test_unit "sum of primes" =
  [%test_result: int] (sum_of_primes 2_000_000) ~expect:142913828922
;;

let%bench "sum of primes" = sum_of_primes 2_000_000
