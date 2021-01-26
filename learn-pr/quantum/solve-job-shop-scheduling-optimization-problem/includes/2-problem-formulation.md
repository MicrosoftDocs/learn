The job shop scheduling problem is defined as follows: you have a set of jobs ($J_0, J_1, J_2, \dots, J_{a-1}$, where $a$ is the total number of jobs), which have various processing times and need to be processed using a set of machines ($m_0, m_1, m_2, \dots, m_{b-1}$, where $b$ is the total number of machines). The goal is to complete all jobs in the shortest time possible (this is called minimizing the **makespan**).

Each job consists of a set of operations, and the operations must be performed in the correct order to complete that job.

To illustrate the scenario, we are going to return to our spaceship, where a disaster is brewing...

![Image showing a cross-section of the spaceship, with rooms such as life support, the reactor and the cockpit.](../media/spaceship-core.png)

Back onboard the spaceship, warning lights are flashing and alarms are blaring. You have been hit by the electromagnetic fallout from a coronal mass ejection event of a nearby star and are experiencing multiple failures across different critical systems!

![Image showing a failure in the life support system](../media/life-support-room-alert.png) | ![Image showing the cockpit, where the navigation system needs recalibration](../media/cockpit-room-alert.png) | ![Image showing a blown transformer in the reactor room](../media/reactor-room-alert.png)

Fortunately, you have the tools, team, and expertise on board to fix all the issues, however it's important that you follow procedure to ensure the repairs are successful. Below is the list of repair tasks that you must complete:

- Restart life support
  1. Open wall panel in the life support module (*2 minutes*) - **universal multi-tool**
  2. Replace fuse (*1 minute*) - **universal multi-tool**

- Recalibrate navigation system
  1. Reboot the system (*2 minutes*) - **ship computer**
  2. Locate the three nearest stellar landmarks (*2 minutes*) - **ship computer**

- Replace power transformer in the reactor
  1. Detach old transformer module (*1 minute*) - **universal multi-tool**
  2. Install new transformer module (*2 minutes*) - **universal multi-tool**

Each step that makes up a task takes a specific amount of time, and must be completed in the correct order.

To help you complete these tasks, you have access to your trusty **universal multi-tool** and the **ship computer** - you will use these machines to perform the repairs.

The mission is to **complete all of these tasks in as short a time as possible**, so that you can avoid disaster. For safety reasons, you must ensure that you follow procedure and thus there are some constraints on the way you complete the tasks:

1. Each of the steps (**operations**) in a repair task (**job**) must take place in order. You can't install the new transformer before removing the old one! This is called the **precedence constraint**.
2. You start an operation only once, and once started it must be completed before you do anything else. You can't afford to procrastinate! This is called the **operation-once constraint**.
3. Each tool (**machine**) can only do one thing at a time. For example, you can't simultaneously use the multi-tool to do several things. This is the **no-overlap constraint**.

### Cost functions

