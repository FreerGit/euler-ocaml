open! Core

let gen_triangle_number n =
  Sequence.unfold ~init:(1, n) ~f:(fun (t, n) ->
    match n = 0 with
    | true -> None
    | false -> Some (t * (t + 1) / 2, (t + 1, n - 1)))
;;

let divisors n =
  let upto = sqrt (float n) |> Float.round_up |> Float.to_int in
  let divisor = ref 2 in
  let num_divisors = ref 0 in
  while !divisor < upto do
    if n % !divisor = 0 then num_divisors := !num_divisors + 2;
    divisor := !divisor + 1
  done;
  !num_divisors
;;

let main () =
  gen_triangle_number 100000000
  |> fun x ->
  Sequence.find x ~f:(fun n -> divisors n |> Int.( < ) 500) |> Option.value_exn
;;

let%expect_test "divisors of tria. num" =
  main () |> printf "%d\n";
  [%expect {| 76576500 |}]
;;

let%bench "divisors of tria. num" = main ()
