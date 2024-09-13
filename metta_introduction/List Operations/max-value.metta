 ;; max-value: Recursively finds the maximum value in a list.
(: max-value (-> List Int))
(= (max-value Nil) Error)
(= (max-value (:: $x Nil)) $x)
(= (max-value (:: $x $xs)) (if (> $x (max-value $xs)) $x (max-value $xs)))

 ;; Test max-value
! (max-value (:: 1 (:: 3 (:: 5 (:: 2 (:: -4 Nil)))))) ; Result: 5
! (max-value (:: -1 (:: 0 (:: 1 (:: 2 (:: 3 Nil)))))) ; Result: 3
