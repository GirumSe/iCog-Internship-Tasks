 ;; foldl: Accumulates a result from left to right using the given function and initial value.
(: foldl (-> (Atom -> Atom -> Atom) Atom List Atom))
(= (foldl $f $ac Nil) $ac) ;; Base case: Return the accumulator when the list is empty.
(= (foldl $f $ac (:: $n $d)) (foldl $f ($f $ac $n) $d)) ;; Recursive case: Apply the function to the accumulator and the head.

 ;; Test foldl with sum
(= (sum $x $y) (+ $x $y))
! (foldl sum 0 (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 Nil)))))) ; Result: 15
