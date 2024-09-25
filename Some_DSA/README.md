# DSA Excerises Solution
This document presents solutions to a series of practice tasks aimed at enhancing knowledge of **Data Structures and Algorithms** (DSA). The problems are classified into various sections, each focusing on specific DSA concepts, such as **Tree Traversals**, **Depth-First Search (DFS)**, **Breadth-First Search (BFS)**, and more. 

Each solution is developed according to the following guidelines:

1. **Explanation of Approach**: A detailed explanation is provided for each solution, outlining the chosen strategy, the data structures involved, and the algorithmic approach.

2. **Time and Space Complexity**: An analysis of both **time complexity** and **space complexity** is included to assess the efficiency and scalability of the solution.

3. **Code Quality and Correctness**: The code is written to be clean, readable, and efficient, ensuring correctness through handling of edge cases and thorough testing.

4. **Reasoning Behind the Approach**: Each approach is justified, with reasoning provided for choosing specific algorithms or methods, highlighting performance trade-offs where applicable.

5. **Algorithmic Techniques**: Various techniques, such as **Graph Traversal (BFS/DFS)**, **Tree Manipulation**, and **Dynamic Programming**, are employed to tackle a diverse set of problems.

The solutions in this document are structured for clarity and coherence, making it easy to follow the thought process behind each approach. Each problem has been addressed with a focus on correctness and optimal performance.

we addressed 2 questions from each section.

---

## Pre-Order Traversal
### Question 2:Tree to Sequential Structure Conversion (4 pts)
- Transform a given binary tree into a sequential structure where each node's right pointer
indicates the next element in the sequence, and the left pointer is always null. Perform
this transformation in-place.

- Hint: Utilize a pre-order traversal strategy and keep track of the previously processed
node.

Example 1:

- Input: root = [1,2,5,3,4,null,6]
- Output: [1,null,2,null,3,null,4,null,5,null,6]

Example 2:
- Input: root = []
- Output: []

Example 3:
- Input: root = [0]
- Output: [0]

Constraints:
- The number of nodes in the tree is in the range [0, 2000].
-  -100 <= Node.val <= 100

**Solution**

#### Approach:
We will perform the following steps:
1. Use a **pre-order traversal** to visit each node.
2. For each visited node:
   - Set its left pointer to `null`.
   - Adjust its right pointer to point to the next node in the pre-order traversal sequence.
3. We'll keep track of the previously visited node to help link the current node properly.
4. This will be done **in-place** without using additional data structures except for some temporary variables.

#### Time Complexity:
- The time complexity of this approach is **O(n)**, where `n` is the number of nodes in the tree, since we need to visit each node exactly once during the traversal.
  
#### Space Complexity:
- The space complexity is **O(h)**, where `h` is the height of the tree due to the recursion stack in pre-order traversal.

#### Code Solution:

```python
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def flatten(root: TreeNode) -> None:
    if not root:
        return

    # Initialize previous node as None
    prev = None
    
    # Pre-order traversal function
    def preorder(node: TreeNode):
        nonlocal prev
        if not node:
            return
        
        # If there was a previously visited node, adjust its right pointer
        if prev:
            prev.right = node
            prev.left = None
        
        # Move the 'prev' pointer to the current node
        prev = node
        
        # Temporarily store the right child to process it after the left subtree
        right = node.right
        
        # Recursively flatten the left subtree
        preorder(node.left)
        
        # Recursively flatten the right subtree
        preorder(right)

    # Start the pre-order traversal
    preorder(root)
```


### Question 3: Tree Reconstruction from Traversal Sequences (5 pts)
- You are provided with two integer sequences representing the preorder and in-order
traversals of a binary tree. Your task is to reconstruct and return the original binary tree
structure.
- Hint: Begin with the first pre-order element as the root, then recursively build the left and
right subtrees.

Example 1:
- Input: preorder = [3,9,20,15,7], inorder = [9,3,15,20,7]
- Output: [3,9,20,null,null,15,7]

Example 2:
- Input: preorder = [-1], inorder = [-1]
- Output: [-1]

Constraints:
- 1 <= preorder.length <= 3000
- inorder.length == preorder.length
- -3000 <= pre order[i], inorder[i] <= 3000
- preorder and inorder consist of unique values.
- Each value of inorder also appears in preorder.
- preorder is guaranteed to be the preorder traversal of the tree.
- inorder is guaranteed to be the inorder traversal of the tree.

**Solution**
#### Approach:
1. **Preorder** traversal provides the root of the tree first. Therefore, the first element of the preorder sequence is the root of the tree.
2. **Inorder** traversal gives us information about the left and right subtrees. The elements to the left of the root in the inorder sequence belong to the left subtree, and the elements to the right belong to the right subtree.
3. We will recursively reconstruct the left and right subtrees by splitting the inorder sequence based on the position of the root and adjusting the preorder sequence accordingly.
4. We'll use a helper function to perform the recursive construction.

#### Time Complexity:
- The time complexity of this approach is **O(n)**, where `n` is the number of nodes in the tree. Each node is processed once, and we use hashing for quick lookup of node positions in the inorder sequence.

#### Space Complexity:
- The space complexity is **O(n)** due to the space needed to store the tree nodes and the recursion stack.

#### Code Solution:

