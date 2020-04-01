Congratulations! You've completed the introduction to classification module. Take a moment to read this recap of what we covered:

* __Classification__ - assigning labels to new data. For example, predicting whether a future soccer match will be a “win” or “loss”
* __Logistic regression__ - a common classification algorithm that produces a line of best fit to data from previous events
  * Can be used to give us the probability that something is true, or an event will happen.  
* __AI often learns iteratively__ - starting with a bad approximation and changing variables (like line-slope) until a model becomes accurate
  * The real world is very variable, and so __we cannot expect our models to become 100% accurate__.
* __Support Vector Machines__ - a classification algorithm that finds a hyperplane that separates data points of different classes from each other
  * In 2D this is like trying to draw a line, while in 3D this is like trying to place a 2D plane.
  * There are different methods to fit hyperplanes.

We learned that during training AI knows how well it is doing by comparing its predictions to reality using a cost function. Minimising this cost means increasing accuracy. To do so, AI often uses "gradient descent" - a procedure where slight changes are made a model’s parameters each time it runs. Each time, the changes made are likely to result in slightly better performance, and the process is repeated until no further improvements are expected.

We also learned all about how we test models. Recall that a big dataset is normally split into data for training the model and data to test the model once it is trained. We learned that it's possible for models to be "underfitted" (to perform poorly on all datasets) or to be "overfitted" (perform well on the training data but poorly on test data). Remember, sometimes it can be better to accept a little error than to be very strict and overfit the training data.

Now that you have reviewed this module, you should be able to:

* Define classification.
* Build logistic regression and support vector machine models.
* Describe what training, irreducible error, and Bayes error are.

In the next section, we’ll walk you through one of the most exciting areas in technology right now - neural networks.
