In the previous exercise, you saw the logistic regression algorithm optimize the number of correctly classified examples. Optimization is achieved by two methods that happen behind the scenes in AI: cost function and gradient descent.

## Cost function refresher

* __Cost__ is our error metric, which we want to get as low as possible.
* We determine our cost with the __cost function__.
* Different algorithms have different cost functions.

## Gradient descent

Gradient descent optimizes the models to minimize their cost. It is the most widely used optimization algorithm in AI and is used in some form in almost all model training set-ups. There are several variations for different applications, but they all use the same core concepts.

Gradient descent alters model predictions to decrease the error by using calculus, but you don’t have to dive into the mathematics to do AI.

![3-dimensional plot showing gradient descent. The Y-axis represents Cost, the X-axis represents Variable 1, and the Z-axis represents variable 2. There are two peaks for cost at different sides of the graph, which decrease variably into two minima. One minimum is labeled as a local minimum, and the other is labeled as the minimum. As the decrease in Cost is variable, there is no way to get from the local minimum to the actual minimum without increasing cost. On one of the peaks, there is a starting point shown in white, with small linear jumps represented by a black line, as the variables 1 and 2 change, showing the decrease in cost at different values. However, the starting points of the variables dictate if the gradient descent will reach the local minimum (and thus not the minimum possible cost), or the actual minimum. This is why gradient descent runs multiple times and starts with random values to find the actual minimum.](../media/a-1.png)
