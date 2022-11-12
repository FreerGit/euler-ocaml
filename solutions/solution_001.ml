open! Core

let list () =
  List.range 1 1000
  |> List.filter ~f:(fun x -> x mod 3 = 0 || x mod 5 = 0)
  |> List.sum (module Int) ~f:Fn.id
;;

let seq () =
  Sequence.range 1 1000
  |> Sequence.filter ~f:(fun x -> x mod 3 = 0 || x mod 5 = 0)
  |> Sequence.sum (module Int) ~f:Fn.id
;;

let iter () =
  Iter.int_range ~start:1 ~stop:999
  |> Iter.filter (fun x -> x mod 3 = 0 || x mod 5 = 0)
  |> Iter.sum
;;

let for' () =
  let summed = ref 0 in
  for x = 1 to 999 do
    if x mod 3 = 0 || x mod 5 = 0 then summed := !summed + x
  done;
  !summed
;;

let%test_unit "answser" = [%test_result: int] (list ()) ~expect:233168
let%test_unit "answser" = [%test_result: int] (seq ()) ~expect:233168
let%test_unit "answser" = [%test_result: int] (iter ()) ~expect:233168
let%test_unit "answer'" = [%test_result: int] (for' ()) ~expect:233168
let%bench "Multiples of 3 or 5 range-filter-sum (List)" = list ()
let%bench "Multiples of 3 or 5 range-filter-sum (Sequence)" = seq ()
let%bench "Multiples of 3 or 5 range-filter-sum (Iter)" = iter ()
let%bench "Multiples of 3 or 5 for-loop" = for' ()
