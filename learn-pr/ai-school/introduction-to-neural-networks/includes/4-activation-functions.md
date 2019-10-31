Edges are not always active - nodes can turn themselves “off” if all the value of the data that has arrived at the node is too low. Nodes are turned on and off by an activation function - which is chosen by the user.

Activation functions are similar in practice to using different kernels in support vector machines. You don’t need to know the details of how they work, you just need to know that you need to try different activation functions and see which one gives you the best result.

When you have a large neural network, it might seem that a lot of data will be traveling through it. However, many times a node is not passing through any data at all - it is turned off. This is because activation functions regulate the output from nodes. Users choose activation functions for different layers.

### Choosing an activation function

There are many activation functions that we can apply to a neural network. ReLu and tanh are two of the most popular activation functions used with neural networks today.

## Optimizers

As you might imagine, gradient descent can be very computationally expensive on a large neural network, as you’re trying to optimize so many weights. Even with modern increases in processing power, normal gradient descent is often impractical with neural networks.

We can use a variation of gradient descent called __stochastic gradient descent__ (__SGD__) to make this faster.

### SGD

SGD uses only one random example from the training set to calculate the cost (normal gradient descent uses all the examples in the training set). This is computationally much faster, and it can give better results than normal gradient descent over the same amount of time.

There are different variations of SGD you can try, such as __Adam__ and __RMSProp__. Again you do not need to know how they work - you just need to know they exist and you can try different types of SGD to improve your models.

If a neural network is taking a long time to train, you can try SGD instead. Using SGD instead of normal gradient descent is similar to changing the kernel in an SVM - it’s a built in option that you need to select.

### Forward propagation and backpropagation

![Diagram of a neural network - showing three circles aligned vertically on the left-hand side of the image with the label "input layer" above them, four circles aligned vertically in the middle of the image, aligned vertically with the label "hidden layer" above them, and two circles on the right-hand side of the image aligned vertically with the label "output layer" above them. Lines then appear from left to right - linking the top circle of the input layer to the top circle of the hidden layer, then the top circle of the input layer to the second circle of the hidden layer, and so on, until all the circle in the input layer have a line connecting them to all circles in the middle, "hidden", layer. This then repeats for linking the "hidden" layer to the two circles on the "output" layer. So in the end all circles are connected to every circle to in the layers to the left and right of them. A title appears - 'Forward propagation', with red lines linking the top circle of the input layer to the top circle of the hidden layer, then the top circle of the input layer to the second circle of the hidden layer, and so on, until all the circle in the input layer have a line connecting them to all circles in the middle, "hidden", layer. This then repeats for linking the "hidden" layer to the two circles on the "output" layer. Then, the title changes to 'backwards propagation' and the red lines appearing again, but traveling backwards, from the output layer to the hidden layer, and then from the hidden layer to the input layer.](../media/nn-fp-bp.gif)

Forward propagation and backpropagation are how neural networks optimize their weights and produce accurate output. Don't worry about the details - here’s a nice diagram showing how they work!

That's it! Next up we'll do a programming exercise in Azure notebooks - advanced neural networks (don't worry, we'll easily walk you through it).
