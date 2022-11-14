open! Core

let is_prime n =
  match n = 2 || n = 3 with
  | true -> true
  | false ->
    (match n <= 1 || n % 2 = 0 || n % 3 = 0 with
     | true -> false
     | false ->
       let i = ref 5 in
       let b = ref true in
       while !i * !i <= n do
         match n % !i = 0 || n % (!i + 2) = 0 with
         | true ->
           b := false;
           ignore (i := !i + 6)
         | false -> ignore (i := !i + 6)
       done;
       !b)
;;

let generate_primes n =
  Sequence.unfold_step ~init:(2, n) ~f:(fun (p, n) ->
    match is_prime p with
    | true -> Sequence.Step.Yield (p, (p + 1, n - 1))
    | false -> if n > 0 then Sequence.Step.Skip (p + 1, n) else Sequence.Step.Done)
;;

let generate_primes_upto n =
  Sequence.unfold_step ~init:2 ~f:(fun p ->
    match p < n && is_prime p with
    | true -> Sequence.Step.Yield (p, p + 1)
    | false -> if p - 1 < n then Sequence.Step.Skip (p + 1) else Sequence.Step.Done)
;;
