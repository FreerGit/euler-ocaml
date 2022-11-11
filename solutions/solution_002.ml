open! Core

let rec fib n =
  match n with
  | 0 -> 0
  | 1 -> 1
  | _ -> fib (n - 1) + fib (n - 2)
;;

let main () =
  List.init 35 ~f:fib
  |> List.filter ~f:(fun x -> x % 2 = 0 && x < 4_000_000)
  |> List.sum (module Int) ~f:Fn.id
  |> printf "%d\n"
;;

let%expect_test "answer" =
  main ();
  [%expect {| 4613732 |}]
;;

let%bench "Fib" = fib 30
let%bench "002 main" = main ()
