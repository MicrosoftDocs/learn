## Types of gradient descent

As you might imagine, gradient descent can be very computationally expensive on a large neural network, as you’re trying to optimize so many weights. Even with modern increases in processing power, normal gradient descent is often impractical with neural networks.

We can use a variation of gradient descent called __stochastic gradient descent__ (__SGD__) to make this faster.

### SGD

SGD uses only one random example from the training set to calculate the cost (normal gradient descent uses all the examples in the training set). This is computationally much faster, and it can give better results than normal gradient descent over the same amount of time.

There are different variations of SGD you can try, such as __Adam__ and __RMSProp__. Again you do not need to know how they work - you just need to know they exist and you can try different types of SGD to improve your models.

If a neural network model is taking a long time to train, you can try SGD instead. Using SGD instead of normal gradient descent is similar to changing the kernel in a SVM - it’s a built in option that you need to select.

## Forward propagation and backpropagation

Forward propagation and backpropagation are how neural networks optimise their weights and produce accurate output. Don't worry about the details - here’s a nice diagram showing how they work!

## Summary

Well done! To recap on SGD:

* __SGD picks one random example__, and checks the cost of this with the cost function.
* The __weights are adjusted__ using gradient descent.
* __SGD picks a new random example__ to check the cost, and so on until a minimum cost is reached.
* When a minimum cost is reached, SGD randomizes the parameters and begins again to attempt to achieve a better result.
* Forward propagation and back-propagation exist, and the algorithm does them for you. You don't need to know the details.

That's it! Next up we'll do a programming exercise in Azure notebooks - advanced neural networks (don't worry, we'll easily walk you through it).

Click __'Next Step'__ to get started!