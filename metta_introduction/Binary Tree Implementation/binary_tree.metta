 ;; Binary tree structure
(: Tree (-> Atom Tree Tree Tree))
(: Leaf (-> Tree))

(= (Leaf) Nil)

 ;; Insert element in a binary search tree (BST)
(: insert-bst (-> Atom Tree Tree))
(= (insert-bst $value Nil) (Tree $value (Leaf) (Leaf)))
(= (insert-bst $value (Tree $node-value $left $right))
    (if (< $value $node-value)
        (Tree $node-value (insert-bst $value $left) $right)
        (Tree $node-value $left (insert-bst $value $right))))

 ;; Check if an element exists in the tree
(: is-member-bst (-> Atom Tree Bool))
(= (is-member-bst $value Nil) False)
(= (is-member-bst $value (Tree $node-value $left $right))
    (if (== $value $node-value)
        True
        (if (< $value $node-value)
            (is-member-bst $value $left)
            (is-member-bst $value $right))))

 ;; Inorder traversal (Left, Node, Right)
(: inorder (-> Tree List))
(= (inorder Nil) Nil)
(= (inorder (Tree $node-value $left $right))
    (append (inorder $left) (:: $node-value (inorder $right))))

 ;; Test inserting elements
! (insert-bst 5 Nil) ; Result: (Tree 5 (Leaf) (Leaf))
! (insert-bst 3 (insert-bst 5 Nil)) ; Result: (Tree 5 (Tree 3 (Leaf) (Leaf)) (Leaf))
! (insert-bst 7 (insert-bst 5 Nil)) ; Result: (Tree 5 (Leaf) (Tree 7 (Leaf) (Leaf)))

 ;; Test if a value is a member
! (is-member-bst 3 (Tree 5 (Tree 3 (Leaf) (Leaf)) (Tree 7 (Leaf) (Leaf)))) ; Result: True
! (is-member-bst 8 (Tree 5 (Tree 3 (Leaf) (Leaf)) (Tree 7 (Leaf) (Leaf)))) ; Result: False

 ;; Test inorder traversal
! (inorder (insert-bst 3 (insert-bst 7 (insert-bst 5 Nil)))) ; Result: (:: 3 (:: 5 (:: 7 Nil)))
