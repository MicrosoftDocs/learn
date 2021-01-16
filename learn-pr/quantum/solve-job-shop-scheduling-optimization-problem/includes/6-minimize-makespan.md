In this unit, you will learn how to minimize the makespan of the solution (the time taken to complete all operations).

### Minimizing the makespan

So far you've learned how to represent constraints of your optimization problem with a penalty model, which allows you to obtain *valid* solutions to your problem from the optimizer. Remember however that our end goal is to obtain an *optimal* (or close to optimal) solution. In our case, we're looking for a schedule with the fastest completion time of all jobs.

The makespan $M$ is defined as the total time required to run all jobs, or alternatively, the finishing time of the last job, which we want to minimize. To this end, we will be adding a fourth component to our cost function that penalizes a solution the larger the makespan is:

$$ H(x) = \alpha \cdot f(x) + \beta \cdot g(x) + \gamma \cdot h(x) + \mathbf{\boldsymbol{\delta} \cdot k(x)} $$

Let's come up with terms that increase the value of the cost function the further out the last job is completed. Remember that the completion time of a job depends solely on the completion time of its final operation. However, since we have no way of knowing in advance what the last job will be, or at which time the last operation will finish, we'll need to include a term for each operation and time step. These terms need to scale with the time parameter $t$, and consider the operation processing time, in order to penalize large makespans over smaller ones.

Some care is required in determining the penalty values, or *coefficients*, of these terms. Recall that we are given a set of operations $\{O_i\}$, which each take time $p_i$ to complete. An operation scheduled at time $t$ will then *complete* at time $t+p_i$. Let's define the coefficient $w_t$ as the penalty applied to the cost function for an operation to finish at time $t$. As operations can be scheduled in parallel, we don't know how many might complete at any given time, but we do know that this number is at most equal to the number of available machines $m$. The sum of all penalty values for operations completed at time $t$ are thus in the range $[0, ~m \cdot w_t]$. We want to avoid situations were completing a single operation at time $t+1$ is less expensive than m operations at time $t$. Thus, the penalty values cannot follow a simple linear function of time.

Precisely, we want our coefficients to satisfy:
$$ w_{t+1} > m*w_{t} $$

For a suitable parameter $\epsilon > 0$, we can then solve the following recurrence relation:
$$ w_{t+1} = m*w_{t}+\epsilon $$

The simplest solution is given by the function:
$$ w_{t} = \epsilon * \frac{m^t-1}{m-1} $$

#### Limiting the number of terms

Great! We now have a formula for the coefficients of the makespan penalty terms that increase with time while taking into account that operations can be scheduled in parallel. Before implementing the new terms, let's try to limit the amount of new terms we're adding as much as possible. To illustrate, recall the job shop example we've been working on:

$$
\begin{align}
J_{0} &= \{O_{0}, O_{1}, O_{2}\} \\
J_{1} &= \{O_{3}, O_{4}, O_{5}\} \\
J_{2} &= \{O_{6}, O_{7}, O_{8}, O_{9}\} \\
\end{align}
$$

First, consider that we only need the last operation in every job, as the precendece constraint guarantees that all other operations are completed before it. Given $n$ jobs, we thus consider only the operations $\{O_{k_0-1}, O_{k_1-1}, \dots, O_{k_{n-1}-1}\}$, where the indices $k_j$ denotes the number of operations up to and including job $j$. In our example, we only add terms for the following operations:

$$ \{O_2, O_5, O_9\} $$

$$ \text{with } k_0 = 3, k_1 = 6, k_2 = 10 $$

Next, we can find a lower bound for the makespan and only penalize makespans that are greater than this minimum. A simple lower bound is given by the longest job, as each operation within a job must execute sequentially. We can express this lower bound as follows:

$$ M_{lb} = \max\limits_{0 \leq j \lt n} \{ \sum_{i = k_j}^{k_{j+1}-1} p_i \} \leq M $$

For the processing times given in our example, we get:

$$
\begin{align}
J_{0} &: ~~ p_0 + p_1 + p_2 = 2 + 1 + 3 = 6 \\
J_{1} &: ~~ p_3 + p_4 + p_5 = 2 + 2 + 3 = 7 \\
J_{2} &: ~~ p_6 + p_7 + p_8 + p_9 = 1 + 2 + 3 + 2 = 8 \\
\\
&\Rightarrow M_{lb} = 8
\end{align}
$$

Finally, the makespan is upper-bounded by the sequential execution time of all jobs, 6 + 7 + 8 = 21 in this case. The time T should never exceed this upper bound. Regardless of whether this is the case or not, we need to include penalties for all time steps up to T, or else larger time steps without a penalty will be favored over smaller ones!

To summarize:

- Makespan penalty terms are only added for the last operation in every job $\{O_{k_0-1}, O_{k_1-1}, \dots, O_{k_{n-1}-1}\}$
- The makespan is lower-bounded by the longest job $\Rightarrow$ only include terms for time steps $M_{lb} < t < T$

#### Implementing the penalty terms

We are ready to add the makespan terms to the cost function. Recall that all terms contain a coefficient and one (or multiple) binary decision variables $x_{i,t}$. Contrary to the coefficients $w_t$ we defined above, where $t$ refers to the completion time of an operation, the variables $x_{i,t}$ determine if an operation $i$ is *scheduled* at time t. To account for this difference, we'll have to shift the variable index by the operation's processing time $p_i$. All makespan terms can then be expressed as follows:

$$ k(x) = \sum_{i \in \{k_0-1, \dots, k_{n-1}-1\}} \left( \sum_{M_{lb} < t < T+p_i} w_t \cdot x_{i, ~t-p_i} \right) $$

Lastly, we make a small modification to the coefficient function so that the first value $w_{M_{lb}+1}$ always equals one. With $\epsilon = 1$ and $t_0 = M_{lb}$ we get:

$$ w_{t} = \frac{m^{t-t_0}-1}{m-1} $$

#### Code

The code below implements the ideas discussed above by generating the necessary `Term` objects required by the solver.

```python
def calc_penalty(t:int, m:int, t0:int): 
    assert m>1                           # Ensure we don't divide by 0 
    return (m**(t-t0) - 1)/float(m - 1)

def makespan_objective(T:int, p:dict, jobs_ops_map:dict, m:int, w:float):
    """
    Construct makespan minimization terms.

    Keyword arguments:
    
    T (int): Time allowed to complete all operations
    p (dict): Operation processing times
    jobs_ops_map (dict): Map of jobs to operations {job: [operations]}
    m (int): Number of machines
    w (float): Relative weight of this constraint (the coefficient)
    """
    
    terms = []
    
    lower_bound = max([sum([p[i] for i in job]) for job in jobs_ops_map.values()])
    upper_bound = T
    
    # Loop through the final operation of each job
    for job in jobs_ops_map.values():
        i = job[-1]
        # Loop through each time step the operation could be completion at
        for t in range(lower_bound+1, T+p[i]):
            terms.append(Term(w = w*(calc_penalty(t,m,lower_bound)), indices = [i*T+(t-p[i])]))

    return terms
```
