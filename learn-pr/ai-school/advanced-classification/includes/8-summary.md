Congratulations for finishing this module!

There was a lot to take in, so let’s recap.

We learned that during training AI knows how well it is doing by comparing its predictions to reality using a cost function. Minimizing this cost means increasing accuracy. To do so, AI often uses "gradient descent" - a procedure where slight changes are made a model’s parameters each time it runs. Each time, the changes made are likely to result in slightly better performance, and the process is repeated until no further improvements are expected.

We also learned all about how we test models. Recall that a large dataset is normally split into data for training the model and data to test the model once it is trained. We learned that it's possible for models to be "underfitted" (to perform poorly on all datasets) or to be "overfitted" (perform well on the training data but poorly on test data).

We also learned that Support Vector Machines try to label data by finding a hyperplane that separates data points of different classes from each other. In 2D this is like trying to draw a line, while in 3D this is like trying to place a 2D plane. When this can’t be done easily, often the “kernel trick” is used to look at the data in a special way. We also learned that there are different ways to fit a hyperplane, and that sometimes it can be better to accept a little error than to be strict and overfit the training data.

In this module, you were introduced to more advanced classification. You covered the fundamental concepts of AI, and set up your programming environment in Azure Notebooks.

Now that you have reviewed this module, you should be able to:

* Describe cost functions and gradient descent.
* Build a support vector machine model in Azure Notebooks.
* Define test sets, overfitting, and underfitting.

In the next section, we’ll walk you through one of the most exciting areas in technology right now - neural networks.