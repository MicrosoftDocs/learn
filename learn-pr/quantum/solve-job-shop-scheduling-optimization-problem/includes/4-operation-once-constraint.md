In this section, the operation once constraint will be defined, and you will learn how to represent it mathematically and then transform it to code.

The operation once constraint is defined as follows:

| Constraint | Penalty condition |
|---|---|
|**Operation once constraint**<br>Each operation is started once and only once.|Assign penalty if an operation isn't scheduled within the allowed time.<br>**Assumption:** if an operation starts, it runs to completion.|

### Worked example

Again, job 1 ($J_{1}$) will be used as an example:

- $J_{1}$: Recalibrate navigation system
  - $0_{2}$: Reboot the system (*2 minutes*)
  - $0_{3}$: Locate the three nearest stellar landmarks (*2 minutes*)

Recall the variable $x_{i,t}$:

$$\text{If } x_{i,t} = 1, \text{ } O_i\text{ starts at time } \textit{t}$$
$$\text{If } x_{i,t} = 0, \text{ } O_i\text{ does not start at time } \textit{t}$$

According to this constraint, $x_{i,t}$ for a specific operation should equal 1 **once and only once** during the entire simulation from $t = 0 \rightarrow T$ (because it should start once and only once during the allowed time).

So in this case, you need to assign a penalty if the sum of $x_{i,t}$ for each operation across the full simulation time doesn’t equal exactly 1.

Let’s take $O_{3}$ as an example again:

|$t$|$x_{3,t}$|
|---|---|
|0|0|
|1|1|
|2|0|
|$\sum_t {x_{3,t}} =$|1|
|**Valid configuration?**|✔|

In the right-hand column, you see that $O_{3}$ starts at time 1 and no other time ($x_{3,t} = 1$ at time $t = 1$ and is $0$ otherwise). The sum of $x_{i,t}$ values over all $t$ for this example is therefore 1, which is what is expected! This is therefore a valid solution.

In the example below, you see an instance where $O_{3}$ is scheduled more than once ($x_{3,t} = 1$ more than once), in violation of the constraint:

|$t$|$x_{3,t}$|
|---|---|
|0|0|
|1|1|
|2|1|
|$\sum_t {x_{3,t}} =$|2|
|**Valid configuration?**|✘|

You can see from the above that $O_{3}$ has been scheduled to start at both time 1 and time 2, so the sum of $x_{i,t}$ values over all $t$ is now greater than 1. This violates the constraint and thus you must apply a penalty.

In the last example, you see an instance where $O_{3}$ has not been scheduled at all:

|$t$|$x_{3,t}$|
|---|---|
|0|0|
|1|0|
|2|0|
|$\sum_t {x_{3,t}} =$|0|
|**Valid configuration?**|✘|

In this example, none of the $x_{3,t}$ values equal 1 for any time in the simulation, meaning the operation is never scheduled. This means that the sum of $x_{3,t}$ values over all $t$ is 0 - the constraint is once again violated and you must allocate a penalty.

In summary:

|$t$|$x_{3,t}$|$x_{3,t}$|$x_{3,t}$|
|---|---|---|---|
|0|0|0|0|
|1|1|1|0|
|2|0|1|0|
|$\sum_t {x_{3,t}} =$|1|2|0|
|**Valid configuration?**|✔|✘|✘|

Now that you understand when to assign penalties, let's formulate the constraint mathematically.

### Penalty formulation

As seen previously, you want to assign a penalty whenever the sum of $x_{i,t}$ values across all possible $t$ values is not equal to 1. This is how you represent that mathematically:

$$g(x) = \sum_{i} \left(\left(\sum_{0\leq t < T} x_{i,t}\right) - 1\right)^2$$

Let's break that down:

