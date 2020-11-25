In this section, the no overlap constraint will be defined, and you will learn how to represent it mathematically and then transform it to code.

The no overlap constraint is defined as follows:

| Constraint | Penalty condition |
|---|---|
|**No overlap constraint**<br>Machines can only do one thing at a time.|Assign penalty every time two operations on a single machine are scheduled to run at the same time.|

### Worked example

For this final constraint, $J_{1}$ will once again be used as an example:

- $J_{1}$: Recalibrate navigation system
  - $0_{2}$: Reboot the system (*2 minutes*)
  - $0_{3}$: Locate the three nearest stellar landmarks (*2 minutes*)

Recall once more the variable $x_{i,t}$:

$$\text{If } x_{i,t} = 1, \text{ } O_i\text{ starts at time } \textit{t}$$
$$\text{If } x_{i,t} = 0, \text{ } O_i\text{ does not start at time } \textit{t}$$

Let's say that $O_{3}$ and $O_{4}$ must be completed using the same machine. To avoid violating the no overlap constraint, you must ensure that $O_{3}$ and $O_{4}$ begin at different times: $x_{3,t}$ and $x_{4,t}$ must not equal 1 at the same time.

One example of a valid configuration is shown below:

|$t$|$x_{3,t}$|$x_{4,t}$|$x_{3,t} \cdot x_{4,t}$|
|---|---|---|---|
|0|1|0|0|
|1|0|1|0|
|2|0|0|0|
|||$\sum_{t} x_{3,t} \cdot x_{4,t} =$|0|
|||**Valid configuration?**|✔|

As you can see, when you compare $x_{i,t}$ values pairwise at each time in the simulation, their product always equals 0.

Below, you see a configuration that violates the constraint:

|$t$|$x_{3,t}$|$x_{4,t}$|$x_{3,t} \cdot x_{4,t}$|
|---|---|---|---|
|0|0|0|0|
|1|1|1|1|
|2|0|0|0|
|||$\sum_{t} x_{3,t} \cdot x_{4,t} =$|1|
|||**Valid configuration?**|✘|

In this instance, $O_{3}$ and $O_{4}$ are both scheduled to start at $t = 1$ and given they require the same machine, this means that the constraint has been violated. The pairwise product of $x_{i,t}$ values is therefore no longer always equal to 0, as for $t = 1$ we have: $x_{3,1} \cdot x_{4,1} = 1$

You can now use this knowledge to mathematically formulate the constraint.

### Penalty formulation

As you saw from the tables in the worked example, for the configuration to be valid, the sum of pairwise products of $x_{i,t}$ values for a machine $m$ at any time $t$ must equal 0. This gives you the penalty function:

$$h(x) = \sum_{i,t,k,s} x_{i,t}\cdot x_{k,s} = 0 \text{ for each machine } \textit{m}$$

Let's break that down:

- $\sum_{i,t,k,s}$

  For operation $i$ starting at time $t$, and operation $k$ starting at time $s$, you need to sum over all possible start times $0 \leq t < T$ and $0 \leq s < T$. This indicates the need for another nested `for` loop, like you saw for the precedence constraint.
  
  For this summation, $i \neq k$ (you should always be scheduling two different operations).
  
  For two operations happening on a single machine, $t \neq s$ or the constraint has been violated. If $t = s$ for the operations, they have been scheduled to start on the same machine at the same time, which isn't possible.


- $x_{i,t}\cdot x_{k,s}$

  This is the product you saw explicitly calculated in the rightmost columns of the tables from the worked example. If two different operations $i$ and $k$ start at the same time ($t = s$), this product will equal 1. Otherwise, it will equal 0.
  

- $\sum(\dots) = 0 \text{ for each machine } \textit{m}$

  This sum is performed for each machine $m$ independently.
  
  If all $x_{i,t} \cdot x_{k,s}$ products in the summation equal 0, the total sum comes to 0. This means no operations have been scheduled to start at the same time on this machine and thus the constraint has not been violated. You can see an example of this in the bottom row of the first table from the worked example, above.
  
  If any of the $x_{i,t} \cdot x_{k,s}$ products in the summation equal 1, this means that $t = s$ for those operations and therefore two operations have been scheduled to start at the same time on the same machine. The sum now returns a value greater than 1, which gives us a penalty every time the constraint is violated. You can see an example of this in the bottom row of the second table from the worked example.
  
### Code

Using the above, you can transform the final penalty function into code that will generate the terms needed by the solver. As with the previous two penalty functions, the weight `w` is included in our definition of the `Term` objects:

```python
def no_overlap_constraint(n:int, T:int, p:List[int], w:float, ops_machines_map:List[List[int]]):
    """
    Construct penalty terms for the no overlap constraint.

    Keyword arguments:

    n (int): Total number of jobs
    T (int): Time allowed to complete all operations
    p (List[int]): List of job processing times
    w (float): Relative weight of this constraint (the coefficient)
    ops_machine_map(List[List[int]]): Mapping of operations to machines, e.g.:
        ops_machines_map = [
            [0,1],          # Operations 0 & 1 assigned to machine 0
            [2,3]           # Operations 2 & 3 assigned to machine 1
        ]
    """

    terms = []

    # For each machine
    for m in range(len(ops_machines_map)):
        # Get operations assigned to this machine
        ops = ops_machines_map[m]

        # Loop over each operation i requiring this machine
        for i in range(len(ops)):
            # Loop over each other operation k requiring this machine 
            for k in range(len(ops)):
                # Loop over simulation time
                for t in range(T):
                    # When i != k (when you are scheduling two different operations)
                    if ops[i] != ops[k]:
                        # t = s - two operations scheduled to start at the same time on the same machine
                        terms.append(Term(w = w*1, indices = [ops[i]*T+t, ops[k]*T+t]))

                    # When i < k, add penalty when O_k starts before O_i has finished
                    if ops[i] < ops[k]:
                        for s in range(0, t + p[ops[i]] - 1):
                            terms.append(Term(w = w*1, indices = [ops[i]*T+t, ops[k]*T+s]))
    return terms
```
