Pipelines in Azure Machine Learning allow you to create workflows to combine machine learning tasks.

Based on the work of the data science team, you created components that consist of Python scripts used for machine learning tasks. To actually prepare data to train a new model, you want to combine the components into a pipeline. The pipeline will cover all essential tasks to get from raw data to a trained model. 

You'll create the pipeline using the Azure Machine Learning CLI (v2).

## Create a pipeline

Whenever you want to run a script in Azure Machine Learning, you can submit a job using the CLI (v2). 

Instead of using one large script, you divide up the script in multiple parts, each representing a task in the machine learning workflow. For each script, a **component** is created. You can combine the components in a certain order to create a **pipeline**.

Similar to when you run a large script, you can run a component-based pipeline as a **job** in Azure Machine Learning. To specify what you want to run with your pipeline, you create a YAML file, which includes:

- *What to run*: The components.
- *How to run it*: Any inputs or outputs the components may expect.
- *Where to run it*: The compute needed to execute the code.

> [!NOTE]
> You can specify the **compute** and **environment** in both the pipeline and component job. The compute and environment specified in the **pipeline** will be the **default**. The compute and environment specified in the component details are optional and will override the default for that individual component.

Imagine you're using components to create a pipeline that will train a model to predict whether a customer will churn or not. For the pipeline job, the YAML may look like the following example:

```yaml
$schema: https://azuremlschemas.azureedge.net/latest/pipelineJob.schema.json
type: pipeline
experiment_name: churn-pipeline-example

# <inputs_and_outputs>
inputs:
  pipeline_job_input: 
    dataset: azureml:customer-churn-data:1
    mode: download

outputs: 
  pipeline_job_cleaned_data:
    mode: upload
  pipeline_job_normalized_data:
    mode: upload
  pipeline_job_trained_model:
    mode: upload
# </inputs_and_outputs>

# <jobs>
compute: azureml:aml-cluster
settings:
  datastore: azureml:workspaceblobstore

jobs:
  fix-missing-job:
    type: component
    component: file:./fix-missing-data.yml
    inputs:
      input_data: ${{inputs.pipeline_job_input}}
    outputs:
      output_data: ${{outputs.pipeline_job_cleaned_data}}

  normalize-data-job:
    type: component
    component: file:./normalize-data.yml
    inputs:
      input_data: ${{jobs.fix-missing-job.outputs.output_data}}
    outputs:
      output_data: ${{outputs.pipeline_job_normalized_data}}

  train-model-job:
    type: component
    component: file:./train-decision-tree.yml
    inputs:
      training_data: ${{jobs.normalize-data-job.outputs.output_data}}
    outputs:
      model_output: ${{outputs.pipeline_job_trained_model}}
# </jobs>
```

The pipeline consists of three components, and thus three steps in the machine learning workflow:

- Fix missing data
- Normalize the data
- Train a decision tree model

> [!NOTE]
> The scripts for the components are not included here. You'll create components and a pipeline in the exercise. The scripts and YAML files are stored in the GitHub repository linked in the exercise of this module.

### Inputs and outputs

In the `<inputs_and_outputs>` section, of the YAML file, you can find the **input** for the first component. In the example, the input is the first version of the registered dataset from the Azure Machine Learning workspace named `customer-churn-data`.

In the `<inputs_and_outputs>` section, you'll also find that the **outputs** of each component will be uploaded to a datastore. 

Under the `<jobs>` you'll find that the datastore is set to use the `workspaceblobstore`, which is where all outputs will be stored. For each input or output, you can decide whether you want to mount the data or to upload/download the data to the compute target.

### Jobs

When you run a **pipeline as a job**, you'll find that each component is run as a (child) job of the pipeline. In the `<jobs>` section, you list which components should be executed as part of the pipeline. 

For each **component job**, you need to refer to the YAML definition of the component you want to run. You also need to specify the inputs and outputs for each individual component. 

You can refer to any of the pipeline's inputs and outputs by using the `inputs.` or `outputs.` prefix. For example, the first component to fix missing data (`fix-missing-job`) refers to both the inputs and outputs of the pipeline:

```yaml
inputs:
      input_data: ${{inputs.pipeline_job_input}}
outputs:
      output_data: ${{outputs.pipeline_job_cleaned_data}}
```

If you want to use an output of a previous component job as the input of a new component job, use the `jobs.` prefix. For example, the last component to train the model (`train-model-job`), refers to the output of the previous component, which normalizes the data (`normalize-data-job`):

```yaml
inputs:
      training_data: ${{jobs.normalize-data-job.outputs.output_data}}
```

> [!TIP]
> For a complete overview of [the YAML syntax when creating a pipeline job, see the reference documentation](/azure/machine-learning/reference-yaml-job-pipeline).

Once you have the YAML file of the pipeline job, you can run the pipeline using the following command:

```azurecli
az ml job create --file ./job.yml
```

To review the pipeline job and the child jobs for each of the pipeline's components, you can navigate to the Azure Machine Learning studio.