open! Core
open! Core_unix
open! Async

(* Certianly this can be done synchronously but good training *)
(*  (inline_tests (deps (glob_files ../data/* ) to add data folder in build step  *)
let get_problem_data prob =
  let file = [%string "data/problem_%{prob#Int}.txt"] in
  let%bind _ = Async.Unix.chdir ".." in
  let%bind contents = Async.Reader.file_contents file in
  return contents
;;
