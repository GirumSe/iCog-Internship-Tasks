 ;; foldl: Applies a function from left to right, accumulating a result.
(: foldl (-> (Atom -> Atom -> Atom) Atom List Atom))
(= (foldl $f $ac Nil) $ac)
(= (foldl $f $ac (:: $n $d)) (foldl $f ($f $ac $n) $d))

 ;; Test foldl with sum
(= (sum $x $y) (+ $x $y))
! (foldl sum 0 (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 Nil)))))) ; Result: 15
