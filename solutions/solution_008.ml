open! Core
open! Import
open! Async

let thousand_digits = Get_data.get_problem_data 8

let split_13 str =
  Iter.int_range ~start:0 ~stop:(String.length str - 13)
  |> Iter.map (fun i ->
       String.sub str ~pos:i ~len:13
       |> Iter.of_str
       |> Iter.map Char.get_digit_exn
       |> Iter.fold ( * ) 1)
  |> Iter.max
  |> Option.value_exn
;;

let largest_product () =
  let%bind str = thousand_digits in
  return (split_13 str)
;;

let%expect_test "largest product" =
  let%bind v = thousand_digits in
  String.length v |> printf "%d\n";
  [%expect {| 1000 |}];
  return ()
;;

let%expect_test "largest product" =
  let%bind v = largest_product () in
  printf "%d\n" v;
  [%expect {| 23514624000 |}];
  return ()
;;

let%bench_fun "largest product" =
 fun () -> Thread_safe.block_on_async_exn (fun () -> largest_product ())
;;
