Introduce the idea of CI and how it can help make thing easier.

Review the build systems, technologies and target artifacts that the fictitious team works with. Recall that they use spare hardware to build their apps. Not sure what tool, if any, to specifically call out.

Here are some starter ideas for sections.

## What is CI?

## What are pipelines?

(Everybody does this, but perhaps relate to some physical process the learner is already familiar with...)

## What is Azure Pipelines?

We have complete [reference documentation](https://docs.microsoft.com/azure/devops/pipelines/tasks/?view=azure-devops).

### What are build jobs and tasks?

## What options do I have?

(The JTA calls out "AppCenter, VSTS, Jenkins, CircleCI". Do we compare other options here? If so, what's the pitch for Azure Pipelines over other options?)
(In other words, perhaps do come comparisons and then say "the team decided on Azure Pipelines because XYZ...")
(Also be sure to call out that if you have something that's working, continue to use it! A benefit of Azure DevOps is that integration among components comes out of the box, but you can also integrate the pieces you need with what you already have. Make the case for Azure DevOps if you don't have an existing process.)

## How are Azure Pipelines configured?

- Visual designer
- YAML files (preferred)
  - Include the important sections you'll use today
  - trigger, pool, variables, steps