 ;; push: Adds an element to the front of the list.
(: push (-> Atom List List))
(= (push $element $list) (:: $element $list))

 ;; Test push
! (push A Nil) ; Result: (:: A Nil)
! (push 1 (:: 2 (:: 3 Nil))) ; Result: (:: 1 (:: 2 (:: 3 Nil)))
