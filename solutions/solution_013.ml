open! Core
open! Import
open! Async

let bignum () = Get_data.get_problem_data_string 13

let main bignum =
  String.split_lines bignum
  |> List.sum (module Bigint) ~f:Bigint.of_string
  |> Bigint.to_string
  |> String.subo ~len:10
;;

(* This does not work, big_int is not implemented? *)
(* Error msg: "No implementations provided for the following modules: Big_int" *)
(* let main bignum =
  String.split_lines bignum
  |> fun l ->
  List.fold l ~init:Big_int.zero_big_int ~f:(fun x y ->
    Big_int.add_big_int (Big_int.big_int_of_string y) x)
  |> Big_int.string_of_big_int
  |> String.subo ~len:10
  |> print_endline
;; *)

let%expect_test "Bignum" =
  let%bind numbers = bignum () in
  main numbers |> print_endline;
  [%expect {| 5537376230  |}];
  return ()
;;

let%bench_fun "Large sum" =
 fun () ->
  Thread_safe.block_on_async_exn (fun () ->
    let%bind numbers = Get_data.get_problem_data_string 13 in
    let _ = main numbers in
    return ())
;;
