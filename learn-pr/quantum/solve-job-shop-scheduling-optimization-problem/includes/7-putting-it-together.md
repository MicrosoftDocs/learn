Now that you have penalty terms to represent all of the constraints and the makespan minimization terms, you can finally assemble the cost function, $H(x)$!

As a reminder, here are the penalty terms:

| Constraint | Penalty condition |
|---|---|
|**Precedence constraint**<br>Operations in a job must take place in order.|Assign penalty every time $O_{i+1}$ starts before $O_{i}$ has finished (they start out of order).|
|**Operation-once constraint**<br>Each operation is started once and only once.|Assign penalty if an operation isn't scheduled within the allowed time.<br>**Assumption:** if an operation starts, it runs to completion.|
|**No-overlap constraint**<br>Machines can only do one thing at a time.|Assign penalty every time two operations on a single machine are scheduled to run at the same time.|

- **Precedence constraint**:

$$f(x) = \sum_{k_{n-1} \leq i < k_n, s < t + p_{i}}x_{i,t}\cdot x_{i+1,s} \text{ for each job } \textit{n}$$

- **Operation-once constraint**:

$$g(x) = \sum_{i} \left(\left(\sum_{0\leq t < T} x_{i,t}\right) - 1\right)^2$$
  
- **No-overlap constraint**:

$$h(x) = \sum_{i,t,k,s} x_{i,t}\cdot x_{k,s} = 0 \text{ for each machine } \textit{m}$$

- **Makespan minimization**:

$$k(x) = \sum_{i \in \{k_0-1, \dots, k_{n-1}-1\}} \left( \sum_{M_{lb} < t < T+p_i} c_t \cdot x_{i, ~t-p_i} \right)$$

As you saw earlier, combining the penalty functions is straightforward - all you need to do is assign each term a weight and add all the weighted terms together, like so:

$$H(x) = \alpha \cdot f(x) + \beta \cdot g(x) + \gamma \cdot h(x) + \delta \cdot k(x) $$

$$\text{where }\alpha, \beta, \gamma \text{ and } \delta \text{ represent the different weights assigned to the penalties.}$$

The weights represent how important each penalty function is, relative to all the others.

> [!NOTE]
> Along with modifying your cost function (how you represent the penalties), tuning these weights will define how much success you will have solving your optimization problem. There are many ways to represent each optimization problem's penalty functions and many ways to manipulate their relative weights, so this may require some experimentation before you see success. [Unit 10](xref:learn.quantum.solve-job-shop-scheduling-optimization-problem.10-tune-parameters) dives a little deeper into parameter tuning.

### Code

As a reminder, below you again see the code representation of the problem parameters: the maximum allowed time `T`, the operation processing times `processing_time`, the mapping of operations to jobs (`jobs_ops_map` and `ops_jobs_map`), and the assignment of operations to machines (`machines_ops_map`).

```python
# Set problem parameters
## Simulation time (jobs can only be scheduled below this limit)
T = 10

## Processing time for each operation
processing_time = {0: 2, 1: 1, 2: 2, 3: 2, 4: 1, 5: 2}

## Assignment of operations to jobs (job ID: [operation IDs])
### Operation IDs within a job must be in ascending order
jobs_ops_map = {
    0: [0, 1], # Restart life support
    1: [2, 3], # Recalibrate navigation system
    2: [4, 5]  # Replace power transformer in the reactor
}

## Assignment of operations to machines
### Three jobs, two machines
machines_ops_map = {
    0: [0, 1, 4, 5], # Operations 0, 1, 4 and 5 are assigned to machine 0 (the universal multi-tool)
    1: [2, 3]        # Operations 2 & 3 are assigned to machine 1 (the ship computer)
}

## Inverse mapping of jobs to operations
ops_jobs_map, T = process_config(jobs_ops_map, machines_ops_map, processing_time, T)
```

The helper function `process_config` (seen above) is defined as follows:

```python
def process_config(jobs_ops_map:dict, machines_ops_map:dict, processing_time:dict, T:int):
    """
    Process & validate problem parameters (config) and generate inverse dict of operations to jobs.

    Keyword arguments:

    jobs_ops_map (dict): Map of jobs to operations {job: [operations]}
    machines_ops_map(dict): Mapping of operations to machines, e.g.:
        machines_ops_map = {
            0: [0,1],          # Operations 0 & 1 assigned to machine 0
            1: [2,3]           # Operations 2 & 3 assigned to machine 1
        }
    processing_time (dict): Operation processing times
    T (int): Allowed time (jobs can only be scheduled below this limit)
    """

    # Problem cannot take longer to complete than all operations executed sequentially
    ## Sum all operation processing times to calculate the maximum makespan
    T = min(sum(processing_time.values()), T) 

    # Ensure operation assignments to machines are sorted in ascending order
    for m, ops in machines_ops_map.items():
        machines_ops_map[m] = sorted(ops)
    ops_jobs_map = {}

    for job, ops in jobs_ops_map.items():
        # Fail if operation IDs within a job are out of order
        assert (ops == sorted(ops)), f"Operation IDs within a job must be in ascending order. Job was: {job}: {ops}"

        for op in ops:
            # Fail if there are duplicate operation IDs
            assert (op not in ops_jobs_map.keys()), f"Operation IDs must be unique. Duplicate ID was: {op}"
            ops_jobs_map[op] = job

    return ops_jobs_map, T
```

The following code snippet shows how you assign weight values and assemble the penalty terms by summing the output of the penalty and objective functions, as was demonstrated mathematically at the start of this unit. These terms represent the cost function and they are what you will submit to the solver.

```python
# Generate terms to submit to solver using functions defined previously
## Assign penalty term weights:
alpha = 5  # Precedence constraint
beta = 5   # Operation once constraint
gamma = 5  # No overlap constraint
delta = 0.004  # Makespan minimization (objective function)

## Build terms
### Constraints:
c1 = precedence_constraint(jobs_ops_map, T, processing_time, alpha)
c2 = operation_once_constraint(ops_jobs_map, T, beta)
c3 = no_overlap_constraint(T, processing_time, ops_jobs_map, machines_ops_map, gamma)

### Objective function
c4 = makespan_objective(T, processing_time, jobs_ops_map, len(machines_ops_map), delta)

### Combine terms:
terms = []
terms = c1 + c2 + c3 + c4
```

> [!NOTE]
> You can find the full Python script (including the code from all units in this module) and an interactive Jupyter notebook of this sample in our samples repo.
