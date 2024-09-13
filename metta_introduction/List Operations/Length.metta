 ;; length: Counts the number of elements in the list.
(: length (-> List Int))
(= (length Nil) 0) ;; Base case: Empty list has a length of 0.
(= (length (:: $x $xs)) (+ 1 (length $xs))) ;; Recursive case: Add 1 for the current element and continue with the rest of the list.

 ;; Test length
! (length Nil) ; Result: 0
! (length (:: A (:: B (:: C (:: D (:: E Nil)))))) ; Result: 5