```python
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def buildTree(preorder: list[int], inorder: list[int]) -> TreeNode:
    # Hash map to store the index of each node in inorder traversal for O(1) access
    inorder_index_map = {val: idx for idx, val in enumerate(inorder)}

    # Recursive function to build the tree
    def buildTreeRecursive(pre_start, in_start, in_end):
        if pre_start > len(preorder) - 1 or in_start > in_end:
            return None
        
        # The first element of preorder is the root node
        root_val = preorder[pre_start]
        root = TreeNode(root_val)
        
        # Find the root's index in inorder traversal
        in_index = inorder_index_map[root_val]
        
        # Construct left and right subtrees
        root.left = buildTreeRecursive(pre_start + 1, in_start, in_index - 1)
        root.right = buildTreeRecursive(pre_start + (in_index - in_start + 1), in_index + 1, in_end)
        
        return root

    # Build and return the tree
    return buildTreeRecursive(0, 0, len(inorder) - 1)
```

#### Example:
**Input**:  
- `preorder = [3,9,20,15,7]`  
- `inorder = [9,3,15,20,7]`

**Output**:  
The reconstructed tree would be:
```
    3
   / \
  9  20
     /  \
   15    7
```
## Post-Order Traversal

### **Question 2: Delete Leaves with a Given Value (5 pts)**
- You have a tree structure where some leaves need pruning. Remove all leaf nodes with a
specific value, then repeat this process for any nodes that become new leaves due to the
removal. Continue until no more leaves with the target value remain. Your task is to
return the modified tree's root.
- Hint: Use post-order traversal to process children before the parent, allowing you to
identify and remove leaf nodes efficiently.

Example 1:
-  Input: root = [1,2,3,2,null,2,4], target = 2
- Output: [1,null,3,null,4]
- Explanation: Leaf nodes in green with value (target = 2) are removed (Picture in
left). After removing, new nodes become leaf nodes with value (target = 2)
(Picture in center).

**Solution**

#### Approach:
1. We will use **post-order traversal** because it processes children before the parent. This way, we can check if a node’s children are leaves with the target value before deciding whether to delete the node.
2. For each node:
   - Recursively process the left and right children.
   - If both children are `None` (indicating it's a leaf) and the node’s value equals the target value, we delete the node (return `None`).
   - Otherwise, return the node after its children have been processed.
3. This will allow us to remove all target leaves in a single traversal.

#### Time Complexity:
- The time complexity is **O(n)**, where `n` is the number of nodes in the tree since we must visit each node exactly once.

#### Space Complexity:
- The space complexity is **O(h)**, where `h` is the height of the tree due to the recursion stack.

#### Code Solution (Python):

```python
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def removeLeafNodes(root: TreeNode, target: int) -> TreeNode:
    if not root:
        return None
    
    # Recursively process the left and right children
    root.left = removeLeafNodes(root.left, target)
    root.right = removeLeafNodes(root.right, target)
    
    # Check if current node is a leaf with the target value
    if not root.left and not root.right and root.val == target:
        return None
    
    return root
```

#### Example:
**Input**: 
```
root = [1,2,3,2,null,2,4], target = 2
```
**Output**: 
```
[1,null,3,null,4]
```

**Explanation**:
- Initially, the leaf nodes with the value `2` are removed.
- After removing, the tree structure changes, and new leaf nodes with the value `2` are identified and removed in subsequent passes.

---

### **Question 3: Trimming and Forest Creation in Binary Tree (5 pts)**

#### Problem Breakdown:
Given a binary tree and a list of values to remove, we are tasked with eliminating all nodes containing these values. After removing the nodes, we need to return a list containing the roots of all trees in the resulting forest. Any children of the removed nodes should be treated as new trees in the forest.

#### Approach:
1. We will use **post-order traversal** to process each node’s children before deciding whether to remove the current node.
2. For each node:
   - Recursively process its left and right children.
   - If the node's value matches one of the values in the list of values to remove, its children (if any) are added to the resulting forest.
   - If the node should not be removed, it is returned and linked to its parent. Otherwise, `None` is returned.
3. After traversal, if the root node is not removed, we add it to the forest. The result is a list of all the remaining subtrees.

#### Time Complexity:
- The time complexity is **O(n)**, where `n` is the number of nodes in the tree since each node is visited once.

#### Space Complexity:
- The space complexity is **O(h)**, where `h` is the height of the tree due to recursion stack space.

#### Code Solution (Python):

```python
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def delNodes(root: TreeNode, to_delete: list[int]) -> list[TreeNode]:
    to_delete_set = set(to_delete)
    forest = []
    
    def postorder(node: TreeNode) -> TreeNode:
        if not node:
            return None
        
        # Recursively process left and right children
        node.left = postorder(node.left)
        node.right = postorder(node.right)
        
        # If the current node needs to be deleted
        if node.val in to_delete_set:
            # If the node has children, they become new roots
            if node.left:
                forest.append(node.left)
            if node.right:
                forest.append(node.right)
            # Return None to indicate this node is deleted
            return None
        
        return node
    
    # Begin post-order traversal
    root = postorder(root)
    
    # If the root itself is not deleted, add it to the forest
    if root:
        forest.append(root)
    
    return forest
```

#### Example:
**Input**: 
```
root = [1,2,3,4,5,6,7], to_delete = [3,5]
```
**Output**: 
```
[[1,2,null,4],[6],[7]]
```

**Explanation**:
- Node `3` and `5` are deleted. Their children (`6` and `7` for `3` and `4` for `5`) become new trees in the resulting forest.

---

Both answers now include the necessary explanation, time and space complexity analysis, and Python code solutions for the given problems.