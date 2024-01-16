

Hyperopt is an open source Python library for hyperparameter tuning. Hyperopt is automatically installed when you create a cluster with an **ML** variant of the Databricks Runtime. To use it when training a model, follow these steps:

1. Define an *objective* function to train and evaluate a model.
2. Define the hyperparameter search space.
3. Specify the search algorithm.
4. Run the Hyperopt **fmin** function to optimize the training function.

## Define an objective function

Hyperopt works by iteratively calling a function (often referred to as the *objective* function) that returns a numeric value and tuning the parameters passed to the function so that the return value is minimized; an approach commonly referred to as *optimization*. The first requirement therefore is to encapsulate your model training and evaluation logic in a function that:

- Accepts a parameter containing a list of hyperparameter values.
- Trains a model using the provided hyperparameter values.
- Evaluates the model based on a target metric for predictive performance.
- Returns a numeric value that reflects the performance metric such that improving the model performance *lowers* the return value.

For example, the following function trains a machine learning model using the **LogisticRegression** algorithm from the Spark MLlib library. 

```python
def objective(params):
    from pyspark.ml.classification import LogisticRegression
    from pyspark.ml.evaluation import MulticlassClassificationEvaluator
    from hyperopt import STATUS_OK

    data_df = get_training_data() # This is just an example!
    splits = data_df.randomSplit([0.7, 0.3])
    training_df = splits[0]
    validation_df = splits[1]

    # Train a model using the provided hyperparameter values
    lr = LogisticRegression(labelCol="label", featuresCol="features",
                            maxIter=params['Iterations'],
                            regParam=params['Regularization'])
    model = lr.fit(training_df)

    # Evaluate the model
    predictions = model.transform(validation_df)
    eval = MulticlassClassificationEvaluator(labelCol="label",
                                             predictionCol="prediction",
                                             metricName="accuracy")
    accuracy = eval.evaluate(predictions)
    
    # Hyperopt *minimizes* the function, so return *negative* accuracy.
    return {'loss': -accuracy, 'status': STATUS_OK}
```

In this example, the **params** parameter is a list containing values for two named values: **Iterations** and **Regularization**. These values are assigned to the **maxIter** and **regParam** hyperparameters of the logistic regression algorithm used to train the model.

The function then evaluates the trained model to calculate its **accuracy** metric, which is a value between 0.0 and 1.0 indicating the proportion of predictions the model made that were correct.

Finally, the function returns a value that Hyperopt should minimize to improve the model. In this case, the target metric is accuracy, for which a higher value indicates a better model; so the function returns the *negative* of this value (so the higher the accuracy, the lower the return value).

## Define the hyperparameter search space

Each time the objective function is called, it requires a parameter containing the hyperparameter values to be tried. To specify the complete set of value combinations that can be tried, you need to define a *search space* from which Hyperopt can select the values to be used in each trial.

Hyperopt provides expressions that you can use to define a range of values for each hyperparameter, including:

- `hp.choice(label, options)`: Returns one of the `options` you listed.
- `hp.randint(label, upper)`: Returns a random integer in the range [0, upper].
- `hp.uniform(label, low, high)`: Returns a value uniformly between `low` and `high`. 
- `hp.normal(label, mu, sigma)`: Returns a real value that's normally distributed with mean `mu` and standard deviation `sigma`.

> [!TIP]
> For the complete list of expressions, see the [Hyperopt documentation](https://hyperopt.github.io/hyperopt/getting-started/search_spaces?azure-portal=true#parameter-expressions).

The following example code defines a search space for the hyperparameters used in the previous example:

```python
from hyperopt import hp

search_space = {
    'Iterations': hp.randint('Iterations', 10),
    'Regularization': hp.uniform('Regularization', 0.0, 1.0)
}
```

## Specify the search algorithm

Hyperopt uses a search algorithm to select hyperparameter values from the search space and try to optimize the objective function. There are two main choices in how Hyperopt will sample over the search space:

- `hyperopt.tpe.suggest`: Tree of Parzen Estimators (TPE), a Bayesian approach that adaptively selects new hyperparameter settings based on past results.
- `hyperopt.rand.suggest`: Random search, a nonadaptive approach that samples randomly over the search space.

The following example code specifies the TPE algorithm.

```python
from hyperopt import tpe

algo = tpe.suggest
```

### Run the Hyperopt *fmin* function

Finally, to execute a Hyperopt run, you can use the **fmin** function, which repeatedly calls the objective function using hyperparameter combinations from the search space based on the search algorithm. The goal of the **fmin** function is to minimize the value returned by the objective function (and therefore optimizing the performance of the model).

The following example code uses the **fmin** function to call the **objective** function defined previously. The search space and algorithm defined in previous examples are used, and the function will be evaluated up to 100 times before the **fmin** function returns the best-performing parameter value combination that was found.

```python
from hyperopt import fmin

argmin = fmin(
  fn=objective,
  space=search_space,
  algo=algo,
  max_evals=100)

print("Best param values: ", argmin)
```

The output from the previous code looks similar to the following example.

```text
Best param values:  {'Iterations': 6, 'Regularization': 0.5461699702338606}
```