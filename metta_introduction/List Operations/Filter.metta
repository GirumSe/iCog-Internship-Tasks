 ;; filter: Returns a new list containing only the elements that satisfy a predicate function.
(: filter (-> (Atom -> Bool) List List))
(= (filter $f Nil) Nil)
(= (filter $f (:: $x $xs)) (if ($f $x) (:: $x (filter $f $xs)) (filter $f $xs)))

 ;; Test filter
(= (greater-than-3 $x) (> $x 3))
! (filter greater-than-3 (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 Nil)))))) ; Result: (:: 4 (:: 5 Nil))
