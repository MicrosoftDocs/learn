Azure Machine Learning supports multiple types of compute for experimentation and training. Specifically, you can run an **Azure Machine Learning pipeline** on Databricks compute.

## What is an Azure Machine Learning pipeline?

In Azure Machine Learning, a *pipeline* is a workflow of machine learning tasks in which each task is implemented as a *step*. Steps can be arranged sequentially or in parallel, enabling you to build sophisticated flow logic to orchestrate machine learning operations. Each step can be run on a specific compute target, making it possible to combine different types of processing as required to achieve an overall goal.

## Running pipeline step on Databricks Compute

Azure Machine Learning supports a specialized pipeline step called **DatabricksStep** with which you can run a notebook, script, or compiled JAR on an Azure Databricks cluster. In order to run a pipeline step on a Databricks cluster, you need to do the following steps:

1. Attach Azure Databricks Compute to Azure Machine Learning workspace.
2. Define DatabricksStep in a pipeline.
3. Submit the pipeline.

### Attaching Azure Databricks Compute

The following code example can be used to attach an existing Azure Databricks cluster:

```python
from azureml.core import Workspace
from azureml.core.compute import ComputeTarget, DatabricksCompute

# Load the workspace from the saved config file
ws = Workspace.from_config()

# Specify a name for the compute (unique within the workspace)
compute_name = 'db_cluster'

# Define configuration for existing Azure Databricks cluster
db_workspace_name = 'db_workspace'
db_resource_group = 'db_resource_group'
# Get the access token from the Databricks workspace
db_access_token = '1234-abc-5678-defg-90...' 
db_config = DatabricksCompute.attach_configuration(resource_group=db_resource_group,
                                                   workspace_name=db_workspace_name,
                                                   access_token=db_access_token)

# Create the compute
databricks_compute = ComputeTarget.attach(ws, compute_name, db_config)
databricks_compute.wait_for_completion(True)
```

### Defining DatabricksStep in a pipeline

To create a pipeline, you must first define each step and then create a pipeline that includes the steps. The specific configuration of each step depends on the step type. For example, the following code defines a **DatabricksStep** step to run a python script, `process_data.py`, on the attached Databricks compute.

```python
from azureml.pipeline.core import Pipeline
from azureml.pipeline.steps import DatabricksStep

script_directory = "./scripts"
script_name = "process_data.py"

dataset_name = "nyc-taxi-dataset"

spark_conf = {"spark.databricks.delta.preview.enabled": "true"}

databricksStep = DatabricksStep(name = "process_data", 
                                run_name = "process_data", 
                                python_script_params=["--dataset_name", dataset_name],  
                                spark_version = "7.3.x-scala2.12", 
                                node_type = "Standard_DS3_v2", 
                                spark_conf = spark_conf, 
                                num_workers = 1, 
                                python_script_name = script_name, 
                                source_directory = script_directory,
                                pypi_libraries = [PyPiLibrary(package = 'scikit-learn'), 
                                                  PyPiLibrary(package = 'scipy'), 
                                                  PyPiLibrary(package = 'azureml-sdk'), 
                                                  PyPiLibrary(package = 'azureml-dataprep[pandas]')], 
                                compute_target = databricks_compute, 
                                allow_reuse = False
                               )
```

The above step defines the configuration to create a new Databricks job cluster to run the Python script. The cluster is created on the fly to run the script and the cluster is subsequently deleted after the step execution is completed.

### Submit the pipeline

After defining the step, you can assign it to a pipeline, and run it as an experiment:

```python
from azureml.pipeline.core import Pipeline
from azureml.core import Experiment

# Construct the pipeline
pipeline = Pipeline(workspace = ws, steps = [databricksStep])

# Create an experiment and run the pipeline
experiment = Experiment(workspace = ws, name = "process-data-pipeline")
pipeline_run = experiment.submit(pipeline)
```
