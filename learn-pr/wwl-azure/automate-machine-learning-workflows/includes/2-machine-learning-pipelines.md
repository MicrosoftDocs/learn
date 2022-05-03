As a data scientist, you'll work primarily with **Azure Machine Learning** to train and manage models. After experimentation, you should *convert your work into production Python code* to allow for automation with **Azure (DevOps) Pipelines** or **GitHub Actions**.

## Experiment in Azure Machine Learning

Azure Machine Learning provides a set of features that help you organize your work. For example, with Azure Machine Learning you can:

- Register **datasets** to easily reuse data stored in a data lake.
- Train a model on remote **compute instances or clusters** depending on your requirements.
- Track all your executed scripts with **experiments** to easily compare your work.
- Register trained models and deploy a model for **batch or real-time consumption**.

Most of your work as a data scientist will consist of experimentation: testing different configurations to train a model and reviewing performance metrics to decide which model to deploy to production.

Assuming you experiment in a Jupyter notebook (`.ipynb` files), you'll want to convert the experiment to production Python code by:

- Removing all nonessential code.
- Refactoring code into functions.
- Combining related functions in Python scripts (`.py` files).
- Creating unit tests for each Python script.
- Create a pipeline to group scripts into a workflow that can be automated.

## Create Azure Machine Learning pipelines

The concept of a pipeline is found throughout various tools, often providing a way to group tasks in a certain order. The main advantage of a pipeline is that you can schedule it or trigger it to run.

An Azure Machine Learning pipeline is created within the Azure Machine Learning workspace. To create a pipeline, you can define the steps with Python scripts. 

Optionally, you can create a pipeline with **Azure Machine Learning components**. When you create a component, the script will be stored with metadata like the necessary environment in the Azure Machine Learning workspace. Components can be shared and used by anyone within the same workspace, making it easier for others to quickly create new pipelines, building on your work.

To create a pipeline that can be used for automation, it's recommended to define a pipeline job in YAML that can be triggered using a CLI (v2) command.

The YAML file that defines the pipeline needs to specify the following information:

- *What to run*: The steps defined as Python scripts or components.
- *How to run it*: Any inputs or outputs the steps may expect.
- *Where to run it*: The compute needed to execute the code (commonly an Azure Machine Learning compute cluster).

For example, a pipeline that takes raw data as input, transforms it, and trains a model may be defined in a `pipeline-job.yml` file:

```yml
$schema: https://azuremlschemas.azureedge.net/latest/pipelineJob.schema.json
type: pipeline
display_name: nyc-taxi-pipeline-example
experiment_name: nyc-taxi-pipeline-example
jobs:

  transform-job:
    type: command
      raw_data: 
          type: uri_folder 
          path: ./data
    outputs:
      transformed_data:
        mode: rw_mount
    code: src/transform
    environment: azureml:AzureML-sklearn-0.24-ubuntu18.04-py37-cpu@latest
    compute: azureml:cpu-cluster
    command: >-
      python transform.py 
      --raw_data ${{inputs.raw_data}} 
      --transformed_data ${{outputs.transformed_data}}
  
  train-job:
    type: command
    inputs:
      training_data: ${{parent.jobs.transform-job.outputs.transformed_data}}
    outputs:
      model_output: 
        mode: rw_mount
      test_data: 
        mode: rw_mount
    code: src/train
    environment: azureml:AzureML-sklearn-0.24-ubuntu18.04-py37-cpu@latest
    compute: azureml:cpu-cluster
    command: >-
      python train.py 
      --training_data ${{inputs.training_data}} 
      --test_data ${{outputs.test_data}} 
      --model_output ${{outputs.model_output}}
```

To run the pipeline within Azure Machine Learning, you'd use the following CLI command:

```cli
az ml job create --file pipeline-job.yml
```

Once the pipeline has finished executing, you can review the pipeline and its executed steps in the Azure Machine Learning workspace. 

> [!Tip]
> Learn [how to create a pipeline in Azure Machine Learning with the CLI (v2)](/learn/modules/run-component-based-pipelines-azure-machine-learning-cli-v2/)

When you convert your machine learning workloads to Python scripts and group tasks within a pipeline, your model will be ready for production. Defining the pipeline in a YAML file allows you to automate training and retraining by triggering the pipeline run with CLI (v2). You can run a CLI command, referring to the pipeline YAML file, from Azure (DevOps) Pipelines or GitHub Actions.