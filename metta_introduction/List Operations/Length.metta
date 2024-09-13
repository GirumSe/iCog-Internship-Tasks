 ;; length: Recursively counts the number of elements in the list.
(: length (-> List Int))
(= (length Nil) 0)
(= (length (:: $x $xs)) (+ 1 (length $xs)))

 ;; Test length
! (length Nil) ; Result: 0
! (length (:: A (:: B (:: C (:: D (:: E Nil)))))) ; Result: 5
