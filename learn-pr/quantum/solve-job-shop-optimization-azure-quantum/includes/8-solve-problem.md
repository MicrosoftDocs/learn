Next, you will submit the problem to Azure Quantum.

This code submits the terms to the Azure Quantum `SimulatedAnnealing` solver. You could also have used the same problem definition with any of the other Azure Quantum Optimization solvers available (for example, `ParallelTempering`). You can find further information on the various solvers available through the Azure Quantum Optimization service on our docs site.

The job is run synchronously in this instance, however this could also be submitted asynchronously as shown in the next subsection.

```python
from azure.quantum.optimization import Problem, ProblemType
from azure.quantum.optimization import SimulatedAnnealing # Change this line to match the Azure Quantum Optimization solver type you wish to use

# Problem type is PUBO in this instance. You could also have chosen to represent the problem in Ising form.
problem = Problem(name="Job shop sample", problem_type=ProblemType.pubo, terms=terms)

# Provide details of your workspace, created at the beginning of this tutorial
# Provide the name of the solver you wish to use for this problem (as imported above)
solver = SimulatedAnnealing(workspace, timeout = 100) # Timeout in seconds

# Run job synchronously
result = solver.optimize(problem)
config = result['configuration']

print(config)
```

```console
......
{'0': 1, '10': 0, '11': 0, '1': 0, '12': 1, '2': 0, '13': 0, '3': 0, '14': 0, '4': 0, '15': 0, '5': 0, '16': 0, '6': 0, '17': 0, '7': 0, '18': 0, '8': 0, '19': 0, '9': 0, '20': 1, '30': 0, '31': 0, '21': 0, '32': 1, '22': 0, '33': 0, '23': 0, '34': 0, '24': 0, '35': 0, '25': 0, '36': 0, '26': 0, '37': 0, '27': 0, '38': 0, '28': 0, '39': 0, '29': 0, '40': 0, '50': 0, '41': 0, '51': 0, '42': 0, '52': 0, '43': 1, '53': 0, '44': 0, '54': 1, '45': 0, '55': 0, '46': 0, '56': 0, '47': 0, '57': 0, '48': 0, '58': 0, '49': 0, '59': 0}
```

## Run job asynchronously

Alternatively, a job can be run asynchronously, as shown below:

```python
# Submit problem to solver
job = solver.submit(problem)
print(job.id)

# Get job status
job.refresh()
print(job.details.status)

# Get results
result = job.get_results()
config = result['configuration']
print(config)
```

## Map variables to operations

This code snippet contains several helper functions, which are used to parse the results returned from the solver and print them to screen in a user-friendly format.

```python
def create_op_array(config: dict):
    """
    Create array from returned config dict.

    Keyword arguments:
    config (dictionary): config returned from solver
    """

    variables = []
    for key, val in config.items():
        variables.insert(int(key), val)
    return variables

def print_problem_details(ops_jobs_map:dict, processing_time:dict, machines_ops_map:dict):
    """

    Print problem details e.g. operation runtimes and machine assignments.        

    Keyword arguments:
    ops_jobs_map (dict): Map of operations to jobs {operation: job}
    processing_time (dict): Operation processing times
    machines_ops_map(dict): Mapping of machines to operations
    """

    machines = [None] * len(ops_jobs_map)

    for m, ops in machines_ops_map.items():
        for op in ops:
          machines[op] = m

    print(f"           Job ID: {list(ops_jobs_map.values())}")
    print(f"     Operation ID: {list(ops_jobs_map.keys())}")
    print(f"Operation runtime: {list(processing_time.values())}")
    print(f" Assigned machine: {machines}")
    print()

def split_array(T:int, array:List[int]):
    """
    Split array into rows representing the rows of our operation matrix.

    Keyword arguments:
    T (int): Time allowed to complete all operations
    array (List[int]): array of x_i,t values generated from config returned by solver
    """

    ops = []
    i = 0
    while i < len(array):
        x = array[i:i+T]
        ops.append(x)
        i = i + T
    return ops

def print_matrix(T:int, matrix:List[List[int]]):
    """
    Print final output matrix.        

    Keyword arguments:
    T (int): Time allowed to complete all operations
    matrix (List[List[int]]): Matrix of x_i,t values
    """

    labels = "    t:"
    for t in range(0, T):
        labels += f" {t}"
    print(labels)

    idx = 0
    for row in matrix:
        print("x_" + str(idx) + ",t: ", end="")
        print(' '.join(map(str,row)))
        idx += 1
    print()

def extract_start_times(jobs_ops_map:dict, matrix:List[List[int]]):
    """
    Extract operation start times & group them into jobs.

    Keyword arguments:
    jobs_ops_map (dict): Map of jobs to operations {job: [operations]}
    matrix (List[List[int]]): Matrix of x_i,t values
    """
    #jobs = {}
    jobs = [None] * len(jobs_ops_map)
    op_start_times = []
    for job, ops in jobs_ops_map.items(): 
        x = [None] * len(ops)
        for i in range(len(ops)):
            try :
                x[i] = matrix[ops[i]].index(1)
                op_start_times.append(matrix[ops[i]].index(1))
            except ValueError:
                x[i] = -1
                op_start_times.append(-1)
        jobs[job] = x

    return jobs, op_start_times
```

