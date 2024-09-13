 ;; max-value: Finds the maximum element in the list.
(: max-value (-> List Int))
(= (max-value Nil) Error) ;; Base case: No max value in an empty list, return Error.
(= (max-value (:: $x Nil)) $x) ;; Base case: Single element list, return that element.
(= (max-value (:: $x $xs)) (if (> $x (max-value $xs)) $x (max-value $xs))) ;; Recursive case: Compare the first element with the max of the rest of the list.

 ;; Test max-value
! (max-value (:: 1 (:: 3 (:: 5 (:: 2 (:: -4 Nil)))))) ; Result: 5
! (max-value (:: -1 (:: 0 (:: 1 (:: 2 (:: 3 Nil)))))) ; Result: 3
