Variables give you a convenient way to get critical bits of data into various parts of the pipeline.

As the name suggests, the contents of a variable may change between releases, stages of jobs of your pipeline.

The system predefines some variables, and you're free to add your own as well.

The variable's scope is the most important thing you need to think about when using variables in the release pipeline.

You can imagine that a variable containing the target server's name may vary between a Development environment and a Test Environment.

Within the release pipeline, you can use variables in different scopes and different ways.

For more information, see [Release variables and debugging](/azure/devops/pipelines/release/variables).

## Predefined variables

When running your release pipeline, you always need variables that come from the agent or context of the release pipeline.

For example, the agent directory where the sources are downloaded, the build number or build ID, the agent's name, or any other information.

This information is accessible in predefined variables that you can use in your tasks.

## Release pipeline variables

Choose a release pipeline variable when you need to use the same value across all the stages and tasks in the release pipeline, and you want to change the value in a single place.

## Stage variables

Share values across all the tasks within one specific stage by using stage variables.

Use a stage-level variable for values that vary from stage to stage (and are the same for all the tasks in a stage).

## Variable groups

Share values across all the definitions in a project by using variable groups. We'll cover variable groups later in this module.

## Normal and secret variables

Because the pipeline tasks are executed on an agent, variable values are passed to the various tasks using environment variables.

The task knows how to read it. You should be aware that a variable contains clear text and can be exposed to the target system.

When you use the variable in the log output, you can also see the variable's value.

When the pipeline has finished, the values will be cleared.

You can mark a variable in the release pipeline as secret. This way, the secret is hidden from the log output. It's beneficial when writing a password or other sensitive information.

:::image type="content" source="../media/vars-3569d015.png" alt-text="Screenshot showing Variables tab.":::
