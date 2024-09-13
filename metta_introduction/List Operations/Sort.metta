 ;; insert-sorted: Inserts an element into a sorted list in the correct position.
(: insert-sorted (-> Atom List List))
(= (insert-sorted $x Nil) (:: $x Nil)) ;; Base case: Insert into an empty list.
(= (insert-sorted $x (:: $y $ys))
    (if (< $x $y)
        (:: $x (:: $y $ys)) ;; Insert before the first larger element.
        (:: $y (insert-sorted $x $ys)))) ;; Otherwise, continue inserting into the tail.

 ;; insertion-sort: Sorts a list by recursively inserting elements into their correct position.
(: insertion-sort (-> List List))
(= (insertion-sort Nil) Nil) ;; Base case: Empty list.
(= (insertion-sort (:: $x $xs)) (insert-sorted $x (insertion-sort $xs))) ;; Recursive case: Insert the head into the sorted tail.

 ;; Test insertion-sort
! (insertion-sort (:: 2 (:: 1 (:: 4 (:: 5 (:: 3 Nil)))))) ; Result: (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 Nil)))))
