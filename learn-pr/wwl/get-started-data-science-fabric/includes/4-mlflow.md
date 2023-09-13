

Anytime you train a model, you want the results to be reproducible. By tracking and logging your work, you can review your work at any time and decide what the best approach is to train a model.

**MLflow** is an open-source library for tracking and managing your machine learning experiments. In particular, **MLflow Tracking** is a component of MLflow that logs everything about the model you're training, such as **parameters**, **metrics**, and **artifacts**.

MLflow is already installed when you open a notebook in Microsoft Fabric. To use MLflow to track your models, you only need to import the library and start logging. 

## Log results with MLflow

When you want to log results with MLflow, you need to import MLflow with `import mlflow`. To start an experiment run that is tracked with MLflow, you use `start_run()`. Next, to track parameters, metrics, and artifacts, you use the logging functions.

Common logging functions are:

- `mlflow.log_param()`: Logs a single key-value parameter. Use this function for an input parameter you want to log.
- `mlflow.log_metric()`: Logs a single key-value metric. Value must be a number. Use this function for any output you want to store with the run.
- `mlflow.log_artifact()`: Logs a file. Use this function for any plot you want to log, save as image file first.
- `mlflow.log_model()`: Logs a model. Use this function to create an MLflow model, which may include a custom signature, environment, and input examples.

> [!Tip]
> Learn more about how to track models with MLflow by exploring the [official MLflow documentation](https://www.mlflow.org/docs/latest/tracking.html?azure-portal=true).

To use the logging functions in a notebook, start a run and log any metric you want:

```python
from xgboost import XGBClassifier
from sklearn.metrics import accuracy_score
import mlflow

with mlflow.start_run():
    model = XGBClassifier(use_label_encoder=False, eval_metric="logloss")
    model.fit(X_train, y_train, eval_set=[(X_test, y_test)], verbose=False)
    y_pred = model.predict(X_test)

    accuracy = accuracy_score(y_test, y_pred)
    mlflow.log_metric("accuracy", accuracy)
```

Whenever you train and track a model, a new experiment run is created within an experiment. When you train multiple models that you want to compare, it's recommended to group them under the same experiment name. 

## Retrieve metrics with MLflow in a notebook

To review experiment runs and compare models, you can use the user interface (UI) or use MLflow in the notebook.

You can get all the active experiments in the workspace using MLFlow:

```python
experiments = mlflow.search_experiments(max_results=2)
for exp in experiments:
    print(exp.name)
```

To retrieve a specific experiment, you can run:

```python
exp = mlflow.get_experiment_by_name(experiment_name)
print(exp)
```

> [!Tip]
> Explore the documentation on how to [search experiments with MLflow](https://mlflow.org/docs/latest/search-experiments.html?azure-portal=true)

### Retrieve runs

MLflow allows you to search for runs inside of any experiment. You need either the experiment ID or the experiment name. 

For example, when you want to retrieve the metrics of a specific run:

```python
mlflow.search_runs(exp.experiment_id)
```

By default, experiments are ordered descending by `start_time`, which is the time the experiment was queued in Microsoft Fabric. However, you can change this default by using the parameter `order_by`.

For example, if you want to sort by start time and only show the last two results:

```python
mlflow.search_runs(exp.experiment_id, order_by=["start_time DESC"], max_results=2)
```

You can also look for a run with a specific combination in the hyperparameters:

```python
mlflow.search_runs(
    exp.experiment_id, filter_string="params.num_boost_round='100'", max_results=2
)
```

> [!Tip]
> Explore the documentation on how to [search runs with MLflow](https://mlflow.org/docs/latest/search-runs.html?azure-portal=true)