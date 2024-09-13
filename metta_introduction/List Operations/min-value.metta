 ;; min-value: Finds the minimum element in the list.
(: min-value (-> List Int))
(= (min-value Nil) Error) ;; Base case: No min value in an empty list, return Error.
(= (min-value (:: $x Nil)) $x) ;; Base case: Single element list, return that element.
(= (min-value (:: $x $xs)) (if (< $x (min-value $xs)) $x (min-value $xs))) ;; Recursive case: Compare the first element with the min of the rest of the list.

 ;; Test min-value
! (min-value (:: 1 (:: 3 (:: 5 (:: 2 (:: 4 Nil)))))) ; Result: 1
! (min-value (:: -1 (:: 0 (:: 1 (:: 2 (:: 3 Nil)))))) ; Result: -1
