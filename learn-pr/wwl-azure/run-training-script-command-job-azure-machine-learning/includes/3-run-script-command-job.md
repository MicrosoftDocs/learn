When you have a script that train a machine learning model, you can run it as a command job in Azure Machine Learning. 

## Configure and submit a command job

To run a script as a command job, you'll need to configure and submit the job.

To configure a command job with the Python SDK (v2), you'll use the `command` function. To run a script, you'll need to specify values for the following parameters:

- `code`: The folder that includes the script to run.
- `command`: Specifies which file to run.
- `environment`: The necessary packages to be installed on the compute before running the command.
- `compute`: The compute to use to run the command.
- `display_name`: The name of the individual job.
- `experiment_name`: The name of the experiment the job belongs to.

> [!Tip]
> Learn more about [the `command` function and all possible parameters](/python/api/azure-ai-ml/azure.ai.ml?azure-portal=true) in the reference documentation for the Python SDK (v2).  

You can configure a command job to run a file named `train.py`, on the compute cluster named `aml-cluster` with the following code:

```python
from azure.ai.ml import command

# configure job
job = command(
    code="./src",
    command="python train.py",
    environment="AzureML-sklearn-0.24-ubuntu18.04-py37-cpu@latest",
    compute="aml-cluster",
    display_name="train-model",
    experiment_name="train-classification-model"
    )
```

When your job is configured, you can submit it, which will initiate the job and run the script:

```python
# submit job
returned_job = ml_client.create_or_update(job)
```

You can monitor and review the job in the Azure Machine Learning studio. All jobs with the same experiment name will be grouped under the same experiment. You can find an individual job using the specified display name. 

All inputs and outputs of a command job are tracked. You can review which command you specified, which compute was used, and which environment was used to run the script on the specified compute.