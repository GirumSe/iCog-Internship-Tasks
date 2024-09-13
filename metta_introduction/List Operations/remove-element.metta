 ;; remove-element: Removes all occurrences of a given element from the list.
(: remove-element (-> List Atom List))
(= (remove-element Nil $target) Nil) ;; Base case: Empty list, nothing to remove.
(= (remove-element (:: $x $xs) $target)
    (if (== $x $target)
        (remove-element $xs $target) ;; Skip the element if it matches the target.
        (:: $x (remove-element $xs $target)))) ;; Otherwise, keep the element.

 ;; Test remove-element
! (remove-element (:: 1 (:: 2 (:: 3 (:: 2 (:: 4 Nil))))) 2) ; Result: (:: 1 (:: 3 (:: 4 Nil)))
! (remove-element (:: A (:: B (:: A (:: C Nil)))) A) ; Result: (:: B (:: C Nil))
