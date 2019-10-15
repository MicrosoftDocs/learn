In the previous exercise, you saw the logistic regression algorithm optimize the number of correctly classified examples. Optimization is achieved by two methods that happen behind the scenes in AI: cost function and gradient descent.

## Cost function refresher

* __Cost__ is our error metric, which we want to get as low as possible.
* We determine our cost with the __cost function__.
* Different AI models have different cost functions.

## Gradient descent

Gradient descent optimizes the AI models to minimize their cost. It is the most widely used optimization algorithm in AI and is used in some form in almost all model training set-ups. There are several variations for different applications, but they all use the same core concepts.

Gradient descent alters model predictions to decrease the error by using calculus, but you don’t have to dive into the mathematics to do AI.

![3-dimensional plot showing gradient descent. The Y-axis represents Cost, the X-axis represents Variable 1, and the Z-axis represents variable 2. There are two peaks for cost at different sides of the graph, which decrease variably into two minima. One minimum is labeled as a local minimum, and the other is labeled as the minimum. As the decrease in Cost is variable, there is no way to get from the local minimum to the actual minimum without increasing cost. On one of the peaks, there is a starting point shown in white, with small linear jumps represented by a black line, as the variables 1 and 2 change, showing the decrease in cost at different values. However, the starting points of the variables dictate if the gradient descent will reach the local minimum (and thus not the minimum possible cost), or the actual minimum. This is why gradient descent runs multiple times and starts with random values to find the actual minimum.](../media/a-1.png)

### Learning rate

Using calculus, gradient descent repeatedly changes the variables models use to decrease the error rate. How much the variables change each time is called the __learning rate__. 

Learning rates are particularly important in complex models - if a learning rate is too small, the training will take a long time. If it is too large, it is not likely to ever train to be accurate.

![Three plots are shown. All three plots have error rate as the Y-axis, with trend line's that are identical - with the low error rate in the middle of the x-axis, and symmetrical, high error rates either side of the minima. The title of the first graph is 'too high' showing a high error rate, which is shown by a red line. The red line jumps from either side of the minima, leaving a high error rate when it finishes. The caption for the first plot is 'A small learning rate requires many updates before reaching the minimum point.' The second plot is titled 'Just right' with an smooth progression down the left-hand side of the trend line by a far smaller learning rate. The minima of the error rate is found. The caption of the plot is 'The optimal learning rate swiftly reaches the minimum point.' The third plot is titled 'Too low', and has many iterations of the red line down the left-hand side of the trend line until it reaches the minima. The caption for the third plot is 'Too large of a learning rate causes drastic updates which lead to divergent behaviours.'](../media/23-lr-02.png)

In practice it’s a good idea to find an adequate learning rate, rather than spending time trying to find an optimal one. An adequate learning rate is large enough that your model is trained efficiently, but not so small that you cannot find a minima. It is perfectly acceptable to find an appropriate learning rate through trial and error.

![Plot with the y-axis labelled as 'error rate' and the x-axis labelled as 'epoch (time)'. There are four trend lines shown for different learning rates - 'good', 'low', 'high', and 'very high'. The trend lines all start at the same place - high on the y-axis. The 'good learning rate' trend line has steady decrease over time, ending with a minimal error rate. The 'low learning rate' trend line shows a steady decrease, but a lower rate than the 'good learning rate'. The 'high learning rate' trend line shows an initial sharp drop for the error rate, but the error rate quickly keeps the same value as the epoch (time) increases. The 'very high learning rate' has a sharp increase in error rate, quickly reaching the maximum error rate the plot shows.](../media/23-lr-01.png)