## Results

Finally, you take the config returned by the solver and read out the results.

```python
# Produce 1D array of x_i,t = 0, 1 representing when each operation starts
op_array = create_op_array(config) 

# Print config details:
print(f"Config dict:\n{config}\n")
print(f"Config array:\n{op_array}\n")

# Print problem setup
print_problem_details(ops_jobs_map, processing_time, machines_ops_map)

# Print final operation matrix, using the returned config
print("Operation matrix:")
matrix = split_array(T, op_array) 
print_matrix(T, matrix)

# Find where each operation starts (when x_i,t = 1) and return the start time
print("Operation start times (grouped into jobs):")
jobs, op_start_times = extract_start_times(jobs_ops_map, matrix)
print(jobs)

# Calculate makespan (time taken to complete all operations - the objective you are minimizing)
op_end_times = [op_start_times[i] + processing_time[i] for i in range(len(op_start_times))]
makespan = max(op_end_times)

print(f"\nMakespan (time taken to complete all operations): {makespan}")
```

```console
Config dict:
{'0': 1, '10': 0, '11': 0, '1': 0, '12': 1, '2': 0, '13': 0, '3': 0, '14': 0, '4': 0, '15': 0, '5': 0, '16': 0, '6': 0, '17': 0, '7': 0, '18': 0, '8': 0, '19': 0, '9': 0, '20': 1, '30': 0, '31': 0, '21': 0, '32': 1, '22': 0, '33': 0, '23': 0, '34': 0, '24': 0, '35': 0, '25': 0, '36': 0, '26': 0, '37': 0, '27': 0, '38': 0, '28': 0, '39': 0, '29': 0, '40': 0, '50': 0, '41': 0, '51': 0, '42': 0, '52': 0, '43': 1, '53': 0, '44': 0, '54': 1, '45': 0, '55': 0, '46': 0, '56': 0, '47': 0, '57': 0, '48': 0, '58': 0, '49': 0, '59': 0}

Config array:
[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0]

           Job ID: [0, 0, 1, 1, 2, 2]
     Operation ID: [0, 1, 2, 3, 4, 5]
Operation runtime: [2, 1, 2, 2, 1, 2]
 Assigned machine: [0, 0, 1, 1, 0, 0]

Operation matrix:
    t: 0 1 2 3 4 5 6 7 8 9
x_0,t: 1 0 0 0 0 0 0 0 0 0
x_1,t: 0 0 1 0 0 0 0 0 0 0
x_2,t: 1 0 0 0 0 0 0 0 0 0
x_3,t: 0 0 1 0 0 0 0 0 0 0
x_4,t: 0 0 0 1 0 0 0 0 0 0
x_5,t: 0 0 0 0 1 0 0 0 0 0

Operation start times (grouped into jobs):
[[0, 2], [0, 2], [3, 4]]

Makespan (time taken to complete all operations): 6
```

For this small problem instance, the solver quickly returned a solution. For bigger, more complex problems you may need to run the job asynchronously, as shown earlier in this unit.
