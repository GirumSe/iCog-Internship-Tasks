 ;; min-value: Recursively finds the minimum value in a list.
(: min-value (-> List Int))
(= (min-value Nil) Error)
(= (min-value (:: $x Nil)) $x)
(= (min-value (:: $x $xs)) (if (< $x (min-value $xs)) $x (min-value $xs)))

 ;; Test min-value
! (min-value (:: 1 (:: 3 (:: 5 (:: 2 (:: 4 Nil)))))) ; Result: 1
! (min-value (:: -1 (:: 0 (:: 1 (:: 2 (:: 3 Nil)))))) ; Result: -1
