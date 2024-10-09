import random
import numpy as np

# Define the number of jobs and machines
num_jobs = 3
num_machines = 3

# Define the processing times for each job on each machine
# Processing times: [Job 0, Job 1, Job 2]
processing_times = [
    [3, 2, float('inf')],  # Product A: 3h on Machine 0, 2h on Machine 1
    [float('inf'), 2, 1],  # Product B: 2h on Machine 1, 1h on Machine 2
    [4, float('inf'), 3]   # Product C: 4h on Machine 0, 3h on Machine 2
]

# Function to calculate the makespan of a given schedule
def calculate_makespan(schedule):
    # Machine completion times
    completion_times = np.zeros((num_machines, max(num_jobs, len(schedule))))

    for operation in schedule:
        job, machine = operation
        start_time = completion_times[machine][0] if machine == 0 else completion_times[machine][job]
        # Ensure it starts after the previous job is done on the same machine
        if machine > 0:
            start_time = max(start_time, completion_times[machine - 1][job])

        # Set the completion time
        completion_times[machine][job] = start_time + processing_times[job][machine]

    return completion_times.max()  # Return the makespan

# Function to generate a random schedule (chromosome)
def create_schedule():
    schedule = []
    for job in range(num_jobs):
        for machine in range(num_machines):
            if processing_times[job][machine] != float('inf'):
                schedule.append((job, machine))
    random.shuffle(schedule)
    return schedule

# Function to evaluate the fitness of a schedule (lower is better)
def fitness(schedule):
    return calculate_makespan(schedule)

# Selection function using tournament selection
def tournament_selection(population, fitness_scores, tournament_size=3):
    selected = random.sample(range(len(population)), tournament_size)
    selected_fitness = [fitness_scores[i] for i in selected]
    winner_index = selected[selected_fitness.index(min(selected_fitness))]
    return population[winner_index]

# Crossover function
def crossover(parent1, parent2):
    crossover_point = random.randint(1, len(parent1) - 1)
    child1 = parent1[:crossover_point] + parent2[crossover_point:]
    child2 = parent2[:crossover_point] + parent1[crossover_point:]
    return child1, child2

# Mutation function
def mutate(schedule, mutation_rate=0.1):
    if random.random() < mutation_rate:
        idx1, idx2 = random.sample(range(len(schedule)), 2)
        schedule[idx1], schedule[idx2] = schedule[idx2], schedule[idx1]

# Genetic Algorithm function
def genetic_algorithm(population_size=100, generations=100, mutation_rate=0.1):
    population = [create_schedule() for _ in range(population_size)]

    for generation in range(generations):
        fitness_scores = [fitness(schedule) for schedule in population]

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
    best_schedule = min(population, key=fitness)
    best_makespan = fitness(best_schedule)
    return best_schedule, best_makespan

# Function to convert schedule to readable format
def readable_schedule(schedule):
    readable = []
    for job, machine in schedule:
        readable.append(f"Job {job + 1} on Machine {machine + 1}")
    return readable

# Testing the implementation
best_schedule, best_makespan = genetic_algorithm()

# Output results
print("\n*** Job-Shop Scheduling Results ***\n")
print("Best Schedule:")
for operation in readable_schedule(best_schedule):
    print(f" - {operation}")
print(f"\nBest Makespan (Total Production Time): {best_makespan} hours")
