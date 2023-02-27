When you deploy your changes to multiple environments, the steps involved in deploying to each environment are usually very similar or even identical. In this unit, you'll learn how to use pipeline templates to avoid repetition and to allow for reuse of your pipeline code.

## Deployment to multiple environments

After talking to your colleagues on the website team, you decide on the following pipeline for your toy company's website:

:::image type="content" source="../media/3-stages.png" alt-text="Diagram that shows a series of pipeline stages, including those for test and production deployments." border="false":::

1. The pipeline runs the Bicep linter to check that the Bicep code is valid and follows best practices.

   Linting happens on the Bicep code without needing to connect to Azure, so it doesn't matter how many environments you're deploying to. It runs only once.

1. The pipeline deploys to the test environment. This stage requires:

   1. Running the Azure Resource Manager preflight validation.
   1. Deploying the Bicep code.
   1. Running some tests against your test environment.

1. If any part of the pipeline fails, then the whole pipeline stops so you can investigate and resolve the issue. But if everything succeeds, your pipeline continues to deploy to your production environment:

   1. The pipeline runs a preview stage, which runs the what-if operation on your production environment to list the changes that will be made to your production Azure resources. The preview stage also validates your deployment, so you don't need to run a separate validation stage for your production environment.
   1. The pipeline pauses for manual validation.
   1. If approval is received, the pipeline runs the deployment and smoke tests against your production environment.

Some of these stages are repeated between your test and production environments, and some are run only for specific environments:

| Stage | Environments |
|-|-|
| Lint | Neither - linting doesn't work against an environment |
| Validate | Test only |
| Preview | Production only |
| Deploy | Both environments |
| Smoke Test | Both environments |

When you need to repeat steps in your pipeline, you might try to copy and paste your step definitions. However, this isn't a good practice. It's easy to accidentally make subtle mistakes or for things to get out of sync when you duplicate your pipeline's code. And in the future, when you need to make a change to the steps, you have to remember to apply the change in multiple places.

## Pipeline templates

_Pipeline templates_ enable you to create reusable sections of pipeline definitions. Templates can define steps, jobs, or even entire stages. You can use templates to reuse parts of a pipeline multiple times within a single pipeline, or even in multiple pipelines. You can also create a template for a set of variables that you want to reuse in multiple pipelines.

A template is simply a YAML file that contains your reusable content. A simple template for a step definition might look like this and be saved in a file named _script.yml_:

:::code language="yaml" source="code/3-script.yml" :::

You can use a template in your pipeline by using the `template` keyword in the place where you'd normally define the individual step:

:::code language="yaml" source="code/3-jobs.yml" highlight="6, 12" :::

## Nested templates

You can nest templates in other templates, too. Suppose the preceding file was named _jobs.yml_, and you create a file named _azure-pipelines.yml_ that reuses the job template in multiple pipeline stages:

:::code language="yaml" source="code/3-stages.yml" highlight="13, 17" :::

When you nest templates, or reuse them multiple times in a single pipeline, you need to be careful that you don't accidentally use the same name for multiple pipeline resources. For example, each job within a stage needs its own identifier. So if you define the job identifier in a template, you can't reuse it multiple times in the same stage.

When you work with complex sets of deployment pipelines, it can be helpful to create a dedicated Git repository for your shared pipeline templates. Then, you can reuse the same repository in multiple pipelines, even if they're for different projects. We provide a link to more information in the summary.

## Pipeline template parameters

_Pipeline template parameters_ make your template files easier to reuse, because you can allow for small differences in your templates whenever you use them.

When you create a pipeline template, you can indicate its parameters at the top of the file:

:::code language="yaml" source="code/3-script-parameters.yml" range="1-6" :::

You can define as many parameters as you need. But just like Bicep parameters, try not to overuse pipeline template parameters. You should make it easy for someone else to reuse your template without having to specify too many settings.

Each pipeline template parameter has three properties:

- The _name_ of the parameter, which you use to refer to the parameter in your template files.
- The _type_ of the parameter. Parameters support several different types of data, including _string_, _number_, and _Boolean_. You can also define more complex templates that accept structured objects.
- The _default value_ of the parameter. This is optional. If you don't specify a default value, then a value must be provided when the pipeline template is used.

In the example above, the pipeline defines a string parameter named `environmentType`, which has a default value of `Test`, and a mandatory parameter named `serviceConnectionName`.

In your pipeline template, you use a special syntax to refer to the value of the parameter. Use the `${{parameters.YOUR_PARAMETER_NAME}}` macro, like in this example:

:::code language="yaml" source="code/3-script-parameters.yml" range="8-10" highlight="3" :::

You pass the value for parameters to a pipeline template by using the `parameters` keyword, like in this example:

:::code language="yaml" source="code/3-parameters.yml" highlight="3-4, 7-8" :::

You can also use parameters when you assign identifiers to your jobs and stages in pipeline templates. This technique helps when you need to reuse the same template multiple times in your pipeline, like this:

:::code language="yaml" source="code/3-jobs-parameters.yml" highlight="7, 13" :::

## Conditions

You can use pipeline _conditions_ to specify whether a step, a job, or even a stage should run depending on a rule that you specify. You can combine template parameters and pipeline conditions to customize your deployment process for many different situations.

For example, imagine you define a pipeline template that runs script steps. You plan to reuse the template for each of your environments. When you deploy your production environment, you want to run an additional step. Here's how you can achieve that by using the `if` macro and the `eq` (_equals_) operator:

:::code language="yaml" source="code/3-script-conditions.yml" range="1-12" highlight="10" :::

The condition here translates to: _if the environmentType parameter's value is equal to Production, then run the following steps_.

> [!TIP]
> Pay attention to the YAML file's indentation when you use conditions like in the example above. The steps that the condition applies to need to be indented by one extra level.

You can also specify the `condition` property on a stage, job, or step. Here's an example that shows how you can use the `ne` (_not equals_) operator to specify a condition like _if the environmentType parameter's value is not equal to Production, then run the following steps_:

:::code language="yaml" source="code/3-script-conditions.yml" range="14-16" highlight="3" :::

Although conditions are a way to add flexibility to your pipeline, try not to use too many of them. They complicate your pipeline and make it harder to understand its flow. If you see a lot of conditions in your pipeline template, the template might not be the best solution for the workflow that you plan to run, and you might need to redesign your pipeline.

Also, consider using YAML comments to explain the conditions that you use and any other aspects of your pipeline that might need more explanation. Comments help make your pipeline easy to understand and work with in the future. You'll see some example YAML comments in the exercises throughout this module.
