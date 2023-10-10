


After experimentation and development, you want your code to be production-ready. To run code in production environments, it's recommended to save code as scripts. When you run a script, you'll want to use a compute target that is scalable.

Within Azure Machine Learning, **compute clusters** are ideal for running scripts. You can create a compute cluster in the Azure Machine Learning studio, using the Azure command-line interface (CLI), or the Python software development kit (SDK).

## Create a compute cluster with the Python SDK

To create a compute cluster with the Python SDK, you can use the following code:

```python
from azure.ai.ml.entities import AmlCompute

cluster_basic = AmlCompute(
    name="cpu-cluster",
    type="amlcompute",
    size="STANDARD_DS3_v2",
    location="westus",
    min_instances=0,
    max_instances=2,
    idle_time_before_scale_down=120,
    tier="low_priority",
)
ml_client.begin_create_or_update(cluster_basic).result()
```

To understand which parameters the `AmlCompute` class expects, you can review the [reference documentation](/python/api/azure-ai-ml/azure.ai.ml.entities.amlcompute?azure-portal=true).

When you create a compute cluster, there are three main parameters you need to consider:

- `size`: Specifies the *virtual machine type* of each node within the compute cluster. Based on the [sizes for virtual machines in Azure](/azure/virtual-machines/sizes?azure-portal=true). Next to size, you can also specify whether you want to use CPUs or GPUs.
- `max_instances`: Specifies the *maximum number of nodes* your compute cluster can scale out to. The number of parallel workloads your compute cluster can handle is analogous to the number of nodes your cluster can scale to.
- `tier`: Specifies whether your virtual machines will be *low priority* or *dedicated*. Setting to low priority can lower costs as you're not guaranteed availability.

## Use a compute cluster

There are three main scenarios in which you'll want to use a compute cluster:

- Running a pipeline job you built in the Designer.
- Running an Automated Machine Learning job.
- Running a script as a job.

In each of these scenarios, a compute cluster is ideal as a compute cluster will automatically scale up when a job is submitted, and automatically shut down when a job is completed. 

A compute cluster will also allow you to train multiple models in parallel, which is a common practice when using Automated Machine Learning.

You can run a Designer pipeline job and an Automated Machine Learning job through the Azure Machine Learning studio. When you submit the job through the studio, you can set the compute target to the compute cluster you created. 

When you prefer a code-first approach, you can set the compute target to your compute cluster by using the Python SDK. 

For example, when you run a script as a command job, you can set the compute target to your compute cluster with the following code:

```python
from azure.ai.ml import command

# configure job
job = command(
    code="./src",
    command="python diabetes-training.py",
    environment="AzureML-sklearn-0.24-ubuntu18.04-py37-cpu@latest",
    compute="cpu-cluster",
    display_name="train-with-cluster",
    experiment_name="diabetes-training"
    )

# submit job
returned_job = ml_client.create_or_update(job)
aml_url = returned_job.studio_url
print("Monitor your job at", aml_url)
```

After submitting a job that uses a compute cluster, the compute cluster will scale out to one or more nodes. Resizing will take a few minutes, and your job will start running once the necessary nodes are provisioned. When a job's status is *preparing*, the compute cluster is being prepared. When the status is *running*, the compute cluster is ready, and the job is running.