In this section, the precedence constraint will be defined, and you will learn how to represent it mathematically and then transform it to code.

The precedence constraint is defined as follows:

| Constraint | Penalty condition |
|---|---|
|**Precedence constraint**<br>Operations in a job must take place in order.|Assign penalty every time $O_{i+1}$ starts before $O_{i}$ has finished (they start out of order).|

### Worked example

Let's take job 1 ($J_{1}$) as an example:

- $J_{1}$: Recalibrate navigation system
  - $O_{2}$: Reboot the system (*2 minutes*)
  - $O_{3}$: Locate the three nearest stellar landmarks (*2 minutes*)

Let's formulate the penalty conditions for $O_{3}$ and $O_{4}$: you want to add a penalty if $O_{4}$ starts before $O_{3}$ finishes. First, you'll define the terms and set some of their values:

$$\text{Total simulation time } T = 4$$
$$O_{3} \text{ processing time: } p_{3} = 2$$
$$O_{3} \text{ starts at time } \textit{t} \text{, and finishes at time } t+p_{3}$$

$$O_{3} \text{ starts at any time } 0 \leq t < T $$
$$O_{4} \text{ can start at time } s \geq t + p_{3} $$

$O_{3}$’s finishing time is given by adding its processing time $p_{3}$ (which is 2 minutes) to its start time $t$. You can see the start and end times for $O_{3}$ in the table below:

| $t$ | $t = p_{3}$|
|---|---|
|0|2|
|1|3|
|2|4|

To avoid violating this constraint, the start time of $O_{4}$ (denoted by $s$) must be greater than or equal to the end time of $O_{3}$, like you see in the next column:

| $t$ | $t = p_{3}$|$s \geq t+p_{3}$|
|---|---|---|
|0|2|2, 3, 4|
|1|3|3, 4|
|2|4|4|
||**Valid configuration?**|✔|

The ✔ means that any $s$ value in this column is valid, as it doesn't violate the precedence constraint.

Conversely, if $s$ is less than $t + p_{3}$ (meaning $O_{4}$ starts before $O_{3}$ finishes), you need to add a penalty. Invalid $s$ values for this example are shown in the rightmost column:

| $t$ | $t = p_{3}$|$s \geq t+p_{3}$|$s < t+p_{3}$|
|---|---|---|---|
|0|2|2, 3, 4|0, 1|
|1|3|3, 4|0, 1, 2|
|2|4|4|0, 1, 2, 3|
||**Valid configuration?**|✔|✘|

In the table above, ✘ has been used to denote that any $s$ value in the last column is invalid, as it violates the precedence constraint.

### Penalty formulation

This is formulated as a penalty by counting every time consecutive operations $O_{i}$ and $O_{i + 1}$ in a job take place out of order.
  
As you saw above: for an operation $O_{i}$, if the start time of $O_{i + 1}$ (denoted by $s$) is less than the start time of $O_{i}$ (denoted by $t$) plus its processing time $p_{i}$, then that counts as a penalty. Mathematically, this penalty condition looks like: $s < t + p_{i}$

You sum that penalty over all the operations of a job ($J_{n}$) for all the jobs:
$$f(x) = \sum_{k_{n-1} \leq i < k_n, s < t + p_{i}}x_{i,t}\cdot x_{i+1,s} \text{ for each job } \textit{n}$$

Let's break that down:

- $k_{n-1} \leq i < k_{n}$

  This means you sum over all operations for a single job.


- $s < t + p_{i}$

  This is the penalty condition - any operation that satisfies this condition is in violation of the precedence constraint.
  

- $x_{i, t}\cdot x_{i+1, s}$
  
  This represents the table you saw in the example above, where $t$ is allowed to vary from $0 \rightarrow T$ and you assign a penalty whenever the constraint is violated (when $s < t + p_{i}$).
  
  This translates to a nested `for` loop: the outer loop has limits $0 \leq t < T$ and the inner loop has limits $0 \leq s < t + p_{i}$

### Code

Using the mathematical formulation and the breakdown above, you can now translate this constraint function to code. You will see the weight term `w` included in this code snippet - this will be assigned a value later on when we call the function:

```python
def precedence_constraint(n: int, o:int, T:int, p:List[int], w:float):
    """
    Construct penalty terms for the precedence constraint.

    Keyword arguments:

    n (int): Total number of jobs
    o (int): Number of operations per job
    T (int): Time allowed to complete all operations
    p (List[int]): List of job processing times
    w (float): Relative weight of this constraint
    """

    terms = []
    j = 0

    # Loop through all jobs:
    while(j < n):
        # Loop through all operations in this job:
        for i in range(j, j + o - 1):
            # Loop through simulation time:
            for t in range(0, T):
                # Loop over times that would violate the constraint:
                for s in range(0, t + p[i]):
                    # Assign penalty
                    terms.append(Term(w = w*1, indices = [i*T+t, (i+1)*T+s]))
        j = j + o
    return terms
```

>Note: This nested loop structure is probably not the most efficient way to do this but it is the most direct comparison to the mathematical formulation.
