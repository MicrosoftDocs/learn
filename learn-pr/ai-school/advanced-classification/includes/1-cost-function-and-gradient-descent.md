In the previous section you saw the logistic regression algorithm optimize the number of correctly classified examples. Optimization is achieved by two methods that happen behind the scenes in AI: cost function and gradient descent.
 
### Cost function refresher

* __Cost__ is our error metric, which we want to get as low as possible.
* We determine our cost with the __cost function__.
* Different AI models have different cost functions.

### Gradient descent

Gradient descent optimizes the AI models to minimize their cost. It is the most widely used optimization algorithm in AI and is used in some form in almost all model training set-ups. There are several variations for different applications, but they all use the same core concepts.

Gradient descent alters model predictions to decrease the error by using calculus, but you don’t have to dive into the mathematics to do AI.

![Artboard 1](../media/Artboard_1.png)

### Optional: Further explanation
As you can see above, gradient descent chooses a random starting point then alters the variables which guide the model's predictions, until a local minimum for cost is found. The variables at this minimum are then stored.  
  
Gradient descent will then start again in a new random starting point to find a new minimum - in case the previous minimum could be improved upon.

### Optional: Learning rate
Using calculus, gradient descent repeatedly changes the variables models use to decrease the error rate. How much the variables change each time is called the __learning rate__. 

Learning rates are particularly important in complex models - if a learning rate is too small, the training will take a long time. If it is too large, it is not likely to ever train to be accurate.

![2.3 LearningRate-02](../media/2.3_LearningRate-02.png)

In practice it’s a good idea to find an adequate learning rate, rather than spending time trying to find an optimal one. An adequate learning rate is large enough that gradient descent can be used efficiently, but not so small that you cannot find a minima. It is perfectly acceptable to find an appropriate learning rate through trial and error.

![2.3 LearningRate-01](../media/2.3_LearningRate-01.png)

## Summary

We’ve covered the two core methods powering AI:

* __Cost__ - our error metric.
* __Cost function__ - calculates the cost of an AI model.
* __Gradient descent__ - changes a model’s predictions to decrease the cost, making predictions more accurate.
  
Next up we'll look at one of the most elegant solutions in machine learning - support vector machines.