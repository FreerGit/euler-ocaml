open! Core

let is_palindrome (digits : string) = String.( = ) digits (String.rev digits)

let largest_palindrome =
  let ans = ref 0 in
  for a = 100 to 999 do
    for b = 100 to 999 do
      let digits = [%string "%{a * b #Int}"] in
      if is_palindrome digits && a * b > !ans then ans := a * b
    done
  done;
  !ans
;;

let%test_unit "largest palindrome" = [%test_result: int] largest_palindrome ~expect:906609
let%bench "largest palindrome" = largest_palindrome
