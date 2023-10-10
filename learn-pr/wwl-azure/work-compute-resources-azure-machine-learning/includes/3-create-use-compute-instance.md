


When you want to execute code in notebooks, you may choose to use a **compute instance** managed by Azure Machine Learning. You can create a compute instance in the Azure Machine Learning studio, using the Azure command-line interface (CLI), or the Python software development kit (SDK). 

## Create a compute instance with the Python SDK

To create a compute instance with the Python SDK, you can use the following code:

```python
from azure.ai.ml.entities import ComputeInstance

ci_basic_name = "basic-ci-12345"
ci_basic = ComputeInstance(
    name=ci_basic_name, 
    size="STANDARD_DS3_v2"
)
ml_client.begin_create_or_update(ci_basic).result()
```

To understand which parameters the `ComputeInstance` class expects, you can review the [reference documentation](/python/api/azure-ai-ml/azure.ai.ml.entities.computeinstance?azure-portal=true).

> [!Note]
> Compute instances need to have a unique name across an Azure region (for example within west europe). If the name already exists, an error message will tell you to try again with another name.

Alternatively, you can also create a compute instance with a script. The benefit of using a script is that you can ensure any necessary packages, tools, or software are automatically installed and clone any repositories that you need to work with. When you need to create compute instances for multiple users, using a script will allow you to create a consistent development environment for everyone.

> [!Tip]
> Learn more about [how to customize the compute instance with a script](/azure/machine-learning/how-to-customize-compute-instance?azure-portal=true).

### Assign a compute instance to a user

As a data scientist, you'll attach a compute instance to notebooks in order to run cells within the notebook. To be allowed to work with the compute instance, it needs to be assigned to you as a user. 

A compute instance can only be assigned to *one* user, as the compute instance can't handle parallel workloads. When you create a new compute instance, you can assign it to someone else if you have the appropriate permissions.

### Create a schedule

When you're actively working on code in a notebook, you want your compute instance to be running. When you're not executing any code, you want your compute instance to be stopped to save on costs. 

When a compute instance is assigned to you, you can start and stop a compute instance whenever you need. You can also add a schedule to the compute instance to start or stop at set times.

By scheduling your compute instance to stop at the end of every day, you'll avoid unnecessary costs if you forget to stop a compute instance.

## Use a compute instance

To use a compute instance, you need an application that can host notebooks. The easiest option to work with the compute instance is through the integrated notebooks experience in the Azure Machine Learning studio. 

You may prefer to work with Visual Studio Code for easier source control of your code. If you want to edit and run code in Visual Studio Code, you can attach a compute instance to run notebook cells remotely. 

> [!Tip]
> Learn more about [how to create and manage an Azure Machine Learning compute instance](/azure/machine-learning/how-to-create-manage-compute-instance?azure-portal=true).
 

