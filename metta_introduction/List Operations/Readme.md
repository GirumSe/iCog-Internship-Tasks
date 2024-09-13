# List Operations in MeTTa

This project contains a collection of list operations implemented in the MeTTa language, a functional programming language. The scripts demonstrate various common operations on lists, such as appending elements, finding the length, removing elements, sorting, and more.

## Project Structure

- **MeTTa Scripts**: Each `.metta` file in this project contains one or more list operations along with corresponding test cases.
- **Bash Script**: A bash script (`run_all_scripts.sh`) is included to automate running all the MeTTa scripts sequentially. This helps to ensure that all operations work as expected without running them manually.

## List Operations

Below are the list operations implemented in this project:

1. **Append**: Combines two lists into one.
2. **Length**: Calculates the number of elements in a list.
3. **Is-Member**: Checks if a given element is present in a list.
4. **Max-Value**: Finds the maximum value in a list.
5. **Min-Value**: Finds the minimum value in a list.
6. **Push**: Adds an element to the front of a list.
7. **Pop**: Removes the first element from a list.
8. **Remove-Element**: Removes all occurrences of a specific element from a list.
9. **Remove-Duplicate**: Removes duplicate elements from a list.
10. **Map**: Applies a function to each element in a list.
11. **Filter**: Filters the list based on a predicate function.
12. **Foldl**: Reduces the list from left to right using a binary function.
13. **Foldr**: Reduces the list from right to left using a binary function.
14. **Reverse**: Reverses the elements of a list.
15. **Sort**: Sorts the list using an insertion sort algorithm.

## How to Run the Project

1. **Prerequisites**: 
   - Make sure you have MeTTa [installed](https://github.com/trueagi-io/hyperon-experimental#using-the-latest-release-version) on your system.
   - Bash is required to run the automation script.

2. **Running Individual Scripts**: 
   You can run any `.metta` script manually using:
   ```bash
   metta script_name.metta
   ```

3. **Running All Scripts**: 
   The `run_all_scripts.sh` bash script runs all `.metta` scripts in the folder sequentially:
   ```bash
   ./run_all_scripts.sh
   ```

   The output of each script, including the test cases, will be displayed in the terminal.

## Example

An example of running the `append.metta` script would look like this:
```bash
metta append.metta
```

This will output the result of the append operation, along with any associated test cases.

---

By following this setup, users can easily explore and test various list operations implemented in MeTTa. Feel free to contribute additional functions or improve existing ones!