open! Core
open! Core_unix
open! Async

(* Certianly this can be done synchronously but good training *)
(*  (inline_tests (deps (glob_files ../data/* ) to add data folder in build step  *)
let get_problem_data_string prob =
  let file = [%string "problem_%{prob#Int}.txt"] in
  let%bind _ = Async.Unix.chdir "../data" in
  let%bind contents = Async.Reader.file_contents file in
  return contents
;;

let get_problem_data_grid prob =
  let file = [%string "problem_%{prob#Int}.txt"] in
  let%bind _ = Async.Unix.chdir "../data" in
  let%bind contents = Async.Reader.file_contents file in
  String.split_lines contents
  |> Array.of_list_map ~f:(fun line ->
       String.split line ~on:' ' |> Array.of_list_map ~f:int_of_string)
  |> return
;;
