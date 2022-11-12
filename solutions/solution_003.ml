open! Core

let rec largest_prime_factor x i =
  if x > 1
  then (
    match x % i = 0 with
    | true -> largest_prime_factor (x / i) i
    | false -> largest_prime_factor x (i + 1))
  else i
;;

let%test_unit "largest prime factor" =
  [%test_result: int] (largest_prime_factor 600851475143 2) ~expect:6857
;;

let%bench "Largest prime factor" = largest_prime_factor 600851475143 2
