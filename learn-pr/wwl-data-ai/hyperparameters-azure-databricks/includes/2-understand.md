Optuna is an open source Python library for hyperparameter optimization. Optuna is widely used for efficient and flexible hyperparameter tuning. To use it when training a model, follow these steps:

1. Define an *objective* function to train and evaluate a model.
2. Create an Optuna study to manage the optimization process.
3. Run the Optuna optimization to search for the best hyperparameters.

## Define an objective function

Optuna works by iteratively calling an *objective* function that returns a numeric value to be minimized, this is the optimization target. You need to encapsulate your model training and evaluation logic in a function that:

- Accepts a parameter (typically a `trial` object) used to suggest hyperparameter values.
- Trains a model using the suggested hyperparameter values.
- Evaluates the model based on a target metric for predictive performance.
- Returns a numeric value that reflects the performance metric, such that improving model performance *lowers* the return value.

For example, the following function trains a machine learning model using the **LogisticRegression** algorithm from the Spark MLlib library, with hyperparameters suggested by Optuna:

```python
def objective(trial):
  from pyspark.ml.classification import LogisticRegression
  from pyspark.ml.evaluation import MulticlassClassificationEvaluator

  data_df = get_training_data()  # This is just an example!
  splits = data_df.randomSplit([0.7, 0.3])
  training_df = splits[0]
  validation_df = splits[1]

  # Suggest hyperparameters using Optuna's trial object
  max_iter = trial.suggest_int('Iterations', 1, 10)
  reg_param = trial.suggest_float('Regularization', 0.0, 1.0)

  # Train a model using the suggested hyperparameters
  lr = LogisticRegression(labelCol="label", featuresCol="features",
              maxIter=max_iter,
              regParam=reg_param)
  model = lr.fit(training_df)

  # Evaluate the model
  predictions = model.transform(validation_df)
  eval = MulticlassClassificationEvaluator(labelCol="label",
                       predictionCol="prediction",
                       metricName="accuracy")
  accuracy = eval.evaluate(predictions)

  # Optuna minimizes the objective, so return negative accuracy
  return -accuracy
```

In this example, the **trial** parameter is an Optuna object used to suggest values for the **Iterations** and **Regularization** hyperparameters. These values are assigned to the **maxIter** and **regParam** parameters of the logistic regression algorithm. The function evaluates the trained model's accuracy and returns its negative value, so that Optuna will maximize accuracy by minimizing the returned value.

## Define the hyperparameter search space

Each time the objective function is called, it requires a parameter containing the hyperparameter values to be tried. To explore different value combinations, you need to define a search space for Optuna to sample from during each trial.

Optuna provides methods on the `trial` object to suggest values for each hyperparameter, including:

- `trial.suggest_int(name, low, high)`: Suggests an integer value between `low` and `high` (inclusive).
- `trial.suggest_float(name, low, high)`: Suggests a floating-point value between `low` and `high`.
- `trial.suggest_categorical(name, choices)`: Suggests a value from a list of categorical options.

> [!TIP]
> For the complete list of suggestion methods, see the [Optuna documentation](https://optuna.readthedocs.io/en/stable/reference/generated/optuna.trial.Trial.html).

In the previous example, the search space is defined directly in the `objective` function using the `trial` object:

```python
def objective(trial):
  max_iter = trial.suggest_int('Iterations', 1, 10)
  reg_param = trial.suggest_float('Regularization', 0.0, 1.0)
  # ... rest of the function ...
```

This approach allows Optuna to dynamically sample hyperparameter values for each trial, making the search space flexible and easy to modify.

## Specify the search algorithm

Optuna uses a sampler to select hyperparameter values from the search space and optimize the objective function. The most commonly used sampler is the Tree-structured Parzen Estimator (TPE), which is a Bayesian optimization algorithm that adaptively selects new hyperparameter settings based on previous results.

You can specify the sampler when creating an Optuna study. For example, to use the TPE sampler:

```python
import optuna

sampler = optuna.samplers.TPESampler()
study = optuna.create_study(direction="minimize", sampler=sampler)
```

Optuna also supports other samplers, such as the random search `optuna.samplers.RandomSampler`. For most use cases, the default TPE sampler is recommended.

## Run the Optuna optimization

Finally, to execute the optimization, use the **study.optimize** method, which repeatedly calls the objective function using hyperparameter combinations from the search space based on the search algorithm. The goal is to minimize the value returned by the objective function (and therefore optimize the performance of the model).

The following example code uses the **study.optimize** method to call the **objective** function defined previously. The function is evaluated up to 100 times before the study returns the best-performing parameter value combination that was found.

```python
study.optimize(objective, n_trials=100)

print("Best param values: ", study.best_params)
```

The output from the previous code looks similar to the following example.

```text
Best param values:  {'Iterations': 6, 'Regularization': 0.5461699702338606}
```
