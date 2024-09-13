 ;; pop: Removes the first element from the list.
(: pop (-> List List))
(= (pop (:: $x $xs)) $xs) ;; Removes the head and returns the tail of the list.
(= (pop Nil) Nil) ;; Base case: Return Nil if the list is already empty.

 ;; Test pop
! (pop (:: A (:: B (:: C Nil)))) ; Result: (:: B (:: C Nil))
! (pop (:: 1 (:: 2 (:: 3 Nil)))) ; Result: (:: 2 (:: 3 Nil))
