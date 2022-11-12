open! Core

let is_palindrome digits = String.( = ) digits (String.rev digits)

let largest_palindrome () =
  let ans = ref 0 in
  for a = 100 to 999 do
    for b = 100 to 999 do
      let digits = [%string "%{a * b #Int}"] in
      (* Short circuit here with && cuts the allocations in half*)
      if a * b > !ans && is_palindrome digits then ans := a * b
    done
  done;
  !ans
;;

let%test_unit "largest palindrome" =
  [%test_result: int] (largest_palindrome ()) ~expect:906609
;;

let%bench "largest palindrome" = largest_palindrome ()
