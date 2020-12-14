## What is control flow

Control flow is an orchestration of pipeline activities that includes chaining activities in a sequence, branching, defining parameters at the pipeline level, and passing arguments while invoking the pipeline on demand or from a trigger. 

It also includes custom-state passing and looping containers, that are, For-each iterators.
If a For Each loop is used as a control flow activity, Azure Data Factory can start these multiple copy activities in parallel. 

This allows you to build complex and iterative processing logic within the pipelines you create with Azure Data Factory. 
It supports diverse integration flows and patterns in the modern data warehouse, by enabling this flexible data pipeline model.

Some of the common control flow activities are described in the below sections.

## Chaining activities

Within Azure Data Factory you can chain activities in a sequence within a pipeline. 
It is possible to use the **dependsOn** property in an activity definition to chain it with an upstream activity.

## Branching activities

Use Azure Data Factory for Branching activities within a pipeline. An example of a branching activity is *TheIf-condition* activity which  is similar to an if-statement provided in programming languages. A branching activity evaluates a set of activities when the
condition evaluates to true and another set of activities when the condition evaluates to false.

## Parameters

You can define parameters at the pipeline level and pass arguments while you're invoking the pipeline on-demand
or from a trigger. Activities can consume the arguments that are passed to the pipeline.

## Custom state passing

Custom state passing is made possible with Azure Data Factory. Custom state passing is an activity that created output or the state of the activity that needs to be consumed by a subsequent activity in the pipeline. An example, is that in a JSON definition of an activity, you can access the output of the previous activity. Using custom state passing, enables  you to build workflows where values are passing through activities. 

## Looping containers

The looping containers umbrella of control flow such as the ForEach activity  defines repetition in a pipeline. 
It enables you to iterate over a collection and runs specified activities in the defined loop. It works similar as the 'for each looping structure' used in programming languages. 
Besides for each activity, there is also an Until activity. This functionality is similar to a do-until loop used in programming. What it does is running a set of activities (do) in a loop until the condition (until) is met. 

## Trigger based flows

Pipelines can be triggered by on-demand (event-based, i.e. blob post) or wall-clock time.

## Invoke a pipeline from another pipeline

The Execute Pipeline activity with Azure Data Factory allows a Data Factory pipeline to invoke another pipeline.

## Delta flows

Use-cases related to using delta flows, is delta loads. 
Delta loads in ETL patterns will only load data that has changed since a previous iteration of a pipeline. Capabilities such as lookup activity, and flexible scheduling helps handling delta load jobs. 
In case of using a Lookup activity, it will read or look up a record or table name value from any external source. This output can further be referenced by succeeding activities.

## Other control flows

There are many more control flow activities. Below you find a couple of other useful activities.

* Web activity:
   The web activity in Azure Data Factory using control flows, can call a custom RESTendpoint from a Data Factory pipeline.
   Datasets and linked services can be passed in order to get consumed by the activity. 

* Get metadata activity:
   The Get metadata activity retrieves the metadata of any data in Azure Data Factory.







