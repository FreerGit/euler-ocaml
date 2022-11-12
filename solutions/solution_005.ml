open! Core

let rec gcd a b = if b = 0 then a else gcd b (a % b)
let lcm a b = a / gcd a b * b
let smallest_multiple () = Iter.int_range ~start:1 ~stop:20 |> Iter.fold lcm 1
let smallest_multiple' () = Sequence.range 1 20 |> Sequence.fold ~init:1 ~f:lcm

let%test_unit "smallest multiple" =
  [%test_result: int] (smallest_multiple ()) ~expect:232792560
;;

let%test_unit "smallest multiple" =
  [%test_result: int] (smallest_multiple' ()) ~expect:232792560
;;

let%bench "smallest multiple Iter" = smallest_multiple ()
let%bench "smallest multiple Seq" = smallest_multiple' ()
