

When you need to create your own environment in Azure Machine Learning to list all necessary packages, libraries, and dependencies to run your scripts, you can create **custom environments**.  

You can define an environment from a Docker image, a Docker build context, and a conda specification with Docker image.

## Create a custom environment from a Docker image

The easiest approach is likely to be to create an environment from a Docker image. Docker images can be hosted in a public registry like [Docker Hub](https://hub.docker.com/?azure-portal=true) or privately stored in an Azure Container registry. 

Many open-source frameworks are encapsulated in public images to be found on Docker Hub. For example, you can find a public Docker image that contains all necessary packages to train a deep learning model with [PyTorch](https://hub.docker.com/r/pytorch/pytorch?azure-portal=true).

To create an environment from a Docker image, you can use the Python SDK:

```python
from azure.ai.ml.entities import Environment

env_docker_image = Environment(
    image="pytorch/pytorch:latest",
    name="public-docker-image-example",
    description="Environment created from a public Docker image.",
)
ml_client.environments.create_or_update(env_docker_image)
```

You can also use the Azure Machine Learning base images to create an environment (which are similar to the images used by curated environments):

```python
from azure.ai.ml.entities import Environment

env_docker_image = Environment(
    image="mcr.microsoft.com/azureml/openmpi3.1.2-ubuntu18.04",
    name="aml-docker-image-example",
    description="Environment created from a Azure ML Docker image.",
)
ml_client.environments.create_or_update(env_docker_image)
```

## Create a custom environment with a conda specification file

Though Docker images contain all necessary packages when working with a specific framework, it may be that you need to include other packages to run your code.

For example, you may want to train a model with PyTorch, and track the model with MLflow.

When you need to include other packages or libraries in your environment, you can add a conda specification file to a Docker image when creating the environment.

A conda specification file is a YAML file, which lists the packages that need to be installed using `conda` or `pip`. Such a YAML file may look like:

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

> [!TIP]
> Review the conda documentation on how to [create an environment manually](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#creating-an-environment-file-manually?azure-portal=true) for information on the standard format for conda files.

To create an environment from a base Docker image and a conda specification file, you can use the following code:

```python
from azure.ai.ml.entities import Environment

env_docker_conda = Environment(
    image="mcr.microsoft.com/azureml/openmpi3.1.2-ubuntu18.04",
    conda_file="./conda-env.yml",
    name="docker-image-plus-conda-example",
    description="Environment created from a Docker image plus Conda environment.",
)
ml_client.environments.create_or_update(env_docker_conda)
```

> [!NOTE]
> Since all curated environments are prefixed with **AzureML-**, you can't create an environment with the same prefix.

## Use an environment

Most commonly, you use environments when you want to run a script as a (**command**) **job**.

To specify which environment you want to use to run your script, you reference an environment using the `<curated-environment-name>:<version>` or `<curated-environment-name>@latest` syntax.

For example, the following code shows how to configure a command job with the Python SDK, which uses a curated environment including Scikit-Learn:

```python
from azure.ai.ml import command

# configure job
job = command(
    code="./src",
    command="python train.py",
    environment="docker-image-plus-conda-example:1",
    compute="aml-cluster",
    display_name="train-custom-env",
    experiment_name="train-custom-env"
)

# submit job
returned_job = ml_client.create_or_update(job)
```

When you submit the job, the environment is built. The first time you use an environment, it can take 10-15 minutes to build the environment. You can review the logs of the environment build in the logs of the job.

When Azure Machine Learning builds a new environment, it's added to the list of custom environments in the workspace. The image of the environment is hosted in the Azure Container registry associated to the workspace. Whenever you use the same environment for another job (and another script), the environment is ready to go and doesn't need to be build again.
