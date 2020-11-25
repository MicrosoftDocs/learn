## Operation Once Constraint

In this section, the operation once constraint will be defined, and you will learn how to represent it mathematically and then transform it to code.

The operation once constraint is defined as follows:

$$
\begin{array}{ | l | l | }
    \hline
    \textbf{Constraint} & \textbf{Penalty Condition} \\ \hline
    \textbf{Operation once constraint} & \text{Assign penalty if an operation isn't scheduled within} \\
    \text{Each operation is started once and only once} & \text{the allowed time } T \text{, or if scheduled more than once} \\
    \text{Once an operation starts, it runs to completion} & \textit{Assumption: if an operation starts, it completes} \\ \hline
    \hline
\end{array}
$$

### Worked Example

Again, job 1 ($J_{1}$) will be used as an example:

$$
\begin{array}{ | cl | }
    \hline
    J_{1} \text{:} & \text{Recalibrate navigation system} \\ \hline
    O_{3} & \text{Reboot the system}\textit{(2 mins)}\\
    O_{4} & \text{Locate the three nearest stellar landmarks}\textit{(2 mins)}\\
    \hline
\end{array}
$$

Recall the variable $x_{i,t}$:

$$
\begin{align}
\text{If } x_{i,t} &= 1, \text{ } O_i\text{ starts at time } \textit{t} \\
\text{If } x_{i,t} &= 0, \text{ } O_i\text{ does not start at time } \textit{t} \\
\end{align}
$$

According to this constraint, $x_{i,t}$ for a specific operation should equal 1 **once and only once** during the entire simulation from $t = 0 \rightarrow T$ (because it should start once and only once during the allowed time).

So in this case, you need to assign a penalty if the sum of $x_{i,t}$ for each operation across the full simulation time doesn’t equal exactly 1.

Let’s take $O_{3}$ as an example again:

$$
\begin{array}{ | c | c | }
    \hline
    t & \text{  } x_{3,t} \text{  } \\ \hline
    0 & 0 \\ \hline
    1 & 1 \\ \hline
    2 & 0 \\ \hline
     & \\ \hline
    \sum_t {x_{3,t}} = & 1 \\ \hline
    \text{Valid?} & \checkmark \\
    \hline
\end{array}
$$

In the right hand column, you see that $O_{3}$ starts at time 1 and no other time ($x_{3,t} = 1$ at time $t = 1$ and is $0$ otherwise). The sum of $x_{i,t}$ values over all $t$ for this example is therefore 1, which is what is expected! This is therefore a valid solution.

In the example below, you see an instance where $O_{3}$ is scheduled more than once ($x_{3,t} = 1$ more than once), in violation of the constraint:

$$
\begin{array}{ | c | c | }
    \hline
    t & \text{  } x_{3,t} \text{  } \\ \hline
    0 & 0 \\ \hline
    1 & 1 \\ \hline
    2 & 1 \\ \hline
     &  \\ \hline
    \sum_t {x_{3,t}} = & 2 \\ \hline
    \text{Valid?} & \text{X} \\
    \hline
\end{array}
$$

You can see from the above that $O_{3}$ has been scheduled to start at both time 1 and time 2, so the sum of $x_{i,t}$ values over all $t$ is now greater than 1. This violates the constraint and thus you must apply a penalty.

In the last example, you see an instance where $O_{3}$ has not been scheduled at all:

$$
\begin{array}{ | c | c | }
    \hline
    t & \text{  } x_{3,t} \text{  } \\ \hline
    0 & 0 \\ \hline
    1 & 0 \\ \hline
    2 & 0 \\ \hline
     & \\ \hline
    \sum_t {x_{3,t}} = & 0 \\ \hline
    \text{Valid?} & \text{X} \\
    \hline
\end{array}
$$

In this example, none of the $x_{3,t}$ values equal 1 for any time in the simulation, meaning the operation is never scheduled. This means that the sum of $x_{3,t}$ values over all $t$ is 0 - the constraint is once again violated and you must allocate a penalty.

In summary:

$$
\begin{array}{ | c | c | c | c | }
    \hline
    t & \text{  } x_{3,t} \text{  } & \text{  } x_{3,t} \text{  } & \text{  } x_{3,t} \text{  } \\ \hline
    0 & 0 & 0 & 0 \\ \hline
    1 & 1 & 1 & 0 \\ \hline
    2 & 0 & 1 & 0 \\ \hline
     & & & \\ \hline
    \sum_t {x_{3,t}} = & 1 & 2 & 0 \\ \hline
    \text{Valid?} & \checkmark & \text{X} & \text{X} \\
    \hline
\end{array}
$$

Now you understand when to assign penalties, let's formulate the constraint mathematically.

### Penalty Formulation

As seen previously, you want to assign a penalty whenever the sum of $x_{i,t}$ values across all possible $t$ values is not equal to 1. This is how you represent that mathematically:

$$g(x) = \sum_{i} \left(\left(\sum_{0\leq t < T} x_{i,t}\right) - 1\right)^2$$

Let's break that down:

- $\left(\sum_{0\leq t < T} x_{i,t}\right) - 1$

  As you saw in the sum row of the tables in the worked example, $\sum_{0\leq t < T} x_{i,t}$ should always equal exactly 1 (meaning that an operation must be scheduled **once and only once** during the simulation). This means that $\left(\sum_{0\leq t < T} x_{i,t}\right) - 1$ should always give 0. This means there is no penalty assigned when the constraint is not violated.
  
  In the case where $\sum_{0\leq t < T} x_{i,t} > 1$ (i.e. an operation is scheduled to start more than once, like in the second example above), you now have a positive, non-zero penalty term as $\left(\sum_{0\leq t < T} x_{i,t}\right) - 1 > 0$
  
  In the case where $\sum_{0\leq t < T} x_{i,t} = 0$ (i.e. an operation is never scheduled to start, like in the last example above), you now have a $-1$ penalty term as $\left(\sum_{0\leq t < T} x_{i,t}\right) - 1 = 0 - 1 = -1$


- $\left(\sum\dots\right)^2$

  Because the penalty terms must always be positive (otherwise you would be *reducing* the penalty when an operation isn't scheduled), you must square the result of $\left(\sum_{0\leq t < T} x_{i,t}\right) - 1$
  
  This ensures that the penalty term is always positive (as $(-1)^2 = 1$).
  

- $\sum_{i} \left((\dots)^2\right)$

  Lastly, you must sum all penalties accumulated across all operations $O_{i}$ from all jobs.
  
To translate this constraint to code form, you are going to need to expand the quadratic equation in the sum.

To do this, you'll once again take $O_{3}$ as an example. You will set $T = 2$ so the $t$ values will be 0 and 1. The first step will be to substitute in our values:

$$
\begin{align}
\sum_{i} \left(\left(\sum_{0\leq t < T} x_{i,t}\right) - 1\right)^2 &= \left(x_{3,0} + x_{3,1} - 1\right)^2
\end{align}
$$

For simplicity, the $x_{3,t}$ variables will be renamed as follows:

$$
\begin{align}
x_{3,0} &= x \\
x_{3,1} &= y
\end{align}
$$

Substituting these values in, you now have the following:

$$
\begin{align}
\sum_{i} \left(\left(\sum_{0\leq t < T} x_{i,t}\right) - 1\right)^2 &= \left(x_{3,0} + x_{3,1} - 1\right)^2 \\
&=\left(x + y - 1\right)^2
\end{align}
$$

Next, you need to expand out the bracket and multiply each term in the first bracket with all terms in the other bracket:

$$
\begin{align}
\sum_{i} \left(\left(\sum_{0\leq t < T} x_{i,t}\right) - 1\right)^2 &= \left(x_{3,0} + x_{3,1} - 1\right)^2 \\
&= \left(x + y - 1\right)^2 \\
&= (x + y - 1)\cdot(x + y - 1) \\
&= x^2 + y^2 + 2xy - 2x - 2y + 1
\end{align}
$$

Of course, if $T$ was larger, you would have more terms. The form of the equation would be the same however: still quadratic.

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
