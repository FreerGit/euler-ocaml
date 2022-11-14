open! Core
open! Import
open! Async

let grid () = Get_data.get_problem_data_grid 11
let grid_of_array grid = Array.of_list (List.map grid ~f:Array.of_list)
let size = 20
let product_size = 4

let horizontal_products grid =
  let open Sequence.Let_syntax in
  let%bind row = Array.to_sequence grid in
  let%map i = Sequence.range ~stop:`inclusive 0 (size - product_size) in
  Sequence.fold
    ~init:1
    ~f:( * )
    (let%map j = Sequence.range i (i + product_size) in
     row.(j))
;;

let vertical_products grid = horizontal_products (Array.transpose_exn grid)

let lr_diagonal_products grid =
  let open Sequence.Let_syntax in
  let indices = Sequence.range ~stop:`inclusive 0 (size - product_size) in
  let%bind i = indices in
  let%map j = indices in
  Sequence.fold
    ~init:1
    ~f:( * )
    (let%map x = Sequence.range 0 product_size in
     grid.(i + x).(j + x))
;;

let rl_diagonal_products grid =
  let grid = Array.copy grid in
  Array.rev_inplace grid;
  lr_diagonal_products grid
;;

let main grid =
  [ horizontal_products grid
  ; vertical_products grid
  ; lr_diagonal_products grid
  ; rl_diagonal_products grid
  ]
  |> Sequence.of_list
  |> Sequence.concat
  |> Sequence.max_elt ~compare:Int.compare
  |> Option.value_exn
;;

let%expect_test "largest product grid" =
  let%bind grid = Get_data.get_problem_data_grid 11 in
  main grid |> printf "%d\n";
  [%expect {| 70600674  |}];
  return ()
;;

let%bench_fun "largest product" =
 fun () ->
  Thread_safe.block_on_async_exn (fun () ->
    let%bind grid = Get_data.get_problem_data_grid 11 in
    let _ = main grid in
    return ())
;;
