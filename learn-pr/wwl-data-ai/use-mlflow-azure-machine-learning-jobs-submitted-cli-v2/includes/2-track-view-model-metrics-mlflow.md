Track, monitor, and analyze runs after submitting a machine learning job with Azure Machine Learning and MLflow.

As a data scientist, you'll try to improve a model's performance by experimenting and running multiple training scripts. To easily track what parameters were used when training the model, and what the resulting performance metrics of a model are, you can integrate the MLflow platform in your training script. After training, you can easily view all inputs and outputs in the Azure Machine Learning Studio.

You'll learn how to log metrics with MLflow when submitting a job with the Azure ML CLI (v2).

## Understand MLflow

MLflow is an open-source platform, designed to manage the complete machine learning lifecycle. As it is open source, it can be used when training models on different platforms. Here, we'll explore at how we can integrate MLflow with Azure Machine Learning jobs.

There are two options to track machine learning jobs with MLflow:

- Enable autologging using `mlflow.autolog()`
- Use logging functions to track custom metrics using `mlflow.log_*`

Before you can use either of these options, you need to set up the environment to use MLflow.

### Include MLflow in the environment

To use MLflow during training job, the `mlflow` and `azureml-mlflow` pip packages need to be installed on the compute executing the script. Therefore, you need to include these two packages in the environment. You can create an environment by referring to a YAML file that describes the Conda environment. As part of the Conda environment, you can include these two packages.

For example, in this custom environment `mlflow` and `azureml-mlflow` are installed using pip:

```yml
name: mlflow-env
channels:
  - conda-forge
dependencies:
  - python=3.8
  - pip
  - pip:
    - numpy
    - pandas
    - scikit-learn
    - matplotlib
    - mlflow
    - azureml-mlflow
```

Once the environment is defined and registered, make sure to refer to it when submitting a job.

### Enable autologging

When working with one of the common libraries for machine learning, you have the option to enable autologging in MLflow. Autologging will log parameters, metrics, and models without anyone needing to specify what needs to be logged.

Autologging is supported for the following libraries:

- Scikit-learn
- TensorFlow and Keras
- XGBoost
- LightGBM
- Spark
- Fastai
- Pytorch

To enable autologging, add the following code to your training script:

```python
import mlflow

mlflow.autolog()
```

### Log metrics with MLflow

In your training script, you can decide whatever metric you want to log with MLflow.

Depending on the type of value you want to log, use the MLflow command to store the metric with the experiment run:

- `mlflow.log_param()`: Log single key-value parameter. Use this function for an input parameter you want to log.
- `mlflow.log_metric()`: Log single key-value metric. Value must be a number. Use this function for any output you want to store with the run.
- `mlflow.log_artifact()`: Log a file. Use this function for any plot you want to log, save as image file first.

To add MLflow to an existing training script, you can add the following code:

```python
import mlflow

reg_rate = 0.1
mlflow.log_param("Regularization rate", reg_rate)
```

> [!Tip]
> For a complete overview of how to use MLflow Tracking, read the [MLflow documentation](https://www.mlflow.org/docs/latest/tracking.html).

### View the metrics in the Azure Machine Learning Studio

Once the job is completed and the training script has successfully run, you can view the metrics you logged in the Azure Machine Learning Studio.

To view the metrics:

1. Open the Studio by navigating to [https://ml.azure.com](https://ml.azure.com).
1. Find your experiment run and open it to view its details.
1. In the **Details** tab, all logged parameters will show under **Params**.
1. Select the **Metrics** tab and select the metric you want to explore.
1. Any plots that are logged as artifacts can be found under **Images**.
1. The model assets that can be used to register and deploy the model are stored in the **models** folder under **Outputs + logs**.

> [!Tip]
> Read the documentation to learn more on [how to track models with MLflow](/azure/machine-learning/how-to-use-mlflow).
