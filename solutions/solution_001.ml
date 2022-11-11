open! Core

let main () =
  List.range 1 1000
  |> List.filter ~f:(fun x -> x mod 3 = 0 || x mod 5 = 0)
  |> List.sum (module Int) ~f:Fn.id
;;

let%test_unit "answer" =
  (* main (); *)
  [%test_result: int] (main ()) ~expect:233168
;;
