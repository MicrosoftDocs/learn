
As a data scientist, you use notebooks to experiment and train models. To group model training results, you use **experiments**. To track model metrics with MLflow when training a model in a notebook, you can use MLflow's logging capabilities.

## Create a MLflow experiment

You can create a MLflow experiment, which allows you to group runs. If you don't create an experiment, MLflow assumes the default experiment with name `Default`.

To create an experiment, run the following command in a notebook:

```python
import mlflow

mlflow.set_experiment(experiment_name="heart-condition-classifier")
```

## Log results with MLflow

Now, you're ready to train your model. To start a run tracked by MLflow, you use `start_run()`. Next, to track the model, you can:

- Enable **autologging**.
- Use **custom logging**.

### Enable autologging

MLflow supports automatic logging for popular machine learning libraries. When you enable autologging, MLflow instructs your framework to log metrics, parameters, artifacts, and models automatically. You don't need to specify what to log as the framework decides what's relevant.

You can turn on autologging by calling `mlflow.autolog()` before your training code. You can also use the framework-specific method, such as `mlflow.xgboost.autolog()`, for more granular control.

> [!Tip]
> Find a list of [all supported frameworks for autologging in the official MLflow documentation](https://mlflow.org/docs/latest/ml/tracking/#automatic-logging?azure-portal=true).

A notebook cell that trains and tracks a classification model using autologging can be similar to the following code example:

```python
from xgboost import XGBClassifier

with mlflow.start_run():
    mlflow.autolog()

    model = XGBClassifier(eval_metric="logloss")
    model.fit(X_train, y_train, eval_set=[(X_test, y_test)], verbose=False)

```

As soon as `mlflow.xgboost.autolog()` is called, MLflow starts a run within an experiment in Azure Machine Learning to start tracking the experiment's run.

When the job completes, you can review all logged metrics in the studio.

:::image type="content" source="../media/auto-results.png" alt-text="Screenshot of overview page of MLflow experiment with autologging in Azure Machine Learning studio." lightbox="../media/auto-results.png":::

### Use custom logging

Additionally, you can manually log your model with MLflow. Manually logging models is helpful when you want to log supplementary or custom information that isn't logged through autologging. 

> [!Note]
> You can choose to only use custom logging, or use custom logging in combination with autologging.

Common functions used with custom logging are:

- `mlflow.log_param()`: Logs a single key-value parameter. Use this function for an input parameter you want to log.
- `mlflow.log_metric()`: Logs a single key-value metric. Value must be a number. Use this function for any output you want to store with the run.
- `mlflow.log_figure()`: Logs a matplotlib figure directly as an artifact.
- `mlflow.log_image()`: Logs a numpy or PIL image as an artifact.
- `mlflow.log_artifact()`: Logs any existing file as an artifact.
- `mlflow.log_model()`: Logs a model. Use this function to create a MLflow model, which can include a custom signature, environment, and input examples.

> [!Tip]
> Learn more about how to track models with MLflow by exploring the [official MLflow documentation](https://mlflow.org/docs/latest/ml/tracking/?azure-portal=true), or the [Azure Machine Learning documentation](/azure/machine-learning/how-to-log-view-metrics?azure-portal=true)

To use custom logging in a notebook, start a run and log any metric you want:

```python
from xgboost import XGBClassifier
from sklearn.metrics import accuracy_score

with mlflow.start_run():
    model = XGBClassifier(eval_metric="logloss")
    model.fit(X_train, y_train, eval_set=[(X_test, y_test)], verbose=False)
    y_pred = model.predict(X_test)

    accuracy = accuracy_score(y_test, y_pred)
    mlflow.log_metric("accuracy", accuracy)
```

Custom logging gives you more flexibility, but also creates more work as you have to define any parameter, metric, or artifact you want to log.

When the job completes, you can review all logged metrics in the studio.

:::image type="content" source="../media/custom-logging.png" alt-text="Screenshot overview page of MLflow experiment run with only custom logging in Azure Machine Learning studio." lightbox="../media/custom-logging.png":::