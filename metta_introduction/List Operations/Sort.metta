 ;; insertion-sort: Recursively sorts the list by inserting elements in the correct position.
(: insertion-sort (-> List List))
(= (insertion-sort Nil) Nil)
(= (insertion-sort (:: $x $xs)) (insert-sorted $x (insertion-sort $xs)))

 ;; insertion-sort helper function: Inserts an element into a sorted list at the correct position.
(: insert-sorted (-> Atom List List))
(= (insert-sorted $x Nil) (:: $x Nil))
(= (insert-sorted $x (:: $y $ys)) (if (< $x $y) (:: $x (:: $y $ys)) (:: $y (insert-sorted $x $ys))))

 ;; Test insertion-sort
! (insertion-sort (:: 2 (:: 1 (:: 4 (:: 5 (:: 3 Nil)))))) ; Result: (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 Nil)))))
