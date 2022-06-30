The first step to operationalize a machine learning model is to run it as an Azure Machine Learning job. You can run individual scripts as **command** jobs, or groups of scripts as a **pipeline** job.

The data science team gives you their work in a Jupyter notebook in which data is loaded, transformed, and trained. To prepare the code and model for production, you’ll need to:

- Refactor the notebook into scripts.
- Refer to the script(s) in the job definition.
- Trigger the job to train the model.

## Refactor code to scripts
To make a machine learning model ready for production, you should first get your code ready for production. When you have a Jupyter notebook that needs to be converted to production code, you’ll need to:

- Clean nonessential code.
- Export your code to Python scripts.
- Use functions in your scripts.

By using functions in your scripts, it will be easier to test your code quality. When you have a script that you want to execute, you can use an Azure Machine Learning job to run the code.

## Define Azure Machine Learning job
To define a job in Azure Machine Learning, you can create a YAML file. Whether you want to run one script as a command job or multiple scripts sequentially as a pipeline. For both command and pipeline jobs, you'll need to create a YAML file, which details:

- Which scripts to run.
- What the inputs and outputs are for each script.
- The compute that will be used to run the scripts.
- The environment that needs to be installed on the compute to run the scripts.

An example of a command job that uses a registered data asset as input when running the `main.py` script is shown in the following YAML:

```yml
$schema: https://azuremlschemas.azureedge.net/latest/commandJob.schema.json
code: src
command: >-
  python main.py 
  --diabetes-csv ${{inputs.diabetes}}
inputs:
  diabetes:
    path: azureml:diabetes-data:1
    mode: ro_mount
environment: azureml:basic-env-scikit@latest
compute: azureml:aml-instance
experiment_name: diabetes-data-example
description: Train a classification model on diabetes data using a registered dataset as input.
```

In the YAML file, you'll find the necessary details you need to include:

- The `code` refers to the local folder, which stores the scripts you want to run. The `command` key specifies that the `main.py` script in the `src` folder should be executed, using the value of `inputs.diabetes` for the `diabetes-csv` parameter.
- Version 1 of the registered data asset `diabetes-data` in the Azure Machine Learning workspace is mounted to the compute to be used as input for the script.
- The compute instance `aml-instance` will be used to run the scripts. 
- The latest version of the registered custom `basic-env-scikit` environment will be installed on the compute instance before running the script.

To test the YAML definition of the job, you can trigger it using the CLI v2. 

## Trigger Azure Machine Learning job
Whenever you want to run an Azure Machine Learning job, you can use the CLI v2. The CLI v2 can be installed on your local device, or you can use the Azure Cloud Shell. 

Whether you want to trigger runs from your local device or using Azure Cloud Shell, you first need to install the Azure Machine Learning extension.

To install on Windows, use the following command:

```azurecli
az extension add -n ml -y
```

Once you've installed the Azure Machine Learning extension for the CLI and have access to the Azure subscription you want to work with, you can submit an Azure Machine Learning job usingt he following command:

```azurecli
az ml job create --file job.yml
```

> [!Note]
> To learn more about how to manage Azure Machine Learning jobs with the CLI (v2), go to the [az ml job reference documentation](/cli/azure/ml/job).

