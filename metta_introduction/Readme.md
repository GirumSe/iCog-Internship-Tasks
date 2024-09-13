# MeTTa Data Structures

This repository contains implementations of fundamental data structures and operations in the [MeTTa](https://github.com/trueagi-io/hyperon-experimental) language, specifically focusing on **Binary Trees** and **List Operations**. These implementations can be used as basic building blocks for various algorithms in a functional programming style.

## Contents

1. [Binary Trees](#binary-trees)
2. [List Operations](#list-operations)
3. [Getting Started](#getting-started)
4. [Usage](#usage)
5. [Contributing](#contributing)
6. [License](#license)

---

## Binary Trees

The `Binary Tree Implementation/` folder contains an implementation of a Binary Search Tree (BST) in MeTTa, along with various operations to manipulate and query the tree.

### Features

- **Insert**: Adds an element to the binary search tree while maintaining the BST property.
- **Member Check**: Checks if a specific element exists in the tree.
- **In-order Traversal**: Performs an in-order traversal (left, root, right) and returns the elements in sorted order.

### Example Usage

- **Insert an element:**

```metta
(insert-bst 5 Nil)
```

- **Check if an element is a member:**

```metta
(is-member-bst 3 (Tree 5 (Tree 3 (Leaf) (Leaf)) (Tree 7 (Leaf) (Leaf))))
```

- **In-order Traversal:**

```metta
(inorder (insert-bst 3 (insert-bst 7 (insert-bst 5 Nil))))
```

For more details, see the [Binary Tree Implementation/README.md](Binary Tree Implementation/Readme.md).

---

## List Operations

The `List Operations/` folder contains various implementations of list operations in MeTTa.

### Implemented Operations

- `append`: Combines two lists.
- `foldl` and `foldr`: Left and right fold operations to aggregate list elements.
- `map`: Applies a function to each element of a list.
- `filter`: Filters elements from a list based on a condition.
- `remove-element`: Removes occurrences of a specified element from a list.
- `sort`: Sorts a list.
- `reverse`: Reverses a list.
- **More**: Additional common list operations like `push`, `pop`, `length`, and `is-member`.

### Example Usage

- **Append two lists:**

```metta
(append (List 1 2 3) (List 4 5 6))
```

- **Remove an element:**

```metta
(remove-element 3 (List 1 2 3 4 3 5))
```

- **Sort a list:**

```metta
(sort (List 3 1 4 5 2))
```

For more details, see the [List Operations/README.md](List Operations/Readme.md).

---

## Getting Started

### Prerequisites

You must have [MeTTa](https://github.com/trueagi-io/hyperon-experimental) installed on your machine. Follow the installation instructions in the MeTTa repository to set up the language.

### Running the Code

1. Clone the repository:
   ```bash
   git clone https://github.com/GirumSe/iCog-Internship-Tasks.git
   cd iCog-Internship-Tasks/metta_introduction
   ```

2. Navigate to the folder for either **Binary Tree Implementation** or **List Operations**:
   ```bash
   cd Binary\ Tree\ Implementation/
   ```

3. Run the `.metta` files in your terminal:
   ```bash
   metta  binary_tree.metta
   ```

---

## Usage

Each folder contains a main `.metta` script that showcases how the respective data structure or list operations work. You can modify these scripts to experiment with the functionality or incorporate these structures into larger projects.

- **Binary Tree Script:** `Binary Tree Implementation/binary_tree.metta`
- **List Operations Script:** `List Operations/operations_name.metta`

---

## Contributing

Contributions are welcome! If you have any suggestions or improvements, feel free to open an issue or submit a pull request.

### Steps to Contribute

1. Fork this repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit and push to your branch.
5. Open a pull request for review.
