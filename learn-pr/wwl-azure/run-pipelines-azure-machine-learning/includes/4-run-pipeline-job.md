

When you've built a component-based pipeline in Azure Machine Learning, you can run the workflow as a **pipeline job**.

## Configure a pipeline job

A pipeline is defined in a YAML file, which you can also create using the `@pipeline()` function. After you've used the function, you can edit the pipeline configurations by specifying which parameters you want to change and the new value.

For example, you may want to change the output mode for the pipeline job outputs:

```python
# change the output mode
pipeline_job.outputs.pipeline_job_transformed_data.mode = "upload"
pipeline_job.outputs.pipeline_job_trained_model.mode = "upload"
```

You can also set the default pipeline compute. A component uses this compute when its definition doesn't specify another target:

```python
# set pipeline level compute
pipeline_job.settings.default_compute = "aml-cluster"
```

You can also set the default datastore where Azure Machine Learning stores the outputs:

```python
# set pipeline level datastore
pipeline_job.settings.default_datastore = "workspaceblobstore"
```

To review your pipeline configuration, you can print the pipeline job object:

```python
print(pipeline_job)
```

## Run a pipeline job

When you've configured the pipeline, you're ready to run the workflow as a pipeline job.

To submit the pipeline job, run the following code:

```python
# submit job to workspace
pipeline_job = ml_client.jobs.create_or_update(
    pipeline_job, experiment_name="pipeline_job"
)
```

After you submit a pipeline job, Azure Machine Learning creates a job in the workspace. The pipeline job contains child jobs that represent the execution of individual components. Azure Machine Learning studio displays a graphical representation of the pipeline. Expand **Job overview** to explore the pipeline parameters, outputs, and child jobs:

:::image type="content" source="../media/pipeline-output.png" alt-text="Screenshot of the graphical representation of your pipeline in the Azure Machine Learning studio.":::

To troubleshoot a failed pipeline, you can check the outputs and logs of the pipeline job and its child jobs. 

- If the pipeline configuration fails, review the outputs and logs of the pipeline job.
- If a component fails, review the outputs and logs of that component's child job.

## Schedule a pipeline job

A pipeline is ideal if you want to get your model ready for production. Pipelines are especially useful for automating the retraining of a machine learning model. To automate the retraining of a model, you can schedule a pipeline.

To schedule a pipeline job, use the `JobSchedule` class to associate a trigger with the pipeline job.

There are various ways to create a schedule. A simple approach is to create a time-based schedule using the `RecurrenceTrigger` class with the following parameters:

- `frequency`: Unit of time to describe how often the schedule fires. Value can be either `minute`, `hour`, `day`, `week`, or `month`. 
- `interval`: Number of frequency units to describe how often the schedule fires. Value needs to be an integer.

To create a schedule that fires every minute, run the following code:

```python
from azure.ai.ml.entities import RecurrenceTrigger

schedule_name = "run_every_minute"

recurrence_trigger = RecurrenceTrigger(
    frequency="minute",
    interval=1,
)
```

To schedule the pipeline, use `pipeline_job` to represent the pipeline definition:

```python
from azure.ai.ml.entities import JobSchedule

job_schedule = JobSchedule(
    name=schedule_name, trigger=recurrence_trigger, create_job=pipeline_job
)

job_schedule = ml_client.schedules.begin_create_or_update(
    schedule=job_schedule
).result()
```

The display names of jobs triggered by the schedule use the schedule name as a prefix. You can review the jobs in Azure Machine Learning studio:

:::image type="content" source="../media/scheduled-jobs.png" alt-text="Screenshot of the completed jobs scheduled in the Azure Machine Learning studio.":::

To delete a schedule, you first need to disable it:

```python
ml_client.schedules.begin_disable(name=schedule_name).result()
ml_client.schedules.begin_delete(name=schedule_name).result()
```

> [!TIP]
> Learn more about [the schedules you can create to trigger pipeline jobs in Azure Machine Learning](/azure/machine-learning/how-to-schedule-pipeline-job?tabs=python&azure-portal=true). Or, explore an [example notebook to learn how to work with schedules](https://github.com/Azure/azureml-examples/blob/main/sdk/python/schedules/job-schedule.ipynb?azure-portal=true).