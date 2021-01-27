In this unit, you will learn how to develop an objective function that minimizes the makespan of the solution. The makespan is the time taken to complete all operations.

### Minimize the makespan

So far you've learned how to represent the constraints of your optimization problem with a penalty model, allowing you to compute *valid* solutions. Remember however that your end goal is to obtain an *optimal* (or close to optimal) solution. In this case, you're looking for the schedule with the fastest completion time of all jobs.

The makespan $M$ is defined as the total time required to run all jobs, or alternatively the finishing time of the last job. To minimize this quantity, you need to add a fourth component to the cost function that adds larger penalties to solutions with larger makespans:

$$ H(x) = \alpha \cdot f(x) + \beta \cdot g(x) + \gamma \cdot h(x) + \mathbf{\delta \cdot k(x)} $$

Let's come up with terms that increase the value of the cost function the further out the last job is completed. Remember that the completion time of a job depends solely on the completion time of its final operation. However, since you have no way of knowing in advance what the last job will be, or at which time the last operation will finish, you'll need to include a term for each operation and time step. These terms need to scale with the time parameter $t$, and consider the operation processing time, in order to penalize larger makespans over smaller ones.

Some care is required in determining the penalty values, or *coefficients*, of these terms. Recall that you have a set of operations $\{O_i\}$, each of which takes time $p_i$ to complete. An operation scheduled at time $t$ will then *complete* at time $t + p_i$. Let's define the coefficient $c_t$ as the penalty applied to the cost function for an operation to finish at time $t$. As operations can be scheduled in parallel, you don't know how many might complete at any given time. All you do know is that this number is at most equal to the number of available machines $m$. The sum of all penalty values for operations completed at time $t$ is then in the range $[0, ~m \cdot c_t]$. You want to avoid situations were completing a single operation at time $t+1$ is less expensive than m operations at time $t$. Thus, the penalty values cannot follow a simple linear function of time.

Precisely, you want your coefficients to satisfy:

$$ c_{t+1} > m \cdot c_{t} $$

For a suitable parameter $\epsilon > 0$, you can then solve the following recurrence relation:

$$ c_{t+1} = m \cdot c_{t}+\epsilon $$

The simplest solution is given by the function:

$$ c_{t} = \epsilon \cdot \frac{m^t-1}{m-1} $$

#### Limiting the number of terms

Great! You now have a formula for the coefficients of the makespan penalty terms that increase with time while taking into account that operations can be scheduled in parallel. Before implementing the new terms, let's try to limit the number of new terms you're adding as much as possible. To illustrate, recall the job shop example you've been working on:

$$J_{0} = \{O_{0}, O_{1}\}$$
$$J_{1} = \{O_{2}, O_{3}\}$$
$$J_{2} = \{O_{4}, O_{5}\}$$

First, consider that you only need the last operation in every job, as the precedence constraint guarantees that all other operations are completed before it. Given $n$ jobs, you then only consider the operations $\{O_{k_0-1}, O_{k_1-1}, \dots, O_{k_{n-1}-1}\}$. The indices $k_j$ denote the number of operations up to and including job $j$. In this example, you only add terms for the following operations:

$$ \{O_1, O_3, O_5\} $$

$$ \text{with } k_0 = 2, k_1 = 4, k_2 = 6 $$

Next, you can find a lower bound for the makespan and only penalize makespans that are greater than this minimum. A simple lower bound is given by the longest job, as each operation within a job must execute sequentially. You can express this lower bound as follows:

$$ M_{lb} = \max\limits_{0 \leq j \lt n} \{ \sum_{i = k_j}^{k_{j+1}-1} p_i \} \leq M $$

For the processing times given in this example, you get:

$$J_{0}: p_0 + p_1 = 2 + 1 = 3 $$
$$J_{1}: p_2 + p_3 = 2 + 2 = 4 $$
$$J_{2}: p_4 + p_5 = 1 + 2 = 3 $$

$$\Rightarrow M_{lb} = 4$$

Finally, the makespan is upper-bounded by the sequential execution time of all jobs, $3 + 4 + 3 = 10$ in this case. The simulation time $T$ should never exceed this upper bound! Regarding the penalty terms, you need to include terms for all time steps up to $T$, or else larger time steps without a penalty will be favored over smaller ones!

To summarize:

- Makespan penalty terms are only added for the last operation in every job $\{O_{k_0-1}, O_{k_1-1}, \dots, O_{k_{n-1}-1}\}$
- The makespan is lower-bounded by the longest job $\Rightarrow$ only include terms for time steps $M_{lb} < t < T$

#### Implementing the penalty terms

You are now ready to add the makespan terms to the cost function. Recall that all terms contain a coefficient and one (or multiple) binary decision variables $x_{i,t}$. Contrary to the coefficients $c_t$ defined above, where $t$ refers to the completion time of an operation, the variables $x_{i,t}$ determine if an operation $i$ is *scheduled* at time t. To account for this difference, you'll have to shift the variable index by the operation's processing time $p_i$. All makespan terms can then be expressed as follows:

$$ k(x) = \sum_{i \in \{k_0-1, \dots, k_{n-1}-1\}} \left( \sum_{M_{lb} < t < T+p_i} c_t \cdot x_{i, ~t-p_i} \right) $$

Lastly, you need to make a small modification to the coefficient function so that the first value $c_{M_{lb}+1}$ always equals one. With $\epsilon = 1$ and $t_0 = M_{lb}$ you get:

$$ c_{t} = \frac{m^{t-t_0}-1}{m-1} $$

#### Code

The code below implements the ideas discussed above by generating the necessary `Term` objects required by the solver.

```python
# Reminder of the relevant parameters
## Allowed time (jobs can only be scheduled below this limit)
T = 10 

## Processing time for each operation
processing_time = {0: 2, 1: 1, 2: 2, 3: 2, 4: 1, 5: 2}

## Assignment of operations to jobs (job ID: [operation IDs])
jobs_ops_map = {
    0: [0, 1], # Restart life support
    1: [2, 3], # Recalibrate navigation system
    2: [4, 5]  # Replace power transformer in the reactor
}

def calc_penalty(t:int, m_count:int, t0:int): 
    assert m_count > 1                           # Ensure you don't divide by 0
    return (m_count**(t - t0) - 1)/float(m_count - 1)

def makespan_objective(T:int, processing_time:dict, jobs_ops_map:dict, m_count:int, weight:float):
    """
    Construct makespan minimization terms.

    Keyword arguments:

    T (int): Allowed time (jobs can only be scheduled below this limit)
    processing_time (dict): Operation processing times
    jobs_ops_map (dict): Map of jobs to operations {job: [operations]}
    m_count (int): Number of machines
    weight (float): Relative importance of this constraint
    """

    terms = []

    lower_bound = max([sum([processing_time[i] for i in job]) for job in jobs_ops_map.values()])
    upper_bound = T

    # Loop through the final operation of each job
    for job in jobs_ops_map.values():
        i = job[-1]
        # Loop through each time step the operation could be completion at
        for t in range(lower_bound + 1, T + processing_time[i]):
            terms.append(Term(c=weight*(calc_penalty(t, m_count, lower_bound)), indices=[i*T + (t - processing_time[i])]))

    return terms
```
