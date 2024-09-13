 ;; remove-element: Removes all occurrences of the specified element from the list.
(: remove-element (-> List Atom List))
(= (remove-element Nil $target) Nil)
(= (remove-element (:: $x $xs) $target) (if (== $x $target) (remove-element $xs $target) (:: $x (remove-element $xs $target))))

 ;; Test remove-element
! (remove-element (:: 1 (:: 2 (:: 3 (:: 2 (:: 4 Nil))))) 2) ; Result: (:: 1 (:: 3 (:: 4 Nil)))
! (remove-element (:: A (:: B (:: A (:: C Nil)))) A) ; Result: (:: B (:: C Nil))
