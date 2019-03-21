The Python SDK provides interfaces to work with Azure Machine Learning Pipelines. The SDK includes imperative constructs for the sequencing and parallelization of steps. The goal is to achieve optimized execution.

All the data sources, inputs, and outputs are strictly named so they can be reused across pipelines. 

## Four Features of Azure Machine Learning Pipelines

Below are four features of Azure Machine Learning Pipelines that can help us better understand the use case and importance.

1. Task and execution can be scheduled, and it frees up the time of data scientists, especially during data preparation phase

2. You have the flexibility to allocate compute targets for individual steps and coordinate multiple pipelines.

3. The scripts for pipeline can be reused and customized for different processes, for example, retraining and batch scoring.

4. All input, output, intermediate tasks, and data are recorded and can be managed.

The following diagram shows an example of a pipeline:

![Screenshot of Pipeline Example](../media/5-pipeline-example.png)