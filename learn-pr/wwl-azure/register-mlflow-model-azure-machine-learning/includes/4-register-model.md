In Azure Machine Learning, models are trained in jobs. When you want to find the model's artifacts, you can find it in the job's outputs. To more easily manage your models, you can also store a model in the Azure Machine Learning **model registry**.

The model registry makes it easy to organize and keep track of your trained models. When you register a model, you store and version your model in the workspace.

Registered models are identified by name and version. Each time you register a model with the same name as an existing one, the registry increments the version. You can also add more metadata tags to more easily search for a specific model. 

> [!Tip]
> You can also register models trained outside Azure Machine Learning by providing the local path to the model's artifacts.

There are three types of models you can register:

- **MLflow**: Model trained and tracked with MLflow. Recommended for standard use cases.
- **Custom**: Model type with a custom standard not currently supported by Azure Machine Learning.
- **Triton**: Model type for deep learning workloads. Commonly used for TensorFlow and PyTorch model deployments.

> [!Tip]
> Learn more about [Deploy deep learning workloads to production with Azure Machine Learning](/training/modules/deploy-deep-learning-workloads-to-production-azure-machine-learning/?azure-portal=true)

Azure Machine Learning integrates well with MLflow, which is why it's a best practice to log and register an MLflow model. Working with MLflow models makes model management and deployment in Azure Machine Learning easier. During deployment, for example, the environment and scoring script are created for you when using an MLflow model. 

## Register an MLflow model

To register an MLflow model, you can use the studio, the Azure CLI, or the Python SDK. 

As a data scientist, you may be most comfortable working with the Python SDK. 

To train the model, you can submit a training script as a command job by using the following code:

```python
from azure.ai.ml import command

# configure job

job = command(
    code="./src",
    command="python train-model-signature.py --training_data diabetes.csv",
    environment="AzureML-sklearn-0.24-ubuntu18.04-py37-cpu@latest",
    compute="aml-cluster",
    display_name="diabetes-train-signature",
    experiment_name="diabetes-training"
    )

# submit job
returned_job = ml_client.create_or_update(job)
aml_url = returned_job.studio_url
print("Monitor your job at", aml_url)
```

Once the job is completed and the model is trained, use the job name to find the job run and register the model from its outputs. 

```python
from azure.ai.ml.entities import Model
from azure.ai.ml.constants import AssetTypes

job_name = returned_job.name

run_model = Model(
    path=f"azureml://jobs/{job_name}/outputs/artifacts/paths/model/",
    name="mlflow-diabetes",
    description="Model created from run.",
    type=AssetTypes.MLFLOW_MODEL,
)
# Uncomment after adding required details above
ml_client.models.create_or_update(run_model)
```

All registered models are listed in the **Models** page of the Azure Machine Learning studio. The registered model includes the model's output directory. When you log and register an MLflow model, you can find the `MLmodel` file in the artifacts of the registered model. 