Now that you have penalty terms to represent all of the constraints and the makespan minimization terms, you can finally assemble the cost function, $H(x)$!

As a reminder, here are the penalty terms:

| Constraint | Penalty condition |
|---|---|
|**Precedence constraint**<br>Operations in a job must take place in order.|Assign penalty every time $O_{i+1}$ starts before $O_{i}$ has finished (they start out of order).|
|**Operation-once constraint**<br>Each operation is started once and only once.|Assign penalty if an operation isn't scheduled within the allowed time.<br>**Assumption:** if an operation starts, it runs to completion.|
|**No-overlap constraint**<br>Machines can only do one thing at a time.|Assign penalty every time two operations on a single machine are scheduled to run at the same time.|

- **Precedence constraint**:

$$f(x) = \sum_{k_{n-1} \leq i < k_n, s < t + p_{i}}x_{i,t}\cdot x_{i+1,s} \text{ for each job } \textit{n}$$

- **Operation-once constraint**:

$$g(x) = \sum_{i} \left(\left(\sum_{0\leq t < T} x_{i,t}\right) - 1\right)^2$$
  
- **No-overlap constraint**:

$$h(x) = \sum_{i,t,k,s} x_{i,t}\cdot x_{k,s} = 0 \text{ for each machine } \textit{m}$$

- **Makespan minimization**:

$$k(x) = \sum_{i \in \\{k_0-1, \dots, k_{n-1}-1\\}} \left( \sum_{M_{lb} < t < T+p_i} c_t \cdot x_{i, ~t-p_i} \right)$$

As you saw earlier, combining the penalty functions is straightforward - all you need to do is assign each term a weight and add all the weighted terms together, like so:

$$H(x) = \alpha \cdot f(x) + \beta \cdot g(x) + \gamma \cdot h(x) + \delta \cdot k(x) $$

$$\text{where }\alpha, \beta, \gamma \text{ and } \delta \text{ represent the different weights assigned to the penalties.}$$

The weights represent how important each penalty function is, relative to all the others.

> [!NOTE]
> Along with modifying your cost function (how you represent the penalties), tuning these weights will define how much success you will have solving your optimization problem. There are many ways to represent each optimization problem's penalty functions and many ways to manipulate their relative weights, so this may require some experimentation before you see success. Later in this module, we'll dive a little deeper into parameter tuning.

## Code

The following code snippet shows how you assign weight values and assemble the penalty terms by summing the output of the penalty and objective functions, as was demonstrated mathematically at the start of this unit. These terms represent the cost function and they are what you will submit to the solver.

Click **+ Code** to add another new cell and add the following lines:

```python
# Generate terms to submit to solver using functions defined previously
## Assign penalty term weights:
alpha = 5  # Precedence constraint
beta = 5   # Operation once constraint
gamma = 5  # No overlap constraint
delta = 0.004  # Makespan minimization (objective function)

## Build terms
### Constraints:
c1 = precedence_constraint(jobs_ops_map, T, processing_time, alpha)
c2 = operation_once_constraint(ops_jobs_map, T, beta)
c3 = no_overlap_constraint(T, processing_time, ops_jobs_map, machines_ops_map, gamma)

### Objective function
c4 = makespan_objective(T, processing_time, jobs_ops_map, len(machines_ops_map), delta)

### Combine terms:
terms = []
terms = c1 + c2 + c3 + c4
```

> [!NOTE]
> You can find the full Python script (including the code from all units in this module) and an interactive Jupyter notebook of this sample in our [samples repo](https://github.com/microsoft/qio-samples/tree/main/samples/job-shop-scheduling?azure-portal=true).
