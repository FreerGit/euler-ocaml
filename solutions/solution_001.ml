open! Core

let main () =
  Sequence.range 1 1000
  |> Sequence.filter ~f:(fun x -> x mod 3 = 0 || x mod 5 = 0)
  |> Sequence.sum (module Int) ~f:Fn.id
;;

let%test_unit "answser" = [%test_result: int] (main ()) ~expect:233168
let%bench "Multiples of 3 or 5" = main ()
