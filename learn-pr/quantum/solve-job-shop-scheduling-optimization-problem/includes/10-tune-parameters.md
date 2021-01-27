Great! You've learned how to model a cost function, run a solver, and verify the solution of an optimization problem using Azure Quantum. Using your knowledge, you successfully repaired your ship! However, you may have been wondering how exactly the weights that appear in the cost function were chosen. Let's take a look at a general method that can help you balance the different components that make up a cost function.

If you recall, the cost function is made up of four components, one for each constraint and one to minimize the makespan:

$$ H(x) = \alpha \cdot f(x) + \beta \cdot g(x) + \gamma \cdot h(x) + \delta \cdot k(x) $$

The importance attributed to each term can be adjusted using the weights $\alpha, \beta, \gamma, \text{ and } \delta$. The process of adjusting these weights is referred to as *parameter tuning*. In general, there's no absolute rule to determine the optimal value for each weight, and you might have to use some trial and error to figure out what works best for your problem. However, the guidelines below can help you get good starting point.

### Adjusting the optimization term weight

Intuitively, it should be clear that satisfying the constraints is more important than minimizing the makespan. An invalid solution, even with a very small makespan, would be useless to you. The weights of the cost function can be used to reflect this fact. As a rule of thumb, breaking a single constraint should be around 5-10x more expensive than any valid solution.

Let's start with an upper bound on the value of the cost function for any valid solution. At worst, a valid solution (meaning that $f(x) = g(x) = h(x) = 0$) contributes at most $m \cdot c_{T-1+max(p_i)}$ to the cost function. This is the case when $m$ operations, all taking $max(p_i)$ to complete, are scheduled at the last time step $T-1$. For convenience, let's say that this should result in a cost function value of $1$. You can compute what the value of $\delta$ should be to achieve this value. The code example you've been working with uses the following parameters:

$$ m = 2,\ T = 10,\ max(p_i) = 2,\ M_{lb} = 4,\ c_t = \frac{m^{t-M_{lb}}}{m-1} $$

Then, you calculate the upper bound as follows:

First, calculate the latest time an operation could finish. This is given by the max time $T$ (minus one because you are using 0-based indexing), plus the longest processing time for any operation ($max(p_i)$):

$$ t_{max} = T - 1 + max(p_i) = 10 - 1 + 2 = 11$$

Then, calculate $c_{t_{max}}$:

$$ c_{t_{max}} = \frac{m ^ {t_{max} - M_{lb}}}{m - 1} = \frac{2^{11 - 4}}{2 - 1} = \frac{2^{7}}{1} = 128 $$

The upper bound is then:

$$ m \cdot c_{t_{max}} = 2 \times 128 = 256 $$

To obtain the desired value of $1$, you can approximately set the weight to:

$$ \delta = \frac{1}{m \cdot c_{t_{max}}} = \frac{1}{256} = 0.004 $$

### Adjusting the constraint weights

As mentioned in the previous section, breaking a single constraint should incur a penalty roughly 5-10x higher than that of the worst valid solution. Assuming that breaking one constraint adds a value of $1$ to the cost function, you can set the remaining weights to:

$$ \alpha = \beta = \gamma = 5 $$

Now, you can run a problem instance and use the verifier to check if any constraints are being broken. If all constraints are satisfied, congratulations! You should have obtained a good solution from the optimizer.

If instead one constraint is consistently broken, you probably need to increase its weight compared to the others.

### Further adjustments

You may also come across situations in which constraints are being broken without a particular preference for which. In this case, make sure the time $T$ given a large enough value. If $T$ is too small, there may not even exist a valid solution, or the solver could be too constrained to feasibly find one.

Optionally, if you're looking for better solutions than the ones obtained so far, you may always try to lower the value of $T$, or increase the importance of the makespan component $\delta$. A tighter bound on the makespan can help the solver find a more optimal solution, as can increasing the weight $\delta$. You may also find that doing so increases the speed at which a solution is found. If any problems pop up with broken constraints, you went too far and need to change the parameters in the other direction again.
