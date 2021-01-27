In this unit, the precedence constraint will be defined, and you will learn how to represent it mathematically and then transform it to code.

The precedence constraint is defined as follows:

| Constraint | Penalty condition |
|---|---|
|**Precedence constraint**<br>Operations in a job must take place in order.|Assign penalty every time $O_{i+1}$ starts before $O_{i}$ has finished (they start out of order).|

### Worked example

Let's take job 1 ($J_{1}$) as an example:

- $J_{1}$: Recalibrate navigation system
  - $O_{2}$: Reboot the system (*2 minutes*)
  - $O_{3}$: Locate the three nearest stellar landmarks (*2 minutes*)

Let's formulate the penalty conditions for $O_{2}$ and $O_{3}$: you want to add a penalty if $O_{3}$ starts before $O_{2}$ finishes. First, you'll define the terms and set some of their values:

$$\text{Total allowed time } T = 4$$
$$O_{2} \text{ processing time: } p_{2} = 2$$
$$O_{2} \text{ starts at time } \textit{t} \text{, and finishes at time } t+p_{2}$$

$$O_{2} \text{ starts at any time } 0 \leq t < T $$
$$O_{3} \text{ can start at time } s \geq t + p_{2} $$

$O_{2}$’s finishing time is given by adding its processing time $p_{2}$ (which is 2 minutes) to its start time $t$. You can see the start and end times for $O_{2}$ in the table below:

| $t$ | $t + p_{2}$|
|---|---|
|0|2|
|1|3|
|2|4|

To avoid violating this constraint, the start time of $O_{3}$ (denoted by $s$) must be greater than or equal to the end time of $O_{2}$, like you see in the next column:

| $t$ | $t + p_{2}$|$s \geq t+p_{2}$|
|---|---|---|
|0|2|2, 3, 4|
|1|3|3, 4|
|2|4|4|
||**Valid configuration?**|✔|

The ✔ means that any $s$ value in this column is valid, as it doesn't violate the precedence constraint.

Conversely, if $s$ is less than $t + p_{2}$ (meaning $O_{3}$ starts before $O_{2}$ finishes), you need to add a penalty. Invalid $s$ values for this example are shown in the rightmost column:

| $t$ | $t + p_{2}$|$s \geq t+p_{2}$|$s < t+p_{2}$|
|---|---|---|---|
|0|2|2, 3, 4|0, 1|
|1|3|3, 4|0, 1, 2|
|2|4|4|0, 1, 2, 3|
||**Valid configuration?**|✔|✘|

In the table above, ✘ has been used to denote that any $s$ value in the last column is invalid, as it violates the precedence constraint.

### Penalty formulation

This is formulated as a penalty by counting every time consecutive operations $O_{i}$ and $O_{i + 1}$ in a job take place out of order.
  
As you saw above: for an operation $O_{i}$, if the start time of $O_{i + 1}$ (denoted by $s$) is less than the start time of $O_{i}$ (denoted by $t$) plus its processing time $p_{i}$, then that counts as a penalty. Mathematically, this penalty condition looks like: $s < t + p_{i}$.

You sum that penalty over all the operations of a job ($J_{n}$) for all the jobs:
$$f(x) = \sum_{k_{n-1} \leq i < k_n, s < t + p_{i}}x_{i,t}\cdot x_{i+1,s} \text{ for each job } \textit{n}.$$

Let's break that down:

- $k_{n-1} \leq i < k_{n}$

  This means you sum over all operations for a single job.

- $s < t + p_{i}$

  This is the penalty condition - any operation that satisfies this condition is in violation of the precedence constraint.

- $x_{i, t}\cdot x_{i+1, s}$

  This represents the table you saw in the example above, where $t$ is allowed to vary from $0 \rightarrow T - 1$ and you assign a penalty whenever the constraint is violated (when $s < t + p_{i}$).

  This translates to a nested `for` loop: the outer loop has limits $0 \leq t < T$ and the inner loop has limits $0 \leq s < t + p_{i}$

### Code

Using the mathematical formulation and the breakdown above, you can now translate this constraint function to code. You will see the `weight` argument included in this code snippet - this will be assigned a value later on when you call the function:

```python
# Reminder of the relevant parameters
## Time to allow for all jobs to complete
T = 10 

## Processing time for each operation
processing_time = {0: 2, 1: 1, 2: 2, 3: 2, 4: 1, 5: 2}

## Assignment of operations to jobs (job ID: [operation IDs])
jobs_ops_map = {
    0: [0, 1], # Restart life support
    1: [2, 3], # Recalibrate navigation system
    2: [4, 5]  # Replace power transformer in the reactor
}

def precedence_constraint(jobs_ops_map:dict, T:int, processing_time:dict, weight:float):
    """
    Construct penalty terms for the precedence constraint.

    Keyword arguments:

    jobs_ops_map (dict): Map of jobs to operations {job: [operations]}
    T (int): Allowed time (jobs can only be scheduled below this limit)
    processing_time (dict): Operation processing times
    weight (float): Relative importance of this constraint
    """

    terms = []

    # Loop through all jobs:
    for ops in jobs_ops_map.values():
        # Loop through all operations in this job:
        for i in range(len(ops) - 1):
            for t in range(0, T):
                # Loop over times that would violate the constraint:
                for s in range(0, min(t + processing_time[ops[i]], T)):
                    # Assign penalty
                    terms.append(Term(c=weight, indices=[ops[i]*T+t, (ops[i+1])*T+s]))

    return terms
```

> [!NOTE]
> This nested loop structure is probably not the most efficient way to do this but it is the most direct comparison to the mathematical formulation.
