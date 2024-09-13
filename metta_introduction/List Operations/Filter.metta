 ;; filter: Keeps only the elements of the list that satisfy the given predicate function.
(: filter (-> (Atom -> Bool) List List))
(= (filter $f Nil) Nil) ;; Base case: Empty list.
(= (filter $f (:: $x $xs))
    (if ($f $x)
        (:: $x (filter $f $xs)) ;; Keep the element if it satisfies the predicate.
        (filter $f $xs))) ;; Otherwise, skip it.

 ;; Test filter
(= (greater-than-3 $x) (> $x 3))
! (filter greater-than-3 (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 Nil)))))) ; Result: (:: 4 (:: 5 Nil))
