 ;; remove-duplicate: Removes all duplicate elements from the list.
(: remove-duplicate (-> List List))
(= (remove-duplicate Nil) Nil)
(= (remove-duplicate (:: $x $xs)) (if (is-member $x $xs) (remove-duplicate $xs) (:: $x (remove-duplicate $xs))))

 ;; Test remove-duplicate
! (remove-duplicate (:: 1 (:: 2 (:: 2 (:: 3 (:: 1 Nil)))))) ; Result: (:: 2 (:: 3 (:: 1 Nil)))
! (remove-duplicate (:: A (:: A (:: B (:: C (:: C Nil)))))) ; Result: (:: A (:: B (:: C Nil)))
