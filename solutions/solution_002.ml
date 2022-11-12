open! Core

let rec fib n =
  match n with
  | 0 -> 0
  | 1 -> 1
  | _ -> fib (n - 1) + fib (n - 2)
;;

let main () =
  List.init 34 ~f:fib
  |> List.filter ~f:(fun x -> x % 2 = 0 && x < 4_000_000)
  |> List.sum (module Int) ~f:Fn.id
;;

let%test_unit "answer" = [%test_result: int] (main ()) ~expect:4613732
let%bench "Fibbonacci" = fib 30
let%bench "Even Fibonacci numbers" = main ()
