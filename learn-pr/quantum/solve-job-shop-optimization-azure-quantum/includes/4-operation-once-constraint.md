In this unit, the operation-once constraint is defined. You learn how to represent it mathematically and then transform it to code.

The operation-once constraint is defined as follows:

|                               | Description                                   | Penalty condition |
|:------------------------------|:----------------------------------------------|:------------------|
| **Operation-once constraint** | Each operation is started once and only once. | Assign penalty if an operation isn't scheduled within the allowed time. Assumption: if an operation starts, it runs to completion. |

## Implement operation-once constraint

Again, job 1 ($J_{1}$) is the example:

- $J_{1}$: Recalibrate navigation system
  - $O_{2}$: Reboot the system (*2 minutes*)
  - $O_{3}$: Locate the three nearest stellar landmarks (*2 minutes*)

Recall the variable $x_{i,t}$:

$$\text{If } x_{i,t} = 1, \text{ } O_i\text{ starts at time } \textit{t}$$
$$\text{If } x_{i,t} = 0, \text{ } O_i\text{ does not start at time } \textit{t}$$

According to this constraint, $x_{i,t}$ for a specific operation should equal 1 *once and only once* from $t = 0 \rightarrow T - 1$. It should start once and only once during the allowed time.

In this case, you need to assign a penalty if the sum of $x_{i,t}$ for each operation across all allowed times doesn't equal exactly 1.

Take $O_{2}$ as an example again:

|$t$|$x_{2,t}$|
|---|---|
|0|0|
|1|1|
|2|0|
|$\sum_t {x_{2,t}} =$|1|
|**Valid configuration?**|✔|

In the second column, you see that $O_{2}$ starts at time 1 and no other time. $x_{2,t} = 1$ at time $t = 1$ and is $0$ otherwise. The sum of $x_{i,t}$ values over all $t$ for this example is 1, which is what is expected! This solution is therefore valid.

In the next example, you see an instance where $O_{2}$ is scheduled more than once. $x_{2,t} = 1$ more than once, in violation of the constraint:

|$t$|$x_{2,t}$|
|---|---|
|0|0|
|1|1|
|2|1|
|$\sum_t {x_{2,t}} =$|2|
|**Valid configuration?**|✘|

You can see from this table that $O_{2}$ has been scheduled to start at both time 1 and time 2, so the sum of $x_{2,t}$ values over all $t$ is now greater than 1. This arrangement violates the constraint and thus you must apply a penalty.

In the last example, you see an instance where $O_{2}$ hasn't been scheduled at all:

|$t$|$x_{2,t}$|
|---|---|
|0|0|
|1|0|
|2|0|
|$\sum_t {x_{2,t}} =$|0|
|**Valid configuration?**|✘|

In this example, none of the $x_{2,t}$ values equal 1 for any time step, meaning that the operation is never scheduled. The sum of $x_{2,t}$ values over all $t$ is 0. The constraint is once again violated and you must allocate a penalty.

In summary:

|$t$|$x_{2,t}$|$x_{2,t}$|$x_{2,t}$|
|---|---|---|---|
|0|0|0|0|
|1|1|1|0|
|2|0|1|0|
|$\sum_t {x_{2,t}} =$|1|2|0|
|**Valid configuration?**|✔|✘|✘|

Now that you understand when to assign penalties, you can formulate the constraint mathematically.

## Penalty formulation

As seen previously, you want to assign a penalty whenever the sum of $x_{i,t}$ values across all possible $t$ values isn't equal to 1. This expression is how you represent that mathematically:

$$g(x) = \sum_{i} \left(\left(\sum_{0\leq t < T} x_{i,t}\right) - 1\right)^2.$$

To break that expression down:

- $\left(\sum_{0\leq t < T} x_{i,t}\right) - 1$

  As you saw in the sum row of the tables in the example, $\sum_{0\leq t < T} x_{i,t}$ should always equal exactly 1. This condition means that an operation must be scheduled *once and only once* during the allowed time. This fact means that $\left(\sum_{0\leq t < T} x_{i,t}\right) - 1$ should always give 0. There's no penalty assigned when the constraint isn't violated.

  In the case where $\sum_{0\leq t < T} x_{i,t} > 1$, meaning an operation is scheduled to start more than once, like in the second example, you now have a positive, non-zero penalty term as $\left(\sum_{0\leq t < T} x_{i,t}\right) - 1 > 0$.

  In the case where $\sum_{0\leq t < T} x_{i,t} = 0$, meaning an operation is never scheduled to start, like in the last example, you now have a $-1$ penalty term as $\left(\sum_{0\leq t < T} x_{i,t}\right) - 1 = 0 - 1 = -1$.

