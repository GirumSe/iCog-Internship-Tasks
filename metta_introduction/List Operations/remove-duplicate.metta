 ;; remove-duplicate: Removes duplicate elements from the list, leaving only unique elements.
(: remove-duplicate (-> List List))
(= (remove-duplicate Nil) Nil) ;; Base case: Empty list.
(= (remove-duplicate (:: $x $xs))
    (if (is-member $x $xs)
        (remove-duplicate $xs) ;; Skip the element if it's already present in the rest of the list.
        (:: $x (remove-duplicate $xs)))) ;; Otherwise, keep the element.

 ;; Test remove-duplicate
! (remove-duplicate (:: 1 (:: 2 (:: 2 (:: 3 (:: 1 Nil)))))) ; Result: (:: 2 (:: 3 (:: 1 Nil)))
! (remove-duplicate (:: A (:: A (:: B (:: C (:: C Nil)))))) ; Result: (:: A (:: B (:: C Nil)))
