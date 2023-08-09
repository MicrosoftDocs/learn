

You can choose to deploy a model to a managed online endpoint without using the MLflow model format. To deploy a model, you'll need to create the scoring script and define the environment necessary during inferencing.

To deploy a model, you need to have created an endpoint. Then you can deploy the model to the endpoint.

## Deploy a model to an endpoint

To deploy a model, you must have:

- Model files stored on local path or registered model.
- A scoring script.
- An execution environment.

The model files can be logged and stored when you train a model.

### Create the scoring script

The scoring script needs to include two functions:

- `init()`: Called when the service is initialized.
- `run()`: Called when new data is submitted to the service.

The **init** function is called when the deployment is created or updated, to load and cache the model from the model registry. The **run** function is called for every time the endpoint is invoked, to generate predictions from the input data. The following example Python script shows this pattern:

```python
import json
import joblib
import numpy as np
import os

# called when the deployment is created or updated
def init():
    global model
    # get the path to the registered model file and load it
    model_path = os.path.join(os.getenv('AZUREML_MODEL_DIR'), 'model.pkl')
    model = joblib.load(model_path)

# called when a request is received
def run(raw_data):
    # get the input data as a numpy array
    data = np.array(json.loads(raw_data)['data'])
    # get a prediction from the model
    predictions = model.predict(data)
    # return the predictions as any JSON serializable format
    return predictions.tolist()
```

### Create an environment

Your deployment requires an execution environment in which to run the scoring script. 

You can create an environment with a Docker image with Conda dependencies, or with a Dockerfile.

To create an environment using a base Docker image, you can define the Conda dependencies in a `conda.yml` file:

```yml
name: basic-env-cpu
channels:
  - conda-forge
dependencies:
  - python=3.7
  - scikit-learn
  - pandas
  - numpy
  - matplotlib
```

Then, to create the environment, run the following code:

```python
from azure.ai.ml.entities import Environment

env = Environment(
    image="mcr.microsoft.com/azureml/openmpi3.1.2-ubuntu18.04",
    conda_file="./src/conda.yml",
    name="deployment-environment",
    description="Environment created from a Docker image plus Conda environment.",
)
ml_client.environments.create_or_update(env)
```

### Create the deployment

When you have your model files, scoring script, and environment, you can create the deployment.

To deploy a model to an endpoint, you can specify the compute configuration with two parameters:

- `instance_type`: Virtual machine (VM) size to use. [Review the list of supported sizes](/azure/machine-learning/reference-managed-online-endpoints-vm-sku-list?azure-portal=true).
- `instance_count`: Number of instances to use.

To deploy the model, use the `ManagedOnlineDeployment` class and run the following command:

```python
from azure.ai.ml.entities import ManagedOnlineDeployment, CodeConfiguration

model = Model(path="./model",

blue_deployment = ManagedOnlineDeployment(
    name="blue",
    endpoint_name="endpoint-example",
    model=model,
    environment="deployment-environment",
    code_configuration=CodeConfiguration(
        code="./src", scoring_script="score.py"
    ),
    instance_type="Standard_DS2_v2",
    instance_count=1,
)

ml_client.online_deployments.begin_create_or_update(blue_deployment).result()
```

> [!Tip]
> Explore the reference documentation to [create a managed online deployment with the Python SDK v2](/python/api/azure-ai-ml/azure.ai.ml.entities.managedonlinedeployment?azure-portal=true).

You can deploy multiple models to an endpoint. To route traffic to a specific deployment, use the following code:

```python
# blue deployment takes 100 traffic
endpoint.traffic = {"blue": 100}
ml_client.begin_create_or_update(endpoint).result()
```

To delete the endpoint and all associated deployments, run the command:

```python
ml_client.online_endpoints.begin_delete(name="endpoint-example")
```