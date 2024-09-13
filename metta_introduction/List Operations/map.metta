 ;; map: Applies a function to every element of the list, returning a new list with the results.
(: map (-> (Atom -> Atom) List List))
(= (map $f Nil) Nil)
(= (map $f (:: $x $xs)) (:: ($f $x) (map $f $xs)))

 ;; Test map
(= (increment $x) (+ $x 1))
! (map increment (:: 1 (:: 2 (:: 3 Nil)))) ; Result: (:: 2 (:: 3 (:: 4 Nil)))