- $\left(\sum\dots\right)^2$

  Because the penalty terms must always be positive, you must square the result of $\left(\sum_{0\leq t < T} x_{i,t}\right) - 1$.

  This approach ensures that the penalty term is always positive because $(-1)^2 = 1$. Otherwise, you would be *reducing* the penalty when an operation isn't scheduled.

- $\sum_{i} \left((\dots)^2\right)$

  Lastly, you must sum all penalties accumulated across all operations $O_{i}$ from all jobs.

To translate this constraint to code form, you need to expand the quadratic equation in the sum.

To see how to expand it, once again take $O_{2}$ as an example. Set $T = 2$ so the $t$ values are 0 and 1. The first step is to substitute in these values:

$$\sum_{i} \left(\left(\sum_{0\leq t < T} x_{i,t}\right) - 1\right)^2 = \left(x_{2,0} + x_{2,1} - 1\right)^2$$

For simplicity, the $x_{2,t}$ variables are renamed as follows:

$$x_{2,0} = x$$
$$x_{2,1} = y$$

Substituting these values in, you now have the following expression:

$$\sum_{i} \left(\left(\sum_{0\leq t < T} x_{i,t}\right) - 1\right)^2 = \left(x_{2,0} + x_{2,1} - 1\right)^2$$
$$=\left(x + y - 1\right)^2$$

Next, you need to expand out the bracket and multiply each term in the first bracket with all terms in the other bracket:

$$\sum_{i} \left(\left(\sum_{0\leq t < T} x_{i,t}\right) - 1\right)^2 = \left(x_{2,0} + x_{2,1} - 1\right)^2$$
$$= \left(x + y - 1\right)^2$$
$$= (x + y - 1)\cdot(x + y - 1)$$
$$= x^2 + y^2 + 2xy - 2x - 2y + 1$$

The final step simplifies things a little. Because this problem is a binary optimization problem, $x$ and $y$ can only take the values of $0$ or $1$. Because of this fact, the following facts hold true:

$$x^2 = x$$
$$y^2 = y,$$

Because:

$$0^2 = 0$$
$$1^2 = 1$$

These facts mean that the quadratic terms in the penalty function can combine with the two linear terms, giving the following formulation of the penalty function:

$$\sum_{i} \left(\left(\sum_{0\leq t < T} x_{i,t}\right) - 1\right)^2 = x^2 + y^2 + 2xy - 2x - 2y + 1 $$
$$= x + y + 2xy - 2x - 2y + 1 $$
$$= 2xy - x - y + 1 $$

If $T$ was larger, you would have more terms, for example, $z$ and so on.

## Code

You can now use this expanded version of the penalty function to build the penalty terms in code. Again, the `weight` argument is included, to be assigned a value later on.

Select **+ Code** to add another new cell and add the following lines:

```python
"""
Reminder of the relevant parameters
Allowed time (jobs can only be scheduled below this limit)
T = 10

Assignment of operations to jobs (operation ID: job ID)
ops_jobs_map = {0: 0, 1: 0, 2: 1, 3: 1, 4: 2, 5: 2}
"""

def operation_once_constraint(ops_jobs_map:dict, T:int, weight:float):
    """
    Construct penalty terms for the operation once constraint.
    Penalty function is of form: 2xy - x - y + 1

    Keyword arguments:

    ops_jobs_map (dict): Map of operations to jobs {op: job}
    T (int): Allowed time (jobs can only be scheduled below this limit)
    weight (float): Relative importance of this constraint
    """

    terms = []

    # 2xy - x - y parts of the constraint function
    # Loop through all operations
    for op in ops_jobs_map.keys():
        for t in range(T):
            # - x - y terms
            terms.append(Term(c=weight*-1, indices=[op*T+t]))

            # + 2xy term
            # Loop through all other start times for the same job
            # to get the cross terms
            for s in range(t+1, T):
                terms.append(Term(c=weight*2, indices=[op*T+t, op*T+s]))

    # + 1 term
    terms.append(Term(c=weight*1, indices=[]))

    return terms
```
