 ;; foldr: Applies a function from right to left, accumulating a result.
(: foldr (-> (Atom -> Atom -> Atom) Atom List Atom))
(= (foldr $f $ac Nil) $ac)
(= (foldr $f $ac (:: $n $d)) ($f $n (foldr $f $ac $d)))

 ;; Test foldr with sum
(= (sum $x $y) (+ $x $y))
! (foldr sum 1 (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 Nil)))))) ; Result: 16
