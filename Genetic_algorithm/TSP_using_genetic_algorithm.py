import random
import numpy as np
import matplotlib.pyplot as plt

# Define the number of cities
num_cities = 5

# Define the coordinates of the cities
cities = np.array([
    [0, 0],    # City 0
    [1, 3],    # City 1
    [4, 3],    # City 2
    [6, 1],    # City 3
    [3, 0]     # City 4
])

# Function to calculate the distance between two cities
def calculate_distance(city1, city2):
    return np.linalg.norm(city1 - city2)

# Function to calculate the total distance of a tour
def total_distance(tour):
    distance = 0
    for i in range(len(tour) - 1):
        distance += calculate_distance(cities[tour[i]], cities[tour[i + 1]])
    distance += calculate_distance(cities[tour[-1]], cities[tour[0]])  # Return to the start
    return distance

# Function to create a random tour (chromosome)
def create_tour():
    tour = list(range(num_cities))
    random.shuffle(tour)
    return tour

# Function to evaluate the fitness of a tour (lower is better)
def fitness(tour):
    return total_distance(tour)

# Selection function using tournament selection
def tournament_selection(population, fitness_scores, tournament_size=3):
    selected = random.sample(range(len(population)), tournament_size)
    selected_fitness = [fitness_scores[i] for i in selected]
    winner_index = selected[selected_fitness.index(min(selected_fitness))]
    return population[winner_index]

# Crossover function (Order Crossover)
def crossover(parent1, parent2):
    start, end = sorted(random.sample(range(num_cities), 2))
    child1 = [None] * num_cities
    child1[start:end] = parent1[start:end]
    current_index = (end) % num_cities
    
    for gene in parent2:
        if gene not in child1:
            child1[current_index] = gene
            current_index = (current_index + 1) % num_cities

    child2 = [None] * num_cities
    child2[start:end] = parent2[start:end]
    current_index = (end) % num_cities
    
    for gene in parent1:
        if gene not in child2:
            child2[current_index] = gene
            current_index = (current_index + 1) % num_cities

    return child1, child2

# Mutation function (Swap Mutation)
def mutate(tour, mutation_rate=0.1):
    if random.random() < mutation_rate:
        idx1, idx2 = random.sample(range(num_cities), 2)
        tour[idx1], tour[idx2] = tour[idx2], tour[idx1]

# Genetic Algorithm function
def genetic_algorithm(population_size=100, generations=500, mutation_rate=0.1):
    population = [create_tour() for _ in range(population_size)]

    for generation in range(generations):
        fitness_scores = [fitness(tour) for tour in population]

        # Create the next generation
        new_population = []
        for _ in range(population_size // 2):
            parent1 = tournament_selection(population, fitness_scores)
            parent2 = tournament_selection(population, fitness_scores)
            child1, child2 = crossover(parent1, parent2)
            mutate(child1, mutation_rate)
            mutate(child2, mutation_rate)
            new_population.extend([child1, child2])
        
        population = new_population
    
    # Find the best solution in the final population
    best_tour = min(population, key=fitness)
    best_distance = fitness(best_tour)
    return best_tour, best_distance

# Testing the implementation
best_tour, best_distance = genetic_algorithm()

# Output results
print("Best Tour:", best_tour)
print("Best Distance:", best_distance)
