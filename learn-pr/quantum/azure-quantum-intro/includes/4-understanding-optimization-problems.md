## Understanding optimization problems
Before we dive into QIO, let's recap what optimization problems are in general. 

Let's begin with some common terminology:
- **Search space**: This is the space of all the feasible solutions to the optimization problem. Each point in this search space is a valid solution to the problem, however typically we are looking for the lowest point, or lowest cost solution.
- **Objective function**: This is a mathematical description, which, when evaluated, tells you the cost of that solution.
- **Cost function**: This is an objective function that we specifically wish to minimize.
For Contoso Logistics, the cost function would be the weight difference between the two ships, which we try to minimize.
In other scenarios, it might be the length of a journey, or a monetary cost. 

Together, the search space and the objective function are often referred to as an optimization landscape. 
In the case of a problem involving two continuous variables, the analogy to a landscape is quite direct. 
For example, here is a plot of an objective function that looks like a single smooth valley:

![A plot of an optimization landscape that looks like a single smooth valley](../media/plot_simple.png)

This kind of problem can be easily solved with techniques such as [gradient descent](https://en.wikipedia.org/wiki/Gradient_descent), where you begin from an initial starting point and greedily move to any solution with a lower cost. After a few moves this will converge to the global minimum.

- **Global minimum**: The lowest point in the optimization landscape.
- **Local minimum**: A rugged landscape may consist of multiple valleys. Each of these valleys will have a lowest point, which are called the local minima. One of these points will be the lowest overall, and is the global minimum.

Advanced methods such as QIO offer no advantage on these easy problems. Instead, they should be applied to problems where the landscape is rugged, featuring many hills and valleys for example:

![A plot of an optimization landscape that shows many peaks and valleys](../media/plot_rugged.png)

In these scenarios, one of the greatest challenges is avoiding getting "stuck" at any of the sub-optimal local minima. 
It is these cases where QIO can outperform other techniques, due to the behaviour of the algorithms which we will detail in the following section.

So far we have discussed smooth and rugged objective functions, but what if there is no structure at all? In these cases, where the solutions are completely random, then no algorithm can improve upon brute force search.

![A plot of an optimization landscape that shows points scattered randomly](../media/plot_random.png)

To summarize the general conditions where QIO performs well:
- Optimization landscapes should be rugged but structured. Such landscapes arise frequently in practice, for example in traffic optimization or solving satisfiability problems.
- If the number of variables is too small, then simplistic algorithms are already sufficient. For problems with over 100 variables, QIO has achieved orders of magnitude improvement over [previously used methods](https://news.microsoft.com/innovation-stories/quantum-computing-mri-cancer-treatment/).

In the next unit, you will learn how to apply the theory behind QIO, and apply the knowledge to the shipping loading optimization problem for Contoso Logistics.  