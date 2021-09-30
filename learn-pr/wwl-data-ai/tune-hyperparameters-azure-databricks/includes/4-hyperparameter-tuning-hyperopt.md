Another open-source tool that allows you to automate the process of hyperparameter tuning and model selection is **Hyperopt**. Hyperopt is simple to use, but using it efficiently requires care. The main advantage to using Hyperopt is that it is flexible and it can optimize any Python model with hyperparameters.

## Use Hyperopt
Hyperopt is already installed if you create a compute with the Databricks Runtime ML. To use it when training a Python model, you should follow these basic steps:
1. Define an objective function to minimize.
2. Define the hyperparameter search space.
3. Specify the search algorithm.
4. Run the Hyperopt function fmin().

### Define an objective function to minimize
The objective function represents what the main purpose is of training multiple models through hyperparameter tuning. Often, the objective is to minimize training or validation loss. 

When defining a function, you can make use of any evaluation metric that can be calculated with the algorithm you selected. For example, if we use a [support vector machine classifier from the scikit-learn library](https://scikit-learn.org/stable/modules/generated/sklearn.svm.SVC.html), you can vary the value for the regularization parameter `c`. The objective is to have the model with the highest accuracy. Since Hyperopt wants a function that it needs to minimize, you can define the objective function as the negative accuracy so that a lower score actually means a higher accuracy. 

In the following example, the regularization parameter `c` is defined as the input, a support vector machine classifier model is trained, the accuracy is calculated, and the objective function is defined as the negative accuracy, which is the value Hyperopt will try to minimize. 
```python
from sklearn.model_selection import cross_val_score
from sklearn.svm import SVC

def objective(C):
    clf = SVC(C)
    
    accuracy = cross_val_score(clf, X, y).mean()
    
    return {'loss': -accuracy, 'status': STATUS_OK}
```

### Define the hyperparameter search space
When tuning hyperparameters, you need to define a search space. If you want to make use of Hyperopt's Bayesian approach to sampling, there is a set of expressions you can use to define the search space that is compatible with Hyperopt's approach to sampling. 

Some examples of the expressions used to define the search space are:
- `hp.choice(label, options)`: Returns one of the `options` you listed.
- `hp.randint(label, upper)`: Returns a random integer in the range [0, upper].
- `hp.uniform(label, low, high)`: Returns a value uniformly between `low` and `high`. 
- `hp.normal(label, mu, sigma)`: Returns a real value that's normally distributed with mean `mu` and standard deviation `sigma`. 

For the complete list of expressions, see the [Hyperopt documentation](https://github.com/hyperopt/hyperopt/wiki/FMin#21-parameter-expressions).

### Select the search algorithm
There are two main choices in how Hyperopt will sample over the search space:
- `hyperopt.tpe.suggest`: Tree of Parzen Estimators (TPE), a Bayesian approach, which iteratively and adaptively selects new hyperparameter settings to explore based on past results. 
- `hyperopt.rand.suggest`: Random search, a non-adaptive approach that samples over the search space. 

### Run the Hyperopt function fmin()
Finally, to execute a Hyperopt run, you can use the function `fmin()`. The `fmin()` function takes the following arguments:
- `fn`: The objective function. 
- `space`: The search space. 
- `algo`: The search algorithm you want Hyperopt to use.
- `max_evals`: The maximum number of models to train.
- `max_queue_len`: The number of hyperparameter settings generated ahead of time. This can save time when using the TPE algorithm. 
- `trials`: A `SparkTrials` or `Trials` object. `SparkTrials` is used for single-machine algorithms such as scikit-learn. `Trials` is used for distributed training algorithms such as MLlib methods or Horovod. When using `SparkTrials` or Horovod, automated MLflow tracking is enabled and hyperparameters and evaluation metrics are automatically logged in MLflow. 

For more information on how to configure `fmin()` and `SparkTrials`, read about the Hyperopt concepts [here](/azure/databricks/applications/machine-learning/automl-hyperparam-tuning/hyperopt-concepts).