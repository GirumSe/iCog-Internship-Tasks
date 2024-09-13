 ;; map: Applies a given function to each element in the list.
(: map (-> (Atom -> Atom) List List))
(= (map $f Nil) Nil) ;; Base case: Empty list.
(= (map $f (:: $x $xs)) (:: ($f $x) (map $f $xs))) ;; Recursive case: Apply the function to the head and continue with the tail.

 ;; Test map
(= (increment $x) (+ $x 1))
! (map increment (:: 1 (:: 2 (:: 3 Nil)))) ; Result: (:: 2 (:: 3 (:: 4 Nil)))
