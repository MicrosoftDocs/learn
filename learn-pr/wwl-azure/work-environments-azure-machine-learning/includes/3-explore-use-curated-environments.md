

**Curated environments** are prebuilt environments for the most common machine learning workloads, available in your workspace by default.

Curated environments use the prefix **AzureML-** and are designed to provide for scripts that use popular machine learning frameworks and tooling. 

For example, there are curated environments for when you want to run a script that trains a regression, clustering, or classification model with Scikit-Learn. 

To explore a curated environment, you can view it in the studio, using the Azure CLI, or the Python SDK. 

The following command allows you to retrieve the description and tags of a curated environment with the Python SDK:

```python
env = ml_client.environments.get("AzureML-sklearn-0.24-ubuntu18.04-py37-cpu", version=44)
print(env. description, env.tags)
```

## Use a curated environment

Most commonly, you use environments when you want to run a script as a (**command**) **job**. 

To specify which environment you want to use to run your script, you reference an environment by its name and version.

For example, the following code shows how to configure a command job with the Python SDK, which uses a curated environment including Scikit-Learn:

```python
from azure.ai.ml import command

# configure job
job = command(
    code="./src",
    command="python train.py",
    environment="AzureML-sklearn-0.24-ubuntu18.04-py37-cpu@latest",
    compute="aml-cluster",
    display_name="train-with-curated-environment",
    experiment_name="train-with-curated-environment"
)

# submit job
returned_job = ml_client.create_or_update(job)
```

## Test and troubleshoot a curated environment

As curated environments allow for faster deployment time, it's a best practice to first explore whether one of the pre-created curated environments can be used to run your code. 

You can verify that a curated environment includes all necessary packages by reviewing its details. Then, you can test by using the environment to run the script. 

If an environment doesn't include all necessary packages to run your code, your job fails. 

When a job fails, you can review the detailed error logs in the **Outputs + logs** tab of your job in the Azure Machine Learning studio. 

A common error message that indicates your environment is incomplete, is `ModuleNotFoundError`. The module that isn't found is listed in the error message. By reviewing the error message, you can update the environment to include the libraries to ensure the necessary packages are installed on the compute target before running the code.

When you need to specify other necessary packages, you can use a curated environment as reference for your own custom environments by modifying the Dockerfiles that back these curated environments.