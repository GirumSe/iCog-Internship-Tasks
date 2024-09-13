 ;; is-member: Checks if an element exists in the list.
(: is-member (-> Atom List Bool))
(= (is-member $x Nil) False) ;; Base case: Element is not in an empty list.
(= (is-member $x (:: $y $xs)) (if (== $x $y) True (is-member $x $xs))) ;; Recursive case: Check if the first element matches, otherwise continue searching.

 ;; Test is-member
! (is-member 3 (:: A (:: B (:: C (:: D (:: E Nil)))))) ; Result: False
! (is-member 6 (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 (:: 6 (:: 7 Nil)))))))) ; Result: True
