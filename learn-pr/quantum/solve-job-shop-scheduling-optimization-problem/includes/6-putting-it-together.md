Now that you have penalty terms to represent all of the constraints, you can finally assemble the cost function, $H(x)$!

As a reminder, here are the penalty terms:

| Constraint | Penalty condition |
|---|---|
|**Precedence constraint**<br>Operations in a job must take place in order.|Assign penalty every time $O_{i+1}$ starts before $O_{i}$ has finished (i.e. they start out of order).|
|**Operation once constraint**<br>Each operation is started once and only once.|Assign penalty if an operation isn't scheduled within the allowed time.<br>**Assumption:** if an operation starts, it runs to completion.|
|**No overlap constraint**<br>Machines can only do one thing at a time.|Assign penalty every time two operations on a single machine are scheduled to run at the same time.|

- **Precedence constraint**:

$$f(x) = \sum_{k_{n-1} \leq i < k_n}_{t+p_i>s}x_{i,t}\cdot x_{i+1,s} \text{ for each job } \textit{n}$$

- **Operation once constraint**:

$$g(x) = \sum_{i} \left(\left(\sum_{0\leq t < T} x_{i,t}\right) - 1\right)^2$$
  
- **No overlap constraint**:

$$h(x) = \sum_{i,t,k,s} x_{i,t}\cdot x_{k,s} = 0 \text{ for each machine } \textit{m}$$

As you saw earlier, combining the penalty functions is straightforward - all you need to do is assign each term a weight and add all the weighted terms together, like so:

$$H(x) = \alpha \cdot f(x) + \beta \cdot g(x) + \gamma \cdot h(x) $$

$$\text{where }\alpha, \beta \text{ and } \gamma \text{ represent the different weights you assign to the penalties.}$$

The weights represent how important each penalty function is, relative to all the others.

> Along with modifying your cost function (i.e. how you represent the penalties), tuning these weights will define how much success you will have solving your optimization problem. There are many ways to represent each optimization problem's penalty functions and many ways to manipulate their relative weights, so this may require some experimentation before you see success.

### Code

The code snippet below shows how to set problem parameters, assig weight values and assemble the penalty terms by summing the output of the penalty functions, as was just demonstrated mathematically. These terms represent the cost function and you will submit them to the solver.

```python
# Set problem parameters
n = 3                   # Number of jobs
o = 2                   # Number of operations per job
p = [2,1,2,2,1,2]       # Processing time for each operation
T = 5                   # Time you will allow for all jobs to complete

# Six jobs, two machines
ops_machines_map = [
    [0,1,4,5],          # Operations 0, 1, 4 and 5 are assigned to machine 0
    [2,3]               # Operations 2 and 3 are assigned to machine 1
]

# Generate terms to submit to solver using penalty functions defined above
# Assign penalty term weights:
alpha = 0.6  # Precedence constraint
beta = 0.2   # Operation once constraint
gamma = 0.2  # No overlap constraint

# Build terms:
terms = []
w1 = precedence_constraint(n, o, T, p, alpha)
w2 = operation_once_constraint(n, o, T, beta)
w3 = no_overlap_constraint(n, T, p, gamma, ops_machines_map)

# Combine terms:
terms = w1 + w2 + w3
```