The rest of this learn module will be spent constructing what is known as a **cost function**, which is used to represent the problem. This cost function is what will be submitted to the Azure Quantum Optimization solver. If you have completed the previous module, [Solve optimization problems by using quantum-inspired optimization](https://docs.microsoft.com/learn/modules/solve-quantum-inspired-optimization-problems/), this concept should already be familiar.

Each point on a cost function represents a different solution configuration - in this case, each configuration is a particular assignment of starting times for the operations you are looking to schedule. The goal of the optimization is to minimize the cost of the solution - in this instance the aim is to minimize the amount of time taken to complete all operations.

Before you can submit the problem to the Azure Quantum solvers, you'll need to transform it to a representation that the solvers can work with. This is done by creating an array of `Term` objects, representing the problem constraints. Positive terms penalize certain solution configurations, while negative ones support them. By adding penalties to terms that break the constraints, you increase the relative cost of those configurations and reduce the likelihood that the optimizer will settle for these suboptimal solutions.

The idea is to make these invalid solutions so expensive that the solver can easily locate valid, low-cost solutions by navigating to low points (minima) in the cost function. However, you must also ensure that these solutions are not so expensive as to create peaks in the cost function that are so high that the solver can't travel over them to discover better optima on the other side.

### Azure Quantum setup

The Azure Quantum Optimization service is exposed via a Python SDK, which you will be making use of during the rest of this module. This means that before you get started with formulating the problem, you first need to import some Python modules and set up an Azure Quantum `Workspace`.

> [!NOTE]
> If you haven't created an Azure Quantum Workspace yet, you can learn more about how to do this in one of the previous modules from this series on Microsoft Quantum.

You will need to enter your Azure Quantum workspace details in the cell below before you run it:

```python
from typing import List
from azure.quantum.optimization import Term
from azure.quantum import Workspace

workspace = Workspace (
    subscription_id = "",  # Add your subscription_id
    resource_group = "",   # Add your resource_group
    name = "",             # Add your workspace name
    location = ""          # Add your workspace location (for example, "westus")
    )

workspace.login()
```

### Problem formulation

Now that you have set up your development environment, you can start to formulate the problem.

The first step is to take the constraints identified above and formulate them as mathematical equations that you can work with.

Let's first introduce some notation because you don't have time during an emergency to write things out in long form!

- $J_{0}$: Restart life support
  - $O_{0}$: Open wall panel in the life support module (*2 minutes*)
  - $O_{1}$: Replace fuse (*1 minute*)

- $J_{1}$: Recalibrate navigation system
  - $O_{2}$: Reboot the system (*2 minutes*)
  - $O_{3}$: Locate the three nearest stellar landmarks (*2 minutes*)

- $J_{2}$: Replace power transformer in the reactor
  - $O_{4}$: Detach old transformer module (*1 minute*)
  - $O_{5}$: Install new transformer module (*2 minutes*)

Above, you can see that the jobs have been labeled as $J$ and assigned index numbers $0$, $1$ and $2$, to represent each of the three tasks you have. The operations that make up each job have also been defined, and are represented by the letter $O$.

To make it easier to code up later, all operations are identified with a continuous index number rather than, for example, starting from $0$ for each job. This allows you to keep track of operations by their ID numbers in the code and schedule them according to the constraints and machine availability. You can tie the operations back to their jobs later on using a reference.

Below, you see how these definitions combine to give us a mathematical formulation for the jobs:

$$J_{0} = \{O_{0}, O_{1}\}$$
$$J_{1} = \{O_{2}, O_{3}\}$$
$$J_{2} = \{O_{4}, O_{5}\}$$

**More generally:**

$$J_{0} = \{O_{0}, O_{1}, \ldots , O_{k_{0}-1}\} \text{, where } k_{0} = n_{0} \text{, the number of operations in job } J_{0}$$

$$J_{1} = \{O_{k_{0}}, O_{k_{0}+1}, \ldots , O_{k_{1}-1}\} \text{, where } k_{1} = n_{0} + n_{1} \text{, the number of operations in jobs } J_{0} \text{ and } J_{1} \text{ combined}$$

$$\vdots$$

$$J_{n-1} = \{O_{k_{n-2}}, O_{k_{n-2}+1}, \ldots , O_{k_{n-1}-1}\} \text{, where } k_{n-1} = \text{ the total number of operations across all jobs }$$

The next piece of notation you will need is a binary variable, which will be called $x_{i, t}$.

You will use this variable to represent whether an operation starts at time $t$ or not:

$$\text{If } x_{i,t} = 1, \text{ } O_i\text{ starts at time } \textit{t}$$
$$\text{If } x_{i,t} = 0, \text{ } O_i\text{ does not start at time } \textit{t}$$

> [!NOTE]
> Because $x_{i, t}$ can take the value of either $0$ or $1$, this is known as a binary optimization problem. More generally, this is called a polynomial unconstrained binary optimization (or PUBO) problem. You may also see these PUBO problems referred to as Higher Order Binomial Optimization (HOBO) problems - these terms both refer to the same thing.

$t$ is used to represent the time. It goes from time $0$ to $T - 1$ in integer steps. $T$ is a (strict) upper bound on the latest time an operation can be scheduled:

$$0 \leq t < T$$

Lastly, $p_{i}$ is defined to be the processing time for operation $i$ - the amount of time it takes for operation $i$ ($O_{i}$) to complete:

$$\text{If } O_{i} \text{ starts at time } \textit{t} \text{, it will finish at time } t + p_{i}$$
$$\text{If } O_{i+1} \text{ starts at time } \textit{s} \text{, it will finish at time } s + p_{i+1}$$

Now that the terms have been defined, you can move on to formulating the problem.

The first step is to represent the constraints mathematically. This will be done using a penalty model - every time the optimizer explores a solution that violates one or more constraints, you need to give that solution a penalty:

| Constraint | Penalty condition |
|---|---|
|**Precedence constraint**<br>Operations in a job must take place in order.|Assign penalty every time $O_{i+1}$ starts before $O_{i}$ has finished (they start out of order).|
|**Operation-once constraint**<br>Each operation is started once and only once.|Assign penalty if an operation isn't scheduled within the allowed time.<br>**Assumption:** if an operation starts, it runs to completion.|
|**No-overlap constraint**<br>Machines can only do one thing at a time.|Assign penalty every time two operations on a single machine are scheduled to run at the same time.|

You will also need to define an objective function, which will minimize the time taken to complete all operations (the **makespan**).

### Expressing a cost function using the Azure Quantum Optimization SDK

As you will see during the exploration of the cost function and its constituent penalty terms below, the overall cost function is quadratic (because the highest order polynomial term you have is squared). This makes this problem a **Quadratic Unconstrained Binary Optimization (QUBO)** problem, which is a specific subset of **Polynomial Unconstrained Binary Optimization (PUBO)** problems (which allow for higher-order polynomial terms than quadratic). Fortunately, the Azure Quantum Optimization service is set up to accept PUBO (and Ising) problems, which means you don't need to modify the above representation to fit the solver.

As introduced above, the binary variables over which you are optimizing are the operation starting times $x_{i,t}$. Instead of using two separate indices as in the mathematical formulation, you will need to define a singly-indexed binary variable $x_{i \cdot T + t}$. Given time steps $t \in [0, T-1]$, every operation $i$ contributes $T$ indices. The operation starts at the value of $t$ for which $x_{i \cdot T + t}$ equals 1.

In order to submit a problem to the Azure Quantum services, you will first be creating a `Problem` instance. This is a Python object that stores all the required information, such as the cost function details and what kind of problem we are modeling.

To represent cost functions, we'll make use of a formulation using `Term` objects. Ultimately, any polynomial cost function can be written as a simple sum of products. That is, the function can be rewritten to have the following form, where $p_k$ indicates a product over the problem variables $x_0, x_1, \dots$:

$$ H(x) = \sum_k \alpha_k \cdot p_k(x_0, x_1, \dots) $$

$$ \text{e.g. } H(x) = 5 \cdot (x_0) + 2 \cdot (x_1 \cdot x_2) - 3 \cdot ({x_3}^2) $$

In this form, every term in the sum has a coefficient $\alpha_k$ and a product $p_k$. In the `Problem` instance, each term in the sum is represented by a `Term` object, with parameters `c` - corresponding to the coefficient, and `indices` - corresponding to the product. Specifically, the `indices` parameter is populated with the indices of all variables appearing in the term. For instance, the term $2 \cdot (x_1 \cdot x_2)$ translates to the following object: `Term(c=2, indices=[1,2])`.

More generally, `Term` objects take on the following form:

```python
Term(c: float, indices: []) # Constant terms like +1
Term(c: float, indices: [int]) # Linear terms like x
Term(c: float, indices: [int, int]) # Quadratic terms like x^2 or xy
```

If there were higher order terms (cubed, for example), you would just add more elements to the indices array, like so:

```python
Term(c: float, indices: [int, int, int, ...])
```

### Defining problem parameters in code

Now that you've defined the problem parameters mathematically, you can transform this information to code. Below, you can see the code representation of the problem parameters: the maximum allowed time `T`, the operation processing times `processing_time`, the mapping of operations to jobs (`jobs_ops_map` and `ops_jobs_map`),  and the assignment of operations to machines (`machines_ops_map`).

```python
# Set problem parameters
## Allowed time (jobs can only be scheduled below this limit)
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

#### Next steps

In the following units, you will construct mathematical representations of the penalty terms and use these to build the cost function, which will be of the format:

$$H(x) = \alpha \cdot f(x) + \beta \cdot g(x) + \gamma \cdot h(x) + \delta \cdot k(x) $$

where:

$$f(x) \text{, } g(x) \text{ and } h(x) \text{ represent the penalty functions.}$$
$$k(x) \text{ represents the objective function.}$$
$$\alpha, \beta, \gamma \text{ and } \delta \text{ represent the different weights assigned to the penalties.}$$

The weights represent how important each penalty function is, relative to all the others. In the following units, you will learn how to build these penalty and objective functions, combine them to form the cost function $H(x)$, and solve the problem using Azure Quantum.

To do this, you will explore how to formulate each of these constraints mathematically, and how to translate them to code.
