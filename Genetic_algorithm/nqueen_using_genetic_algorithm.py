import numpy as np
import random

# Generate a shuffled list of integers from 0 to n-1, representing non-conflicting queen positions
def generate_non_matching_values(n):
    unique_values = list(range(n))
    random.shuffle(unique_values)
    return unique_values

# Calculate the fitness score of a board configuration (lower is better)
# Penalizes conflicts in rows (horizontal) and diagonals
def fitnessFunction(array):
    score = 0
    for x, y in enumerate(array):
        for x2 in range(x + 1, len(array)):
            # Check for diagonal and horizontal conflicts
            diagonal_conflict = abs(x - x2) == abs(y - array[x2])
            horizontal_conflict = y == array[x2]
            if diagonal_conflict:
                score -= abs(x - x2) * 10  # Penalize diagonal collisions
            if horizontal_conflict:
                score -= abs(y - x2) * 10  # Penalize horizontal collisions
    return score

# Randomly mutate queen positions in the board to reduce conflicts
def mutate(gen, n):
    for i, el in enumerate(gen):
        for j in range(i + 1, len(gen)):
            if abs(i - j) == abs(el - gen[j]) or el == gen[j]:  # Conflict found
                gen[j] = random.randint(0, n - 1)  # Randomly change queen position

# Genetic algorithm to solve N-Queens problem
# Finds up to 'sol_number' unique solutions
def n_queens_genetic_algorithm(n_queens, sol_number):
    Population = []
    scores = []
    x = n_queens * 2  # Population size

    # Iterate through a large number of generations
    for i in range(10**6):
        gen = generate_non_matching_values(n_queens)  # Create a new chromosome
        Population.append(gen)
        scores.append(fitnessFunction(gen))  # Evaluate fitness

        # Sort by fitness, keep the best 'x' individuals
        sorted_data = sorted(zip(scores, Population), reverse=True)
        Population = [x for _, x in sorted_data][:x]
        scores = sorted(scores, reverse=True)[:x]

        # Check for solutions with zero conflicts (perfect score)
        countZero = scores.count(0)
        if countZero >= sol_number:
            # Return unique valid solutions when enough are found
            return np.unique(np.array(Population[:countZero]), axis=0)

        # Mutate random individuals in the population to explore new possibilities
        for _ in range(10 + n_queens):
            try:
                index = random.randint(0, x - 1)
                mutate(Population[index], n_queens)
                scores[index] = fitnessFunction(Population[index])  # Re-evaluate fitness
            except IndexError:
                continue

# Convert the solution into a visual representation of the chessboard
def board_to_string(solution, n):
    board = []
    for i in solution:
        row = ["."] * n
        row[i] = "Q"  # Place queen in the correct column
        board.append("".join(row))
    return board

# Solve the N-Queens problem and format the solutions as boards
def solveNQueens(n):
    unique_solutions = n_queens_genetic_algorithm(n, 2)  # Adjust number of solutions as needed
    return [board_to_string(solution, n) for solution in unique_solutions]

# User input and output
n = int(input("Enter the number of queens: "))
output = solveNQueens(n)
print("Input: n =", n)
print("Output:", output)