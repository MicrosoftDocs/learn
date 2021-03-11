In this unit, the no-overlap constraint will be defined, and you will learn how to represent it mathematically and then transform it to code.

The no-overlap constraint is defined as follows:

| Constraint | Penalty condition |
|---|---|
|**No-overlap constraint**<br>Machines can only do one thing at a time.|Assign penalty every time two operations on a single machine are scheduled to run at the same time.|

## Worked example

For this final constraint, $J_{1}$ will once again be used as an example:

- $J_{1}$: Recalibrate navigation system
  - $O_{2}$: Reboot the system (*2 minutes*) - **ship computer**
  - $O_{3}$: Locate the three nearest stellar landmarks (*2 minutes*) - **ship computer**

Recall once more the variable $x_{i,t}$:

$$\text{If } x_{i,t} = 1, \text{ } O_i\text{ starts at time } \textit{t}$$
$$\text{If } x_{i,t} = 0, \text{ } O_i\text{ does not start at time } \textit{t}$$

$O_{2}$ and $O_{3}$ must be completed using the same machine - the ship computer. You can't do two things at the same time using the same machine, so to avoid violating the no-overlap constraint you must ensure that $O_{2}$ and $O_{3}$ begin at different times: $x_{2,t}$ and $x_{3,t}$ must not equal 1 at the same time. You must also make sure that the operations don't overlap, just like you saw in the precedence constraint. This means that if $O_{2}$ starts at time $t$, $O_{3}$ must not start at times where $t \leq s < t + p_{2}$ (after $O_{2}$ has started but before it has been completed using the machine).

One example of a valid configuration is shown below:

|$t$|$x_{2,t}$|$x_{3,t}$|$x_{2,t} \cdot x_{3,t}$|
|---|---|---|---|
|0|1|0|0|
|1|0|0|0|
|2|0|1|0|
|||$\sum_{t} x_{2,t} \cdot x_{3,t} =$|0|
|||**Valid configuration?**|✔|

As you can see, when you compare $x_{i,t}$ values pairwise at each time step, their product always equals 0. Further to this, you can see that $O_{3}$ starts two time steps after $O_{2}$, which means that there is no overlap.

Below, you see a configuration that violates the constraint:

|$t$|$x_{2,t}$|$x_{3,t}$|$x_{2,t} \cdot x_{3,t}$|
|---|---|---|---|
|0|0|0|0|
|1|1|1|1|
|2|0|0|0|
|||$\sum_{t} x_{2,t} \cdot x_{3,t} =$|1|
|||**Valid configuration?**|✘|

In this instance, $O_{2}$ and $O_{3}$ are both scheduled to start at $t = 1$ and given they require the same machine, this means that the constraint has been violated. The pairwise product of $x_{i,t}$ values is therefore no longer always equal to 0, as for $t = 1$ you have: $x_{2,1} \cdot x_{3,1} = 1$.

Another example of an invalid configuration is demonstrated below:

|$t$|$x_{2,t}$|$x_{3,t}$|$x_{2,t} \cdot x_{3,t}$|
|---|---|---|---|
|0|1|0|0|
|1|0|1|0|
|2|0|0|0|
|||$\sum_{t} x_{2,t} \cdot x_{3,t} =$|0|
|||**Valid configuration?**|✘|

In the above scenario, the two operations' running times have overlapped ($t \leq s < t + p_{2}$), and therefore this configuration is not valid.

You can now use this knowledge to mathematically formulate the constraint.

## Penalty formulation

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

## Code

Using the above, you can transform the final penalty function into code that will generate the terms needed by the solver. As with the previous two penalty functions, the `weight` is included in the definition of the `Term` objects:

```python
# Reminder of the relevant parameters
## Allowed time (jobs can only be scheduled below this limit)
T = 10 

## Processing time for each operation
processing_time = {0: 2, 1: 1, 2: 2, 3: 2, 4: 1, 5: 2}

## Assignment of operations to jobs (operation ID: job ID)
ops_jobs_map = {0: 0, 1: 0, 2: 1, 3: 1, 4: 2, 5: 2}

## Assignment of operations to machines
### Three jobs, two machines
machines_ops_map = {
    0: [0, 1, 4, 5], # Operations 0, 1, 4 and 5 are assigned to machine 0 (the universal multi-tool)
    1: [2, 3]        # Operations 2 & 3 are assigned to machine 1 (the ship computer)
}

def no_overlap_constraint(T:int, processing_time:dict, ops_jobs_map:dict, machines_ops_map:dict, weight:float):
    """
    Construct penalty terms for the no overlap constraint.

    Keyword arguments:

    T (int): Allowed time (jobs can only be scheduled below this limit)
    processing_time (dict): Operation processing times
    weight (float): Relative importance of this constraint
    ops_jobs_map (dict): Map of operations to jobs {op: job}
    machines_ops_map(dict): Mapping of operations to machines, e.g.:
        machines_ops_map = {
            0: [0,1],          # Operations 0 & 1 assigned to machine 0
            1: [2,3]           # Operations 2 & 3 assigned to machine 1
        }
    """

    terms = []

    # For each machine
    for ops in machines_ops_map.values():
        # Loop over each operation i requiring this machine
        for i in ops:
            # Loop over each operation k requiring this machine 
            for k in ops:
                # Loop over simulation time
                for t in range(T):
                    # When i != k (when scheduling two different operations)
                    if i != k:
                        # t = s meaning two operations are scheduled to start at the same time on the same machine
                        terms.append(Term(c=weight*1, indices=[i*T+t, k*T+t]))

                        # Add penalty when operation runtimes overlap
                        for s in range(t, min(t + processing_time[i], T)):
                            terms.append(Term(c=weight*1, indices=[i*T+t, k*T+s]))  

                        # If operations are in the same job, penalize for the extra time 0 -> t (operations scheduled out of order)
                        if ops_jobs_map[i] == ops_jobs_map[k]:
                            for s in range(0, t):
                                if i < k:
                                    terms.append(Term(c=weight*1, indices=[i*T+t, k*T+s]))  
                                if i > k:
                                    terms.append(Term(c=weight*1, indices=[i*T+s, k*T+t]))  

    return terms
```
