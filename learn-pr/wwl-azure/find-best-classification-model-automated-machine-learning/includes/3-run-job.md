

To run an automated machine learning (AutoML) experiment, you can configure and submit the job with the Python SDK. 

The algorithms AutoML uses will depend on the task you specify. When you want to train a classification model, AutoML will choose from a list of classification algorithms:

- Logistic Regression
- Light Gradient Boosting Machine (GBM)
- Decision Tree
- Random Forest
- Naive Bayes
- Linear Support Vector Machine (SVM)
- XGBoost
- And others...

> [!Tip]
> For a full list of supported algorithms, explore [the overview of supported algorithms](/azure/machine-learning/how-to-configure-auto-train#supported-algorithms?azure-portal=true). 

## Restrict algorithm selection

By default, AutoML will randomly select from the full range of algorithms for the specified task. You can choose to block individual algorithms from being selected; which can be useful if you know that your data isn't suited to a particular type of algorithm. You also may want to block certain algorithms if you have to comply with a policy that restricts the type of machine learning algorithms you can use in your organization.

## Configure an AutoML experiment

When you use the Python SDK (v2) to configure an AutoML experiment or job, you configure the experiment using the `automl` class. For classification, you'll use the `automl.classification` function as shown in the following example:

```python
from azure.ai.ml import automl

# configure the classification job
classification_job = automl.classification(
    compute="aml-cluster",
    experiment_name="auto-ml-class-dev",
    training_data=my_training_data_input,
    target_column_name="Diabetic",
    primary_metric="accuracy",
    n_cross_validations=5,
    enable_model_explainability=True
)
```

> [!Note]
> AutoML needs a MLTable data asset as input. In the example, `my_training_data_input` refers to a MLTable data asset created in the Azure Machine Learning workspace.

### Specify the primary metric

One of the most important settings you must specify is the **primary_metric**. The primary metric is the target performance metric for which the optimal model will be determined. Azure Machine Learning supports a set of named metrics for each type of task. 

To retrieve the list of metrics available when you want to train a classification model, you can use the **ClassificationPrimaryMetrics** function as shown here:

```python
from azure.ai.ml.automl import ClassificationPrimaryMetrics
 
list(ClassificationPrimaryMetrics)
```

> [!Tip]
> You can find a full list of primary metrics and their definitions in [evaluate automated machine learning experiment results](/azure/machine-learning/how-to-understand-automated-ml?azure-portal=true).

### Set the limits

Training machine learning models will cost compute. To minimize costs and time spent on training, you can set limits to an AutoML experiment or job by using `set_limits()`. 

There are several options to set limits to an AutoML experiment:

- `timeout_minutes`: Number of minutes after which the complete AutoML experiment is terminated.
- `trial_timeout_minutes`: Maximum number of minutes one trial can take.
- `max_trials`: Maximum number of trials, or models that will be trained.
- `enable_early_termination`: Whether to end the experiment if the score isn't improving in the short term.

```python
classification_job.set_limits(
    timeout_minutes=60, 
    trial_timeout_minutes=20, 
    max_trials=5,
    enable_early_termination=True,
)
```

To save time, you can also run multiple trials in parallel. When you use a compute cluster, you can have as many parallel trials as you have nodes. The maximum number of parallel trials is therefore related to the maximum number of nodes your compute cluster has. If you want to set the maximum number of parallel trials to be less than the maximum number of nodes, you can use `max_concurrent_trials`.

### Set the training properties

AutoML will try various combinations of featurization and algorithms to train a machine learning model. If you already know that certain algorithms aren't well-suited for your data, you can exclude (or include) a subset of the available algorithms. 

You can also choose whether you want to allow AutoML to use ensemble models. 

## Submit an AutoML experiment

You can submit an AutoML job with the following code:

```python
# submit the AutoML job
returned_job = ml_client.jobs.create_or_update(
    classification_job
) 
```

You can monitor AutoML job runs in the Azure Machine Learning studio. To get a direct link to the AutoML job by running the following code:

```python
aml_url = returned_job.studio_url
print("Monitor your job at", aml_url)
```
