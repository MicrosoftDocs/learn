Azure Pipelines allow the execution of custom scripts during pipeline run-through script tasks. However, certain conditions may require the removal of script tasks, such as the pipeline stage or the branch being built. It can streamline pipeline execution and reduce unnecessary overhead.

Script tasks in pipelines pose a security risk by allowing the execution of arbitrary code on the agent machine, potentially leading to sensitive information exposure and malicious code execution.
Minimizing the risk of exposing sensitive information involves identifying and conditionally removing script tasks, for example, removing a script task altogether or replacing it with a more secure alternative when it includes a command that prints a password or a secret key.

Setting up conditions for script tasks can further reduce the risk of exposing sensitive information. For instance, removing a script task that is unnecessary for a specific pipeline stage can limit the attack surface for potential attackers and decrease the likelihood of a security breach.

This unit demonstrates how to identify and conditionally remove script tasks using Azure Pipelines and YAML pipelines.

## Identify the script tasks to be removed

To start, you need to identify the script tasks that require removal based on specific conditions. You can accomplish this by utilizing expressions in the YAML pipeline.

For instance, if a script task isn't necessary for a specific stage of the pipeline, you may want to remove it from that stage. To do this, you can use the "condition" property in the YAML pipeline to specify an expression that determines whether the script task should be executed.

```YAML
jobs:
- job: Build
  steps:
  - script: |
      echo "This script task should only run during the Build stage"
    condition: eq(variables['System.StageName'], 'Build')
  - script: |
      echo "This script task should run during all stages"
```

In this example, the first script task will only run if the stage name is "Build", while the second script task runs during all stages.

It allows you to remove the first script task from the pipeline without removing the second script task. It also allows you to reuse the second script task in other pipeline stages. It's helpful to run the same script task in multiple stages. For example, you may want to run a script task to build a project in the "Build" stage and then run the same script task to deploy the project in the "Deploy" stage.

## Use the condition property

To conditionally remove a script task, utilize the "condition" property in the YAML pipeline. This property empowers you to define an expression that determines whether the script task should execute.

For instance, to remove a script task if a specific variable is unset, utilize the following expression:

```YAML
jobs:
- job: Build
  steps:
  - script: |
      echo "This script task will only run if MY_VARIABLE is set"
    condition: ne(variables['MY_VARIABLE'], '')
```

In this example, the script task will only run if the `MY_VARIABLE` variable is set.

## Test the pipeline

Once you have made changes to the YAML pipeline, it's crucial to test it to guarantee that the script tasks are correctly removed.

Testing the pipeline entails running it and validating that the script tasks aren't executed when they should be removed.

## Challenge yourself

Create a new YAML pipeline that conditionally removes a script task based on the branch being built. Verify that the script task isn't executed when building the specified branch.

For more information about pipeline conditions and decorators, see:

- [Specify conditions.](https://learn.microsoft.com/azure/devops/pipelines/process/conditions/)
- [Pipeline decorator expression context.](https://learn.microsoft.com/azure/devops/extend/develop/pipeline-decorator-context/)
- [Runtime parameters.](https://learn.microsoft.com/azure/devops/pipelines/process/runtime-parameters/)
- [Expressions.](https://learn.microsoft.com/azure/devops/pipelines/process/expressions/)
