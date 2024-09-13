 ;; is-member: Checks whether a given element exists in the list.
(: is-member (-> Atom List Bool))
(= (is-member $x Nil) False)
(= (is-member $x (:: $y $xs)) (if (== $x $y) True (is-member $x $xs)))

 ;; Test is-member
! (is-member 3 (:: A (:: B (:: C (:: D (:: E Nil)))))) ; Result: False
! (is-member 6 (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 (:: 6 (:: 7 Nil)))))))) ; Result: True
