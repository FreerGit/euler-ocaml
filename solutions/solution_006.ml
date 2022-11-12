open! Core


let first_hundred = Iter.int_range ~start:1 ~stop:100

let first_ten = Iter.int_range ~start:1 ~stop:10

let sum_of_squares iter = Iter.map (fun x -> Int.pow x 2) iter |> Iter.sum

let square_of_sums iter = Iter.sum iter |> fun x -> Int.pow x 2  

let difference iter = square_of_sums iter - sum_of_squares iter

let%test_unit "sum of squares" = [%test_result: int] (sum_of_squares first_ten) ~expect:385

let%test_unit "square of sums" = [%test_result: int] (square_of_sums first_ten) ~expect:3025

let%test_unit "difference (ten)" = [%test_result: int] (difference first_ten) ~expect:2640

let%test_unit "difference (hundred)" = [%test_result: int] (difference first_hundred) ~expect:25164150

let%bench "difference (hundred)" = difference first_hundred


