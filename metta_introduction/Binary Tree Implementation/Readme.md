# Binary Tree Implementation in MeTTa

The code includes basic operations such as inserting elements into the tree, checking if an element exists, and traversing the tree in in-order.

## Data Structure

### `Tree`
Represents a binary tree node containing:
- A value (Atom)
- A left subtree (Tree)
- A right subtree (Tree)

### `Leaf`
Represents an empty node (leaf) in the tree.

### Definitions
- **Tree**: Holds a value and two child trees (left and right).
- **Leaf**: Acts as a terminator for the tree branches (equivalent to `Nil`).

## Operations

### 1. Insert Element in BST
**Function**: `insert-bst`

- **Signature**: `(-> Atom Tree Tree)`
- **Description**: Inserts an element (`$value`) into the appropriate position in the binary search tree (BST). If the value is less than the current node, it is inserted into the left subtree; otherwise, into the right subtree.

```metta
(: insert-bst (-> Atom Tree Tree))
(= (insert-bst $value Nil) (Tree $value (Leaf) (Leaf)))
(= (insert-bst $value (Tree $node-value $left $right))
    (if (< $value $node-value)
        (Tree $node-value (insert-bst $value $left) $right)
        (Tree $node-value $left (insert-bst $value $right))))
```

### 2. Check if Element Exists in the Tree
**Function**: `is-member-bst`

- **Signature**: `(-> Atom Tree Bool)`
- **Description**: Checks whether a given value exists in the BST. It traverses the tree, moving left if the value is less than the current node and right if it is greater, until it finds the value or reaches a leaf.

```metta
(: is-member-bst (-> Atom Tree Bool))
(= (is-member-bst $value Nil) False)
(= (is-member-bst $value (Tree $node-value $left $right))
    (if (== $value $node-value)
        True
        (if (< $value $node-value)
            (is-member-bst $value $left)
            (is-member-bst $value $right))))
```

### 3. Inorder Traversal
**Function**: `inorder`

- **Signature**: `(-> Tree List)`
- **Description**: Performs an in-order traversal of the BST, returning a list of the elements in ascending order. It processes the left subtree first, then the node value, and finally the right subtree.

```metta
(: inorder (-> Tree List))
(= (inorder Nil) Nil)
(= (inorder (Tree $node-value $left $right))
    (append (inorder $left) (:: $node-value (inorder $right))))
```

## Test Cases

### Insert Elements into BST
Inserting elements into the tree:

```metta
! (insert-bst 5 Nil) 
;; Result: (Tree 5 (Leaf) (Leaf))

! (insert-bst 3 (insert-bst 5 Nil)) 
;; Result: (Tree 5 (Tree 3 (Leaf) (Leaf)) (Leaf))

! (insert-bst 7 (insert-bst 5 Nil)) 
;; Result: (Tree 5 (Leaf) (Tree 7 (Leaf) (Leaf)))
```

### Check if Element is a Member
Check if certain values exist in the tree:

```metta
! (is-member-bst 3 (Tree 5 (Tree 3 (Leaf) (Leaf)) (Tree 7 (Leaf) (Leaf)))) 
;; Result: True

! (is-member-bst 8 (Tree 5 (Tree 3 (Leaf) (Leaf)) (Tree 7 (Leaf) (Leaf)))) 
;; Result: False
```

### Inorder Traversal
Perform an inorder traversal to get a sorted list of values:

```metta
! (inorder (insert-bst 3 (insert-bst 7 (insert-bst 5 Nil)))) 
;; Result: (:: 3 (:: 5 (:: 7 Nil)))
```
---

This implementation demonstrates the basic operations of a binary search tree in MeTTa, including inserting elements, checking membership, and traversing the tree. You can build upon these functions to implement additional tree operations, such as deletion or balancing.

