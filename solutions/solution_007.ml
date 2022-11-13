open! Core
open! Import

let is_prime n =
  Iter.int_range ~start:2 ~stop:(n - 1) |> Iter.exists (fun i -> n % i = 0) |> not
;;

let generate_primes n =
  Sequence.unfold_step ~init:(2, n) ~f:(fun (p, n) ->
    match is_prime p with
    | true -> Sequence.Step.Yield (p, (p + 1, n - 1))
    | false -> if n > 0 then Sequence.Step.Skip (p + 1, n) else Sequence.Step.Done)
;;

let find_prime n = Sequence.nth_exn (generate_primes n) (n - 1)
let find_prime' n = Sequence.nth_exn (Primes.generate_primes n) (n - 1)

(* is_prime *)
let%test_unit "prime" = [%test_result: bool] (is_prime 13) ~expect:true
let%test_unit "prime" = [%test_result: bool] (is_prime 1181) ~expect:true
let%test_unit "NOT prime" = [%test_result: bool] (is_prime 6) ~expect:false
let%test_unit "NOT prime" = [%test_result: bool] (is_prime 8888) ~expect:false
(* is_prime' *)
let%test_unit "prime" = [%test_result: bool] (Primes.is_prime 13) ~expect:true
let%test_unit "prime" = [%test_result: bool] (Primes.is_prime 104743) ~expect:true
let%test_unit "NOT prime" = [%test_result: bool] (Primes.is_prime 6) ~expect:false
let%test_unit "NOT prime" = [%test_result: bool] (Primes.is_prime 8888) ~expect:false

(* This could of course be a test_unit but good ot practice both, and ~f becomes long. *)

let%expect_test "test" =
  find_prime 10_001 |> printf "%d\n";
  [%expect {| 104743 |}]
;;

let%expect_test "test" =
  find_prime' 10_001 |> printf "%d\n";
  [%expect {| 104743 |}]
;;

(* like 50x slower.... *)
(* let%bench "10_001st prime" = find_prime 10_001 *)

let%bench "10_001st prime (6k+i)" = find_prime' 10_001
