


When you train a model with a script, you can include MLflow in the scripts to track any parameters, metrics, and artifacts. When you run the script as a job in Azure Machine Learning, you're able to review all input parameters and outputs for each run.

## Understand MLflow

MLflow is an open-source platform, designed to manage the complete machine learning lifecycle. As it's open source, it can be used when training models on different platforms. Here, we explore how we can integrate MLflow with Azure Machine Learning jobs.

There are two options to track machine learning jobs with MLflow:

- Enable autologging using `mlflow.autolog()`
- Use logging functions to track custom metrics using `mlflow.log_*`

Before you can use either of these options, you need to set up the environment to use MLflow.

## Include MLflow in the environment

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

## Enable autologging

When working with one of the common libraries for machine learning, you can enable autologging in MLflow. Autologging logs parameters, metrics, and model artifacts without anyone needing to specify what needs to be logged.

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

## Log metrics with MLflow

In your training script, you can decide whatever custom metric you want to log with MLflow.

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

## Submit the job

Finally, you need to submit the training script as a job in Azure Machine Learning. When you use MLflow in a training script and run it as a job, all tracked parameters, metrics, and artifacts are stored with the job run. 

You configure the job as usual. You only need to make sure that the environment you refer to in the job includes the necessary packages, and the script describes which metrics you want to log.