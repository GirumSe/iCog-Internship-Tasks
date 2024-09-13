 ;; pop: Removes the first element from the list and returns the rest.
(: pop (-> List List))
(= (pop (:: $x $xs)) $xs)
(= (pop Nil) Nil)

 ;; Test pop
! (pop (:: A (:: B (:: C Nil)))) ; Result: (:: B (:: C Nil))
! (pop (:: 1 (:: 2 (:: 3 Nil)))) ; Result: (:: 2 (:: 3 Nil))