- $\left(\sum_{0\leq t < T} x_{i,t}\right) - 1$

  As you saw in the sum row of the tables in the worked example, $\sum_{0\leq t < T} x_{i,t}$ should always equal exactly 1 (meaning that an operation must be scheduled **once and only once** during the simulation). This means that $\left(\sum_{0\leq t < T} x_{i,t}\right) - 1$ should always give 0. This means there is no penalty assigned when the constraint is not violated.
  
  In the case where $\sum_{0\leq t < T} x_{i,t} > 1$ (meaning an operation is scheduled to start more than once, like in the second example above), you now have a positive, non-zero penalty term as $\left(\sum_{0\leq t < T} x_{i,t}\right) - 1 > 0$
  
  In the case where $\sum_{0\leq t < T} x_{i,t} = 0$ (meaning an operation is never scheduled to start, like in the last example above), you now have a $-1$ penalty term as $\left(\sum_{0\leq t < T} x_{i,t}\right) - 1 = 0 - 1 = -1$


- $\left(\sum\dots\right)^2$

  Because the penalty terms must always be positive (otherwise you would be *reducing* the penalty when an operation isn't scheduled), you must square the result of $\left(\sum_{0\leq t < T} x_{i,t}\right) - 1$
  
  This ensures that the penalty term is always positive (as $(-1)^2 = 1$).
  

- $\sum_{i} \left((\dots)^2\right)$

  Lastly, you must sum all penalties accumulated across all operations $O_{i}$ from all jobs.
  
To translate this constraint to code form, you are going to need to expand the quadratic equation in the sum.

To do this, you'll once again take $O_{3}$ as an example. You will set $T = 2$ so the $t$ values will be 0 and 1. The first step will be to substitute in our values:

$$\sum_{i} \left(\left(\sum_{0\leq t < T} x_{i,t}\right) - 1\right)^2 = \left(x_{3,0} + x_{3,1} - 1\right)^2$$

For simplicity, the $x_{3,t}$ variables will be renamed as follows:

$$x_{3,0} = x$$
$$x_{3,1} = y$$

Substituting these values in, you now have the following:

$$\sum_{i} \left(\left(\sum_{0\leq t < T} x_{i,t}\right) - 1\right)^2 = \left(x_{3,0} + x_{3,1} - 1\right)^2$$
$$=\left(x + y - 1\right)^2$$

Next, you need to expand out the bracket and multiply each term in the first bracket with all terms in the other bracket:

$$\sum_{i} \left(\left(\sum_{0\leq t < T} x_{i,t}\right) - 1\right)^2 = \left(x_{3,0} + x_{3,1} - 1\right)^2$$
$$= \left(x + y - 1\right)^2$$
$$= (x + y - 1)\cdot(x + y - 1)$$
$$= x^2 + y^2 + 2xy - 2x - 2y + 1$$

If $T$ was larger, you would have more terms. The form of the equation would be the same however: still quadratic.

### Code

You can now use this expanded version of the penalty function to build the penalty terms in code. Again, the weight term `w` is included, to be assigned a value later on:

```python
def operation_once_constraint(n: int, o: int, T:int, w:float):
    """
    Construct penalty terms for the operation once constraint.
    Penalty function is of form: x^2 + y^2 + 2xy - 2x - 2y + 1

    Keyword arguments:

    n (int): Total number of jobs
    o (int): Number of operations per job
    T (int): Time allowed to complete all operations
    w (float): Relative weight of this constraint
    """

    terms = []

    # x^2 + y^2 + 2xy - 2x - 2y parts of the constraint function
    # Loop through all operations
    for i in range(n*o):
        for t in range(T):
            # x^2 + y^2 terms
            terms.append(Term(w=w*1, indices=[i*T+t, i*T+t]))

            # - 2x - 2y terms
            terms.append(Term(w=w*-2, indices=[i*T+t]))

            # + 2xy term
            # Loop through all other start times for the same job
            # to get the cross terms
            for s in range(t+1, T):
                terms.append(Term(w=w*2, indices=[i*T+t, i*T+s]))

    # + 1 term
    terms.append(Term(w=w*1, indices=[]))

    return terms
```
