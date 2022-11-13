open! Core

let is_pythagorean a b c = (a * a) + (b * b) = c * c

let main () =
  with_return_option (fun r ->
    for c = 3 to 999 do
      for b = 2 to c - 1 do
        let a = 1000 - b - c in
        if is_pythagorean a b c then r.return (a * b * c)
      done
    done)
  |> Option.value_exn
;;

let%test_unit "special pyth. triplet" = [%test_result: int] (main ()) ~expect:31875000
let%bench "special pyth. triplet" = main ()
