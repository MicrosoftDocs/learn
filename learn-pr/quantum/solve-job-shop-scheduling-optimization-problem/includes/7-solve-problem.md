### Submit problem to Azure Quantum

This code submits the terms to the Azure Quantum `SimulatedAnnealing` solver. You could also have used the same problem definition with any of the other Azure Quantum solvers available (e.g. `ParallelTempering`).

The job is run synchronously in this instance, however this could also be submitted asynchronously as shown in the next subsection.

```python
from azure.quantum.optimization import Problem, ProblemType, SimulatedAnnealing

# Problem type is PUBO in this instance. You could also have chosen to represent our problem in Ising form.
problem = Problem(name="Job shop sample", problem_type=ProblemType.pubo, terms=terms)

# Provide details of your workspace, created at the beginning of this tutorial
solver = SimulatedAnnealing(workspace, timeout = 100) # Timeout in seconds

# Run job synchronously
result = solver.optimize(problem)
config = result['configuration']

print(config)
```

```output
    .....
    {'0': 1, '5': 0, '6': 0, '1': 0, '7': 1, '2': 0, '8': 0, '3': 0, '9': 0, '4': 0, '10': 1, '15': 0, '16': 0, '11': 0, '17': 1, '12': 0, '18': 0, '13': 0, '19': 0, '14': 0, '20': 0, '21': 0, '22': 0, '23': 1, '24': 0, '25': 0, '26': 0, '27': 0, '28': 0, '29': 1}
```

### Run job asynchronously

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

### Map variables to operations

This code snippet contains several helper functions which are used to parse the results returned from the solver and print them to screen in a user-friendly format.

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

def print_problem_details(n:int, o:int, p: List[int], ops_machines_map: List[List[int]]):
    """

    Print problem details e.g. operation runtimes and machine assignments.

    Keyword arguments:
    n (int): Total number of jobs
    o (int): Number of operations per job
    p (List[int]): List of job processing times
    ops_machine_map(List[List[int]]): Mapping of operations to machines
    """

    job = 0
    jobs = []
    ops = []
    machines = []

    for i in range(o * n):
        jobs.append(job)
        ops.append(i)

        if (i + 1) % o == 0:
            job += 1
    for i in range(len(ops_machines_map)):
        for j in range(len(ops_machines_map[i])):
            machines.insert(ops_machines_map[i][j], i)

    print(f"           Job ID: {jobs}")
    print(f"     Operation ID: {ops}")
    print(f"Operation runtime: {p}")
    print(f" Assigned machine: {machines}")
    print()

def split_array(T:int, array:List[int]):
    """
    Split array into rows representing the rows of the operation matrix.

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

def print_jobs(n:int, o:int, matrix:List[List[int]]):
    """
    Group operations into jobs & print.

    Keyword arguments:
    n (int): Total number of jobs
    o (int): Number of operations per job
    matrix (List[List[int]]): Matrix of x_i,t values
    """

    i = 0
    jobs = []
    while i < o * n:
        x = []
        for j in range (i, i + o):
            try :
                index = matrix[j].index(1)
            except ValueError:
                index = -1
            x.append(index)
        jobs.append(x)
        i += o
    print(jobs)
```

### Results

Finally, you take the config returned by the solver and read out the results.

```python
# Produce 1D array of x_i,t = 0, 1 representing when each operation starts
op_array = create_op_array(config)

# Print config details:
print(f"Config dict:\n{config}\n")
print(f"Config array:\n{op_array}\n")

# Print problem setup
print_problem_details(n, o, p, ops_machines_map)

# Print final operation matrix, using the returned config
print("Operation matrix:")
matrix = split_array(T, op_array)
print_matrix(T, matrix)

# Find where each operation starts (when x_i,t = 1) and return the start time
print("Operation start times (grouped into jobs):")
print_jobs(n, o, matrix)
```

```output
    Config dict:
    {'0': 1, '5': 0, '6': 0, '1': 0, '7': 1, '2': 0, '8': 0, '3': 0, '9': 0, '4': 0, '10': 1, '15': 0, '16': 0, '11': 0, '17': 1, '12': 0, '18': 0, '13': 0, '19': 0, '14': 0, '20': 0, '21': 0, '22': 0, '23': 1, '24': 0, '25': 0, '26': 0, '27': 0, '28': 0, '29': 1}

    Config array:
    [1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1]

               Job ID: [0, 0, 1, 1, 2, 2]
         Operation ID: [0, 1, 2, 3, 4, 5]
    Operation runtime: [2, 1, 2, 2, 1, 2]
     Assigned machine: [0, 0, 1, 1, 0, 0]

    Operation matrix:
        t: 0 1 2 3 4
    x_0,t: 1 0 0 0 0
    x_1,t: 0 0 1 0 0
    x_2,t: 1 0 0 0 0
    x_3,t: 0 0 1 0 0
    x_4,t: 0 0 0 1 0
    x_5,t: 0 0 0 0 1

    Operation start times (grouped into jobs):
    [[0, 2], [0, 2], [3, 4]]
```

Translating back to the problem at hand, below is shown the order in which your repair tasks should be completed to finish as quickly (and safely) as possible. If two tasks have the same order number, they can be performed at the same time by different crewmembers using different tools:

$$
\begin{array}[t]{ | cl | c | c | }
    \hline
     & \text{Task} & \text{Tool} & \text{Order}\\
    \hline
    J_{0} \text{:} & \text{Restart life support} & & \\ \hline
    O_{0} & \text{Open panel in the life support module} & Universal multitool & 1\\
    O_{1} & \text{Replace fuse} & Universal multitool & 2\\
    \hline
\end{array}
\begin{array}[t]{ | cl | c | c | }
    \hline
     & \text{Task} & \text{Tool} & \text{Order}\\
    \hline
    J_{1} \text{:} & \text{Recalibrate navigation system} & & \\ \hline
    O_{3} & \text{Reboot the system} & Ship computer & 1\\
    O_{4} & \text{Locate the three nearest stellar landmarks} & Ship computer & 2\\
    \hline
\end{array}
\begin{array}[t]{ | cl | c | c | }
    \hline
     & \text{Task} & \text{Tool} & \text{Order}\\
    \hline
    J_{2} \text{:} & \text{Replace power transformer in the reactor} & & \\ \hline
    O_{6} & \text{Detach old transformer module} & Universal multitool & 3\\
    O_{7} & \text{Install new transformer module} & Universal multitool & 4\\
    \hline
\end{array}
$$

By inspection, you can tell that the solution returned above is valid (i.e. it does not violate any of the constraints defined previously):

- Operations belonging to the same job happen in order
- Each machine only has one operation running at a time
- Operations are started once and only once

For larger or more complex problems, it will not always be possible to verify the solution by eye. It is therefore common practice to implement some code to verify that solutions returned from the optimizer are valid, as well as evaluating how good the solutions are. This capability is also very useful when it comes to tuning weights and penalty functions.

In this particular (simple) instance, the solver quickly returned the solution with the lowest possible cost - the global minimum. However, you must remember that these solvers are heuristics and are therefore not guaranteed to find the absolute minimum cost solution possible, particularly when the problem definition becomes more complex.

Depending on how well the cost function is defined and the weights are tuned, the solver will have varying degrees of success. This reinforces the importance of verifying and evaluating returned solutions, to enable tuning of the problem definition in order to improve solution quality.
