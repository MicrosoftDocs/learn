Edges are not always active - nodes can turn themselves “off” if all the value of the data that has arrived at the node is too low. Nodes are turned on and off by an activation function - which is chosen by the user.

Activation functions are similar in practice to using different kernels in support vector machines. You don’t need to know the details of how they work, you just need to know that you need to try different activation functions and see which one gives you the best result.

When you have a large neural network, it might seem that a lot of data will be travelling through it. However, many times a node is not passing through any data at all - it is turned off. This is because activation functions regulate the output from nodes. Users choose activation functions for different layers.

### Choosing an activation function

There are many activation functions that we can apply to a neural network. ReLu and tanh are two of the most popular activation functions used with neural networks today.

Next up we'll cover a different type of gradient descent - stochastic gradient descent (SGD), and see how neural networks use gradient descent with an animation.