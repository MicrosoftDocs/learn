With the Azure Machine Learning CLI (v2), you can train and track models in a workspace.

One of the data scientists at the bike company has trained a customer churn model. You get the Python script used to train the model, and the CSV dataset, which contains a sample of customer data used as input for the model. The data science team wants to have the model trained in the Azure Machine Learning workspace so it can be shared with the marketing team.

The marketing team can't wait to use the model. They expect the model to be valuable to send targeted promotion emails to customers who otherwise may churn and buy from a competitor instead.

You'll train a model using a Python script with the Azure Machine Learning CLI (v2).

## Jobs

To track machine learning workloads in Azure Machine Learning, use **jobs** to train models. An Azure Machine Learning job executes a task against a specified compute target.  

Training a model is typically an iterative process. To keep track of your work, you can train a model as a job in Azure Machine Learning to review the inputs and outputs.

The inputs of a model are listed in the YAML file needed to submit a job. In that YAML file, you'll include the basics:

- *What to run*: The training script.
- *How to run it*: The environment needed to run the code.
- *Where to run it*: The compute used to execute the code.

When you submit a job, an experiment run is created in the workspace. All th outputs of a model like metadata, metrics, logs, and artifacts are stored with the experiment run. You can find all inputs and outputs of a job in the Azure Machine Learning Studio.

### Train a model

Use a job to train and track a machine learning model in Azure Machine Learning.

Recall the data scientist of the bike company, who gives you the training script and CSV dataset, which are used to train the customer churn model. To run the script and train the model as a job, you can use the following YAML file:

```yml
$schema: https://azuremlschemas.azureedge.net/latest/commandJob.schema.json
code: 
  local_path: src
command: >-
  python main.py 
environment: azureml:basic-env-scikit:1
compute: azureml:testdev-vm
experiment_name: customer-churn
description: Train a classification model on a sample customer dataset.
```

The YAML file describes:

- `code.local_path`: The local path to the training script.
- `command`: The command to execute, which is to run the script with Python.
- `environment`: The environment needed to execute the command. You can refer to a registered environment from the workspace by using the prefix `azureml:`, or define an environment inline.
- `compute`: The compute target on which the code will run. You can use local compute, or the compute instance or cluster from the workspace.
- `experiment_name`: The job will be stored as an experiment run in the workspace. Optionally, you can add the experiment name to more easily find it in the Studio. By default, a name will be created for you.
- `description`: Optionally, add a description to give more information on what the job included.

> [!Important]
> Any time you want to refer to an asset within your Azure Machine Learning workspace in the job YAML file, you need to use the prefix `azureml:`. For example, if you want to train a model on your compute instance named "testdv-vm", you use `azureml:testdv-vm`.

To submit a job, refer to the path of the YAML file stored as `job.yml` and run the command:

```azurecli
az ml job create --file job.yml --web
```

> [!Note]
> All code examples assume there is a default resource group and Azure Machine Learning workspace configured.

When you include the parameter `--web`, a web page will open after the job is submitted so you can monitor the experiment run in the Azure Machine Learning Studio.

In the Studio, the job is listed as an experiment run and the job's progress and details are shown. The Details tab shows the inputs, where you can find the command, environment, compute target, and performance metrics, like the accuracy of the trained model.

> [!Tip]
> To learn more about how to manage Azure Machine Learning jobs with the CLI (v2), go to the [`az ml job` reference documentation](/cli/azure/ml/job).

### Add dataset as input to job

Training a model is an iterative process. To train multiple models with varying inputs but the same training script, data scientists can work with input arguments. Let's look at an example of a **data input argument**.

Using the training script and CSV dataset, you trained a customer churn model using Azure Machine Learning compute. You plan to retrain the model, whenever you collect more data, to improve its accuracy. The dataset used as input to train the model will change over time, as more data is collected, and added to the CSV. To easily change the input dataset every time you want to retrain the model, you want to create an input argument for the data.

Instead of referring to the locally stored CSV directly from the training script, you want to specify the data input in the YAML file. There are two considerations when you take this approach:

- *In the script*: You define the input arguments using the `argparse` module. You specify the argument's name, type and optionally a default value.
- *In the YAML file*: You specify the data input, which will mount (default option) or download data to the local file system. You can refer to a public URI or a registered dataset in the Azure Machine Learning workspace.

You created a **dataset** for the customer churn data, which is registered in the Azure Machine Learning workspace. The dataset refers to the CSV file, stored in the workspace blob store. To use the dataset as input for the training script, instead of using a local CSV file, you use the `argparse` module to define an input argument `--data-csv` for the dataset in the training script.

```python
import argparse
import pandas as pd

parser = argparse.ArgumentParser()
parser.add_argument("--data-csv", dest='data_csv', type=str)

args = parser.parse_args()

df = pd.read_csv(args.data_csv)
```

To run the script and train the model with a dataset as input, you refer to a registered dataset in the YAML file used to submit the job:

```yml
$schema: https://azuremlschemas.azureedge.net/latest/commandJob.schema.json
code: 
  local_path: src
command: >-
  python main.py
  --data-csv ${{inputs.dataset}}
inputs:
  dataset: azureml:customer-churn-data:1
  mode: download 
environment: azureml:basic-env-scikit:1
compute: azureml:testdev-vm
experiment_name: customer-churn
description: Train a classification model on a sample customer dataset.
```

In this example, it will take version 1 of the **customer-churn-data** dataset from your Azure Machine Learning workspace, download it to the file system of the compute instance **testdev-vm**, and then run the **main.py** script with the dataset as an input argument.

After you submit the job using the `az ml job create --file job.yml` command, you can view the run in the Azure Machine Learning Studio. In the **Details** tab, the input datasets will show which data was used to run the experiment.

When you need to train multiple models with varying inputs, you can easily track your work when using input arguments for data and model parameters. Learn more about inputs and outputs in the [documentation on how to train a model with the CLI (v2)](/azure/machine-learning/how-to-train-cli).
