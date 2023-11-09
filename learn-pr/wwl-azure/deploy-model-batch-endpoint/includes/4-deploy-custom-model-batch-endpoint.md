If you want to deploy a model to a batch endpoint without using the MLflow model format, you need to create the scoring script and environment.

To deploy a model, you must have already created an endpoint. Then you can deploy the model to the endpoint.

## Create the scoring script

The scoring script is a file that reads the new data, loads the model, and performs the scoring. 

The scoring script must include two functions:

- `init()`: Called once at the beginning of the process, so use for any costly or common preparation like loading the model.
- `run()`: Called for each mini batch to perform the scoring.

The `run()` method should return a pandas DataFrame or an array/list.

A scoring script may look as follows:

```python
import os
import mlflow
import pandas as pd


def init():
    global model

    # get the path to the registered model file and load it
    model_path = os.path.join(os.environ["AZUREML_MODEL_DIR"], "model")
    model = mlflow.pyfunc.load(model_path)


def run(mini_batch):
    print(f"run method start: {__file__}, run({len(mini_batch)} files)")
    resultList = []

    for file_path in mini_batch:
        data = pd.read_csv(file_path)
        pred = model.predict(data)

        df = pd.DataFrame(pred, columns=["predictions"])
        df["file"] = os.path.basename(file_path)
        resultList.extend(df.values)

    return resultList
```

There are some things to note from the example script:

- `AZUREML_MODEL_DIR` is an environment variable that you can use to locate the files associated with the model.
- Use `global` variable to make any assets available that are needed to score the new data, like the loaded model. 
- The size of the `mini_batch` is defined in the deployment configuration. If the files in the mini batch are too large to be processed, you need to split the files into smaller files.
- By default, the predictions will be written to one single file. 

> [!Tip]
> Learn more about how to [author scoring scripts for batch deployments](/azure/machine-learning/batch-inference/how-to-batch-scoring-script?azure-portal=true).

## Create an environment

Your deployment requires an execution environment in which to run the scoring script. Any dependency your code requires should be included in the environment.

You can create an environment with a Docker image with Conda dependencies, or with a Dockerfile.

You'll also need to add the library `azureml-core` as it is required for batch deployments to work.

To create an environment using a base Docker image, you can define the Conda dependencies in a `conda.yaml` file:

```yml
name: basic-env-cpu
channels:
  - conda-forge
dependencies:
  - python=3.8
  - pandas
  - pip
  - pip:
      - azureml-core
      - mlflow
```

Then, to create the environment, run the following code:

```python
from azure.ai.ml.entities import Environment

env = Environment(
    image="mcr.microsoft.com/azureml/openmpi3.1.2-ubuntu18.04",
    conda_file="./src/conda-env.yml",
    name="deployment-environment",
    description="Environment created from a Docker image plus Conda environment.",
)
ml_client.environments.create_or_update(env)
```

## Configure and create the deployment

Finally, you can configure and create the deployment with the `BatchDeployment` class.

```python
from azure.ai.ml.entities import BatchDeployment, BatchRetrySettings
from azure.ai.ml.constants import BatchDeploymentOutputAction

deployment = BatchDeployment(
    name="forecast-mlflow",
    description="A sales forecaster",
    endpoint_name=endpoint.name,
    model=model,
    compute="aml-cluster",
    code_path="./code",
    scoring_script="score.py",
    environment=env,
    instance_count=2,
    max_concurrency_per_instance=2,
    mini_batch_size=2,
    output_action=BatchDeploymentOutputAction.APPEND_ROW,
    output_file_name="predictions.csv",
    retry_settings=BatchRetrySettings(max_retries=3, timeout=300),
    logging_level="info",
)
ml_client.batch_deployments.begin_create_or_update(deployment)
```

> [!Tip]
> Explore the reference documentation to [create a batch deployment with the Python SDK v2](/python/api/azure-ai-ml/azure.ai.ml.entities.batchdeployment?azure-portal=true).