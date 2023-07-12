

In Azure Machine Learning, you can tune hyperparameters by running a **sweep job**.

## Create a training script for hyperparameter tuning

To run a sweep job, you need to create a training script just the way you would do for any other training job, except that your script ***must***:

- Include an argument for each hyperparameter you want to vary.
- Log the target performance metric with **MLflow**. A logged metric enables the sweep job to evaluate the performance of the trials it initiates, and identify the one that produces the best performing model.

> [!Note]
> Learn how to [track machine learning experiments and models with MLflow within Azure Machine Learning](/azure/machine-learning/how-to-use-mlflow-cli-runs?azure-portal=true).

For example, the following example script trains a logistic regression model using a `--regularization` argument to set the *regularization rate* hyperparameter, and logs the *accuracy* metric with the name `Accuracy`:

```python
import argparse
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
import mlflow

# get regularization hyperparameter
parser = argparse.ArgumentParser()
parser.add_argument('--regularization', type=float, dest='reg_rate', default=0.01)
args = parser.parse_args()
reg = args.reg_rate

# load the training dataset
data = pd.read_csv("data.csv")

# separate features and labels, and split for training/validatiom
X = data[['feature1','feature2','feature3','feature4']].values
y = data['label'].values
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.30)

# train a logistic regression model with the reg hyperparameter
model = LogisticRegression(C=1/reg, solver="liblinear").fit(X_train, y_train)

# calculate and log accuracy
y_hat = model.predict(X_test)
acc = np.average(y_hat == y_test)
mlflow.log_metric("Accuracy", acc)
```

## Configure and run a sweep job

To prepare the sweep job, you must first create a base **command job** that specifies which script to run and defines the parameters used by the script:

```python
from azure.ai.ml import command

# configure command job as base
job = command(
    code="./src",
    command="python train.py --regularization ${{inputs.regularization}}",
    inputs={
        "reg_rate": 0.01,
    },
    environment="AzureML-sklearn-0.24-ubuntu18.04-py37-cpu@latest",
    compute="aml-cluster",
    )
```

You can then override your input parameters with your search space:

```python
from azure.ai.ml.sweep import Choice

command_job_for_sweep = job(
    reg_rate=Choice(values=[0.01, 0.1, 1]),
)
```

Finally, call `sweep()` on your command job to sweep over your search space:

```python
from azure.ai.ml import MLClient

# apply the sweep parameter to obtain the sweep_job
sweep_job = command_job_for_sweep.sweep(
    compute="aml-cluster",
    sampling_algorithm="grid",
    primary_metric="Accuracy",
    goal="Maximize",
)

# set the name of the sweep job experiment
sweep_job.experiment_name="sweep-example"

# define the limits for this sweep
sweep_job.set_limits(max_total_trials=4, max_concurrent_trials=2, timeout=7200)

# submit the sweep
returned_sweep_job = ml_client.create_or_update(sweep_job)
```

## Monitor and review sweep jobs

You can monitor sweep jobs in Azure Machine Learning studio. The sweep job will initiate trials for each hyperparameter combination to be tried. For each trial, you can review all logged metrics. 

Additionally, you can evaluate and compare models by visualizing the trials in the studio. You can adjust each chart to show and compare the hyperparameter values and metrics for each trial.

> [!Tip]
> Learn more about how to [visualize hyperparameter tuning jobs](/azure/machine-learning/how-to-tune-hyperparameters#visualize-hyperparameter-tuning-jobs?azure-portal=true).