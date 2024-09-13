 ;; reverse: Reverses the order of elements in the list.
(: reverse (-> List List))
(= (reverse Nil) Nil) ;; Base case: Empty list.
(= (reverse (:: $x $xs)) (append (reverse $xs) (:: $x Nil))) ;; Recursive case: Append the head to the reversed tail.

 ;; Test reverse
! (reverse (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 Nil)))))) ; Result: (:: 5 (:: 4 (:: 3 (:: 2 (:: 1 Nil)))))
! (reverse (:: A (:: B (:: C Nil)))) ; Result: (:: C (:: B (:: A Nil)))
