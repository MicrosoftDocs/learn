

## Common elements of the data pipeline process

### View source and destination data stores

Regardless of whether you use ADF or Azure Synapse Pipelines, there is a fairly common pattern associated with both of them. These will typically start with an understanding and an analysis of source system(s) and their makeup.

In most organizations you will be provide with a technical specification which will specify each column, their value ranges, whether columns can be null or not, and more. With this information it is useful to first important to ensure that your dedicated sql pool is running. This is the tool that we'll use to check the data that is stored in Data Lake to validate what is listed in the technical specification.

### Data flow and Control flow

two terms and concepts to become familiar with when using pipelines are a) Data flow, and b) Control flow. Control flow ensures the orderly processing of a set of tasks. To enforce the correct processing order of these tasks, precedence constraints are used. You can think of these constraints as connectors in a workflow diagram, as shown in the image below. Each task has an outcome, such as success, failure, or completion. Any subsequent task does not initiate processing until its predecessor has completed with one of these outcomes. You can use a failure event to collect data which may not match up to your destination and in turn start a process which notifies the appropriate steward(s) of the problem.

Data Flows are executed as part of a Control flow's task. In a data flow task, data is extracted from a source, transformed, or loaded into a data store. The output of one data flow task can be the input to the next data flow task, and data flows can run in parallel. Unlike control flows, you cannot add constraints between tasks in a data flow. You can, however, add a data viewer to observe the data as it is processed by each task.

![Data flows and control flows in pipelines](../media/3-pipelines-control-flow.png)