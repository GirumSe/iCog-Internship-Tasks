import numpy as np
import random

class Solution:
    def solveNQueens(self, n: int):
        # Generate a list of unique non-matching values from 0 to n-1
        def generate_non_matching_values(n):
            unique_values = list(range(0, n))
            random.shuffle(unique_values)
            return unique_values

        # Fitness function to evaluate the score of a chromosome (array)
        def fitnessFunction(array):
            score = 0
            for x, y in enumerate(array):
                for x2 in range(x + 1, len(array)):
                    a = abs(x - x2) == abs(y - array[x2])  # Check diagonal collision
                    b = y == array[x2]  # Check horizontal collision
                    if a or b:
                        if a:
                            score -= abs(x - x2) * 10  # Penalize diagonal collisions
                        if b:
                            score -= abs(y - x2) * 10  # Penalize horizontal collisions
            return score

        # Mutate function to randomly modify genes (queen positions) in the chromosome
        def Mutate(gen):
            for i, el in enumerate(gen):
                for j in range(i + 1, len(gen)):
                    if abs(i - j) == abs(el - gen[j]) or el == gen[j]:
                        gen[j] = int(random.randint(0, n - 1))  # Randomly mutate

        # Main genetic algorithm logic
        def n_queens_genetic_algorithm(n_queens, sol_number):
            Population = []
            scores = []
            x = n_queens * 2
            count_First = []

            for i in range(10**6):  # Run for a large number of generations
                gen = generate_non_matching_values(n_queens)
                Population.append(gen)
                scoreFitness = fitnessFunction(gen)
                scores.append(scoreFitness)

                # Sort population by fitness score (descending)
                sorted_data = sorted(zip(scores, Population), reverse=True)
                Population = [x for _, x in sorted_data][:x]
                scores = sorted(scores, reverse=True)[:x]

                countZero = scores.count(0)  # Count how many have a perfect score (fitness == 0)
                if countZero >= sol_number:
                    # Return unique solutions when the required number of perfect solutions is found
                    return np.unique(np.array(Population[:countZero]), axis=0)

                # Mutate some individuals in the population
                for _ in range(10 + n_queens):
                    try:
                        index = random.randint(0, x - 1)
                        Mutate(Population[index])
                        scores[index] = fitnessFunction(Population[index])
                    except IndexError:
                        continue

                # Check if the algorithm is stuck (if top fitness scores don't change)
                countFirstNum = scores[0]
                count_First.append(countFirstNum)
                if abs(count_First.count(max(count_First))) * len(scores) > abs(sum(scores)) / (n_queens):
                    possibility = 0.95 - 1 / (sum([k for k in range(i)]) + 100)
                    if possibility < 0.35:
                        count_First = []
                        Population = []
                        scores = []
                        x += x

        # Convert the board representation from a list of integers to the desired format
        def board_to_string(solution):
            board = []
            for i in solution:
                row = ["."] * n
                row[i] = "Q"  # Place queen at the correct position
                board.append("".join(row))
            return board

        # Run the genetic algorithm to get unique solutions
        unique_solutions = n_queens_genetic_algorithm(n, 3)  # You can adjust the number of solutions

        # Format the solutions into a list of lists
        return [board_to_string(solution) for solution in unique_solutions]

# Example usage:
if __name__ == "__main__":
    sol = Solution()
    n = 5
    output = sol.solveNQueens(n)
    print("Input: n =", n)
    print("Output:", output)
