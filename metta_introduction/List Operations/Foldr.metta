 ;; foldr: Accumulates a result from right to left using the given function and initial value.
(: foldr (-> (Atom -> Atom -> Atom) Atom List Atom))
(= (foldr $f $ac Nil) $ac) ;; Base case: Return the accumulator when the list is empty.
(= (foldr $f $ac (:: $n $d)) ($f $n (foldr $f $ac $d))) ;; Recursive case: Apply the function to the head and the result of folding the tail.

 ;; Test foldr with sum
(= (sum $x $y) (+ $x $y))
! (foldr sum 1 (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 Nil)))))) ; Result: 16
