 ;; append: Combines two lists by adding all elements of the second list to the end of the first list.
(: append (-> List List List))
(= (append Nil $ys) $ys)
(= (append (:: $x $xs) $ys) (:: $x (append $xs $ys)))

 ;; Test append
! (append (:: A (:: B (:: C Nil))) (:: D (:: E (:: F (:: G Nil))))) ; Result: (:: A (:: B (:: C (:: D (:: E (:: F (:: G Nil)))))))
! (append (:: 1 (:: 2 (:: 3 Nil))) (:: 4 (:: 5 (:: 6 Nil)))) ; Result: (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 (:: 6 Nil))))))
