open! Core

let is_prime x =
  if x <= 1 then false else List.range 2 x |> List.exists ~f:(fun i -> x % i = 0) |> not
;;

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


let%bench "largest prime factor" = largest_prime_factor 600851475143 2