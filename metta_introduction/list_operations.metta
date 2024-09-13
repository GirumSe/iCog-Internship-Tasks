 ;; Definitions of list operations

 ;; append
(: append (-> List List List))
(= (append Nil $ys) $ys)
(= (append (:: $x $xs) $ys) (:: $x (append $xs $ys)))

 ;; length
(= (length Nil) 0)
(= (length (Cons $x $xs))
    (+ 1 (length $xs)))
 ;; is-member
(: is-member (-> $m (List $m) Bool))
(= (is-member $x Nil) False)
(= (is-member $x (Cons $y $xs)) (if (== $x $y) True (is-member $x $xs)))

 ;; max-value
(= (max-value Nil) Error) ;; Handle empty list case as needed
(= (max-value (Cons $x Nil)) $x)
(= (max-value (Cons $x $xs))
    (if (> $x (max-value $xs))
        $x
        (max-value $xs)))

 ;; min-value
(= (min-value Nil) Error) ;; Handle empty list case as needed
(= (min-value (Cons $x Nil)) $x)
(= (min-value (Cons $x $xs))
    (if (< $x (min-value $xs))
        $x
        (min-value $xs)))

 ;; push
(: push (-> $element $list $list))
(= (push $element $list) (:: $element $list))

 ;; pop
(: pop (-> List List))
(= (pop (:: $x $xs)) $xs)
(= (pop Nil) Nil)

 ;; Remove all occurrences of a specified element from a list
(: remove-element (-> List Atom List))
(= (remove-element Nil $target) Nil)
(= (remove-element (:: $x $xs) $target)
    (if (== $x $target)
        (remove-element $xs $target)
        (:: $x (remove-element $xs $target))))

 ;; remove-duplicate
(: remove-duplicate (-> List List))
(= (remove-duplicate Nil) Nil)
(= (remove-duplicate (Cons $x $xs))
    (if (is-member $x $xs)
        (remove-duplicate $xs)
        (Cons $x (remove-duplicate $xs))))

 ;; map
(: map (-> (-> Element  Element) List List))
(= (map $f Nil) Nil)
(= (map $f (:: $x $xs)) (:: ($f $x) (map $f $xs)))

 ;; filter
(: filter (-> (-> Element  Bool) List List))
(= (filter $f Nil) Nil)
(= (filter $f (:: $x $xs))
    (if ($f $x)
        (:: $x (filter $f $xs))
        (filter $f $xs)))

 ;; reverse
(: reverse (-> List List))
(= (reverse Nil) Nil)
(= (reverse (:: $x $xs)) (append (reverse $xs) (:: $x Nil)))

 ;; foldl
(= (foldl $f $ac Nil) $ac)
(= (foldl $f $ac (:: $n $d)) (foldl $f ($f $ac $n) $d))

 ;; foldr
(= (foldr $f $ac Nil) $ac)
(= (foldr $f $ac (:: $n $d)) ($f $n (foldr $f $ac $d)))

 ;; insertion sort helper function
(: insert-sorted (-> Atom List List))
(= (insert-sorted $x Nil) (:: $x Nil))
(= (insert-sorted $x (:: $y $ys))
    (if (< $x $y)
        (:: $x (:: $y $ys))
        (:: $y (insert-sorted $x $ys))))

 ;; insertion sort
(: insertion-sort (-> List List))
(= (insertion-sort Nil) Nil)
(= (insertion-sort (:: $x $xs)) (insert-sorted $x (insertion-sort $xs)))

 ;; Test Cases

 ;; append
! (append (:: A (:: B (:: C Nil))) (:: D (:: E (:: F (:: G Nil))))) ; Result: (:: A (:: B (:: C (:: D (:: E (:: F (:: G Nil)))))))
! (append (:: 1 (:: 2 (:: 3 Nil))) (:: 4 (:: 5 (:: 6 Nil)))) ; Result: (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 (:: 6 Nil))))))

 ;; length
! (length Nil)
! (length (Cons A (Cons B (Cons C (Cons D (Cons E Nil))))))

 ;; is-member
! (is-member 3 (Cons A (Cons B (Cons C (Cons D (Cons E Nil)))))) ; Result: False
! (is-member 6 (Cons 1 (Cons 2 (Cons 3 (Cons 4 (Cons 5 (Cons 6 (Cons 7 Nil)))))))) ; Result: True

 ;; max-value
! (max-value (Cons 1 (Cons 3 (Cons 5 (Cons 2 (Cons -4 Nil)))))) ; Result: 5
! (max-value (Cons -1 (Cons 0 (Cons 1 (Cons 2 (Cons 3 Nil)))))) ; Result: 3

 ;; min-value
! (min-value (Cons 1 (Cons 3 (Cons 5 (Cons 2 (Cons 4 Nil)))))) ; Result: 1
! (min-value (Cons -1 (Cons 0 (Cons 1 (Cons 2 (Cons 3 Nil)))))) ; Result: -1

 ;; push
! (push A Nil) ; Result: (:: A Nil)
! (push 1 (:: 2 (:: 3 Nil))) ; Result: (:: 1 (:: 2 (:: 3 Nil)))
 ;; pop
! (pop (:: A (:: B (:: C Nil)))) ; Result: (:: B (:: C Nil))
! (pop (:: 1 (:: 2 (:: 3 Nil)))) ; Result: (:: 2 (:: 3 Nil))

 ;; remove-element
! (remove-element (:: 1 (:: 2 (:: 3 (:: 2 (:: 4 Nil))))) 2) ; Result: (:: 1 (:: 3 (:: 4 Nil)))
! (remove-element (:: A (:: B (:: A (:: C Nil)))) A) ; Result: (:: B (:: C Nil))

 ;; remove-duplicate
! (remove-duplicate (Cons 1 (Cons 2 (Cons 2 (Cons 3 (Cons 1 Nil)))))) ; Result: (Cons 2 (Cons 3 (Cons 1 Nil)))
! (remove-duplicate (Cons A (Cons A (Cons B (Cons C (Cons C Nil)))))) ; Result: (:: A (:: B (:: C Nil)))

 ;; map
(= (increment $x) (+ $x 1))
! (map increment (:: 1 (:: 2 (:: 3 Nil)))) ; Result: (:: 2 (:: 3 (:: 4 Nil)))

 ;; filter
(= (greater-than-3 $x) (> $x 3))
! (filter greater-than-3 (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 Nil)))))) ; Result: (:: 4 (:: 5 Nil))

 ;; reverse
! (reverse (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 Nil)))))) ; Result: (:: 5 (:: 4 (:: 3 (:: 2 (:: 1 Nil)))))
! (reverse (:: A (:: B (:: C Nil)))) ; Result: (:: C (:: B (:: A Nil)))

 ;; sort
! (insertion-sort (:: 2 (:: 1 (:: 4 (:: 5 (:: 3 Nil)))))) ; Result: (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 Nil)))))

 ;; Define the sum function
(= (sum $x $y) (+ $x $y))

 ;; Test foldl with sum
! (foldl sum 0 (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 Nil)))))) ;; Expected output: 15

 ;; Test foldr with sum
! (foldr sum 1 (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 Nil))))))