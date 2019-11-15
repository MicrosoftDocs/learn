When data travels through the edges, it is multiplied by a value that we call a weight. Each edge has a different weight that starts off as a random value. The value of weights can be positive or negative. Weights are then optimized by gradient descent to give accurate outcomes.

## Cost function refresher

* __Cost__ is our error metric, which we want to get as low as possible.
* We determine our cost with the __cost function__.
* Different algorithms have different cost functions.

### Gradient descent refresher

* Gradient descent optimizes the AI models to minimize their cost using calculus.
* You don't need to understand the calculus.

![3-dimensional plot showing gradient descent. The Y-axis represents Cost, the X-axis represents Variable 1, and the Z-axis represents variable 2. There are two peaks for cost at different sides of the graph, which decrease variably into two minima. One minimum is labeled as a local minimum, and the other is labeled as the minimum. As the decrease in Cost is variable, there is no way to get from the local minimum to the actual minimum without increasing cost. On one of the peaks, there is a starting point shown in white, with small linear jumps represented by a black line, as the variables 1 and 2 change, showing the decrease in cost at different values. However, the starting points of the variables dictate if the gradient descent will reach the local minimum (and thus not the minimum possible cost), or the actual minimum. This is why gradient descent runs multiple times and starts with random values to find the actual minimum.](../media/a-1.png)

### Learning rate

Using calculus, gradient descent repeatedly changes the variables algorithms use to decrease the error rate. How much the variables change each time is called the __learning rate__. 

Learning rates are particularly important for complex models - if a learning rate is too small, the training will take a long time. If it is too large, it is not likely to ever train to be accurate.

![Three plots are shown. All three plots have error rate as the Y-axis, with trend line's that are identical - with the low error rate in the middle of the x-axis, and symmetrical, high error rates either side of the minima. The title of the first graph is 'too high' showing a high error rate, which is shown by a red line. The red line jumps from either side of the minima, leaving a high error rate when it finishes. The caption for the first plot is 'A small learning rate requires many updates before reaching the minimum point.' The second plot is titled 'Just right' with a smooth progression down the left-hand side of the trend line by a far smaller learning rate. The minima of the error rate is found. The caption of the plot is 'The optimal learning rate swiftly reaches the minimum point.' The third plot is titled 'Too low', and has many iterations of the red line down the left-hand side of the trend line until it reaches the minima. The caption for the third plot is 'Too large of a learning rate causes drastic updates which lead to divergent behaviors.'](../media/23-lr-02.png)

In practice it’s a good idea to find an adequate learning rate, rather than spending time trying to find an optimal one. An adequate learning rate is large enough that your model is trained efficiently, but not so small that you cannot find a minima. It is perfectly acceptable to find an appropriate learning rate through trial and error.

![Plot with the y-axis labeled as 'error rate' and the x-axis labeled as 'epoch (time)'. There are four trend lines shown for different learning rates - 'good', 'low', 'high', and 'very high'. The trend lines all start at the same place - high on the y-axis. The 'good learning rate' trend line has steady decrease over time, ending with a minimal error rate. The 'low learning rate' trend line shows a steady decrease, but a lower rate than the 'good learning rate'. The 'high learning rate' trend line shows an initial sharp drop for the error rate, but the error rate quickly keeps the same value as the epoch (time) increases. The 'very high learning rate' has a sharp increase in error rate, quickly reaching the maximum error rate the plot shows.](../media/23-lr-01.png)

### Using a category as a feature - one-hot vectors

Often you may have a category in your dataset you want to use as a feature – such as a products country of origin. To use a category as a feature you represent the category as a __one-hot vector__.

![A table shows four different classes (cat, dog, bird, and rabbit) represented by four different vectors (lists). The first vector represents cats, and shows a '1' at the beginning of the list, followed by 3 '0's. The next vector, representing dogs, has a '1' in the second position of the list, with the other 3 positions filled with 0's. For birds, the '1' is in the 3rd position, with the rest of the positions are '0', and for rabbits the '1' is in the final position, with the rest of the positions as '0'.](../media/32-ohv.png)

A one-hot vector is a vector (list) where each position in the list represents a different category. The vector is filled with 0’s and with one 1. In the example above we are representing 4 animals, where a 1 in the first position represents a cat, and a 1 in the fourth position represents a rabbit. Now your category is useable by a machine learning model.

Up next we've got an exercise where you will code a simple neural network.
