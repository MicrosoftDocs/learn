As we discussed in the previous unit, you can deploy a model to several kinds of compute target: including local compute, an Azure Container Instance (ACI), an Azure Kubernetes Service (AKS) cluster, or an Internet of Things (IoT) module. Azure Machine Learning uses containers as a deployment mechanism, packaging the model and the code to use it as an image that can be deployed to a container in your chosen compute target.

To deploy a model as an inferencing webservice, you must perform the following tasks:
1. Register a trained model.
2. Define an Inference Configuration.
3. Define a Deployment Configuration.
4. Deploy the Model.

## 1. Register a trained model

After successfully training a model, you must register it in your Azure Machine Learning workspace. Your real-time service will then be able to load the model when required.

To register a model from a local file, you can use the **register** method of the **Model** object as shown here:

```Python
from azureml.core import Model

model = Model.register(workspace=ws, 
                       model_name='nyc-taxi-fare',
                       model_path='model.pkl', # local path
                       description='Model to predict taxi fares in NYC.')
```

## 2. Define an Inference Configuration

The model will be deployed as a service that consists of:

- A script to load the model and return predictions for submitted data.
- An environment in which the script will be run.

You must therefore define the script and environment for the service.

### Creating an Entry Script

Create the *entry script* (sometimes referred to as the *scoring script*) for the service as a Python (.py) file. It must include two functions:

- **init()**: Called when the service is initialized.
- **run(raw_data)**: Called when new data is submitted to the service.

Typically, you use the **init** function to load the model from the model registry, and use the **run** function to generate predictions from the input data. The following example script shows this pattern:

```python
import json
import joblib
import numpy as np
from azureml.core.model import Model

# Called when the service is loaded
def init():
    global model
    # Get the path to the registered model file and load it
    model_path = Model.get_model_path('nyc-taxi-fare')
    model = joblib.load(model_path)

# Called when a request is received
def run(raw_data):
    # Get the input data as a numpy array
    data = np.array(json.loads(raw_data)['data'])
    # Get a prediction from the model
    predictions = model.predict(data)
    # Return the predictions as any JSON serializable format
    return predictions.tolist()
```

### Creating an Environment

Azure Machine Learning environments are an encapsulation of the environment where your machine learning training happens. They define Python packages, environment variables, Docker settings and other attributes in declarative fashion. The below code snippet shows an example of how you can create an environment for your deployment:

```python
from azureml.core import Environment
from azureml.core.environment import CondaDependencies

my_env_name="nyc-taxi-env"
myenv = Environment.get(workspace=ws, name='AzureML-Minimal').clone(my_env_name)
conda_dep = CondaDependencies()
conda_dep.add_pip_package("numpy==1.18.1")
conda_dep.add_pip_package("pandas==1.1.5")
conda_dep.add_pip_package("joblib==0.14.1")
conda_dep.add_pip_package("scikit-learn==0.24.1")
conda_dep.add_pip_package("sklearn-pandas==2.1.0")
myenv.python.conda_dependencies=conda_dep
```

### Combining the Script and Environment in an InferenceConfig

After creating the entry script and environment, you can combine them in an **InferenceConfig** for the service like this:

```python
from azureml.core.model import InferenceConfig

from azureml.core.model import InferenceConfig
inference_config = InferenceConfig(entry_script='score.py', 
                                   source_directory='.', 
                                   environment=myenv)
```

## 3. Define a Deployment Configuration

Now that you have the entry script and environment, you need to configure the compute to which the service will be deployed. If you are deploying to an AKS cluster, you must create the cluster and a compute target for it before deploying:

```python
from azureml.core.compute import ComputeTarget, AksCompute

cluster_name = 'aks-cluster'
compute_config = AksCompute.provisioning_configuration(location='eastus')
production_cluster = ComputeTarget.create(ws, cluster_name, compute_config)
production_cluster.wait_for_completion(show_output=True)
```

With the compute target created, you can now define the deployment configuration, which sets the target-specific compute specification for the containerized deployment:

```python
from azureml.core.webservice import AksWebservice

deploy_config = AksWebservice.deploy_configuration(cpu_cores = 1,
                                                   memory_gb = 1)
```

The code to configure an ACI deployment is similar, except that you do not need to explicitly create an ACI compute target, and you must use the **deploy_configuration** class from the **azureml.core.webservice.AciWebservice** namespace. Similarly, you can use the **azureml.core.webservice.LocalWebservice** namespace to configure a local Docker-based service.

## 4. Deploy the Model

After all of the configuration is prepared, you can deploy the model. The easiest way to do this is to call the **deploy** method of the **Model** class, like this:

```python
from azureml.core.model import Model

service = Model.deploy(workspace=ws,
                       name = 'nyc-taxi-service',
                       models = [model],
                       inference_config = inference_config,
                       deployment_config = deploy_config,
                       deployment_target = production_cluster)
service.wait_for_deployment(show_output = True)
```

For ACI or local services, you can omit the **deployment_target** parameter (or set it to **None**).

> [!NOTE]
> **More Information**: For more information about deploying models with Azure Machine Learning, see [Deploy models with Azure Machine Learning](https://aka.ms/AA70zfv) in the documentation.
