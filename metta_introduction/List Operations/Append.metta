 ;; append: Concatenates two lists by adding elements from the first list to the front of the second.
(: append (-> List List List))
(= (append Nil $ys) $ys) ;; Base case: If the first list is empty, return the second list.
(= (append (:: $x $xs) $ys) (:: $x (append $xs $ys))) ;; Recursive case: Prepend the first element to the result of appending the rest.

 ;; Test append
! (append (:: A (:: B (:: C Nil))) (:: D (:: E (:: F (:: G Nil))))) ; Result: (:: A (:: B (:: C (:: D (:: E (:: F (:: G Nil)))))))
! (append (:: 1 (:: 2 (:: 3 Nil))) (:: 4 (:: 5 (:: 6 Nil)))) ; Result: (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 (:: 6 Nil))))))
