
If you want to run an AutoML experiment as part of an automated machine learning operations (*ML Ops*) process, you can write code to configure and initiate an AutoML experiment.

Th AutoML API provides a Python library that you can use to run AutoML experiments for classification, regression, and forecasting. To configure the specific details for an AutoML experiment, you must write code that uses the `classify`, `regress`, or `forecast` method as appropriate with the parameters for your specific needs.

For example, the following code runs a classification AutoML experiment.

```python
from databricks import automl

# Get the training data
train_df = spark.sql("SELECT * FROM penguins")

# Configure and initiate the AutoML experiment
summary = automl.classify(train_df, target_col="Species",
                          primary_metric="precision", timeout_minutes=5)

# Get the best model
model_uri = summary.best_trial.model_path
```

> [!TIP]
> For more information about using the AutoML API, see [Train ML models with Azure Databricks AutoML Python API](/azure/databricks/machine-learning/automl/train-ml-model-automl-api?azure-portal=true) in the Azure Databricks documentation.
