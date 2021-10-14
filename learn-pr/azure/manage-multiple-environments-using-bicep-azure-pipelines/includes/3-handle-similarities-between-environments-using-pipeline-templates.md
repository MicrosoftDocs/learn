When you deploy your changes to multiple environments, the steps involved in deploying to each environment are usually very similar or even identical. In this unit, you'll learn how to use pipeline templates to avoid repetition and to allow for reuse of your pipeline code.

## Deployment to multiple environments

After talking to your colleagues in the website team, you decide on the following pipeline for your toy company's website:

:::image type="content" source="../media/3-stages.png" alt-text="Diagram showing a series of pipeline stages, including those for test and production deployments." border="false":::

First, the pipeline runs the Bicep linter to check that the Bicep code is valid and follows best practices. Linting happens on the Bicep code without needing to connect to Azure, so it doesn't matter how many environments you're deploying to - it only runs once.

Next, the pipeline deploys to the test environment. This requires running the Azure Resource Manager preflight validation, then deploying the Bicep code, and finally running some tests against your test environment.

If that all succeeds, then your pipeline continues to deploy to your production environment. It runs a preview stage first, which runs the what-if operation on your production environment to list the changes that will be made to your production Azure resources. The preview stage also validates your deployment, so you don't need to run a separate validate stage for your production environment. If all of those stages complete successfully, the pipeline pauses for manual validation. Once approved, the pipeline runs the deployment and smoke tests against your production environment.

Some of these stages are repeated between your test and production environments, and some are only run for specific environments:

| Stage | Environments |
|-|-|
| Lint | Neither - linting doesn't work against an environment. |
| Validate | Test only |
| Preview | Production only |
| Deploy | Both environments |
| Smoke Test | Both environments |

When you need to repeat steps in your pipeline, you might try to copy and paste your step definitions. However, this isn't a good practice. It's easy to accidentally make subtle mistakes or for things to get out of sync when you duplicate your pipeline's code. And in the future, when you need to make a change to the steps, you have to remember to apply the change in multiple places.

## Pipeline templates

*Pipeline templates* enable you to create reusable sections of pipeline definitions. Templates can define steps, jobs, or even entire stages. You can use templates to reuse parts of a pipeline multiple times within a single pipeline, or even in multiple pipelines. You can also create a template for a set of variables you want to reuse in multiple pipelines.

A template is simply a YAML file that contains your reusable content. A simple template for a step definition might look like this, which could be saved in a file named *script.yml*:

:::code language="yaml" source="code/3-script.yml" :::

You can use a template in your pipeline by using the `template` keyword in the place where you'd normally define the individual step:

:::code language="yaml" source="code/3-jobs.yml" highlight="6, 12" :::

## Nest templates

You can nest templates in other templates, too. Suppose the preceding file was named *jobs.yml*, and you create a file named *azure-pipelines.yml* that reuses the job template in multiple pipeline stages:

:::code language="yaml" source="code/3-stages.yml" highlight="13, 17" :::

When you nest templates, or reuse them multiple times in a single pipeline, you need to be careful that you don't accidentally use the same name for multiple different pipeline resources. For example, each job within a stage needs its own name, so if you define the job name in a template then you can't reuse it multiple times in the same stage.

When you work with complex sets of deployment pipelines, it can be helpful to create a dedicated Git repository for your shared pipeline templates. Then, you can reuse the same repository in multiple pipelines, even if they're for different projects. We provide a link to more information in the summary.

## Pipeline template parameters

*Pipeline template parameters* make your template files easier to reuse, because you can allow for small differences in your templates whenever you use them.

When you create a pipeline template, you can indicate its parameters at the top of the file:

:::code language="yaml" source="code/3-script-parameters.yml" range="1-6" :::

You can define as many parameters as you need. But just like Bicep parameters, try not to overuse pipeline template parameters. You should make it easy for someone else to reuse your template without having to specify too many settings.

Each pipeline template parameter has three properties:

- The *name* of the parameter, which you use to refer to the parameter in your template files.
- The *type* of the parameter. Parameters support several different types of data, including *string*, *number*, and *boolean*. You can also define more complex templates that accept structured objects.
- The *default value* of the parameter. If you specify a default value, you effectively make the parameter optional.

In your pipeline template, you use a special syntax to refer to the value of the parameter. Use the `${{parameters.YOUR_PARAMETER_NAME}}` macro, like in this example: 

:::code language="yaml" source="code/3-script-parameters.yml" range="8-10" highlight="3" :::

You pass the value for a parameters to a pipeline template by using the `parameters` keyword, like in this example:

:::code language="yaml" source="code/3-parameters.yml" highlight="3-4, 6-7" :::

You can also use parameters when you assign names to your jobs and stages in pipeline templates too. This helps when you need to reuse the same template multiple times in your pipeline, like this:

:::code language="yaml" source="code/3-jobs-parameters.yml" highlight="7, 13" :::

## Conditions

You can use pipeline *conditions* to specify whether a step, a job, or even a stage should run depending on a rule you specify. Template parameters and pipeline conditions can be used together to enable you to customize your deployment process for many different situations.

For example, imagine you define a pipeline template that runs script steps. You plan to reuse the template for each of your environments. When you deploy your production environment, you want to run an additional step. Here's how you can achieve that by using the `if` macro and the `eq` (*equals*) operator:

:::code language="yaml" source="code/3-script-conditions.yml" range="1-12" highlight="10" :::

The condition here translates to *if the environmentType parameter's value is equal to 'Production', then run the following steps*.

You can also use the `ne` (*not equals*) operator to specify a condition like *if the environmentType parameter's value is not equal to 'Production', then run the following steps*:

:::code language="yaml" source="code/3-script-conditions.yml" range="14-16" highlight="1" :::

> [!TIP]
> Pay attention to the YAML file's indentation when you use conditions. The steps that the condition applies to need to be indented by one extra level.

Although conditions are a way to add flexibility to your pipeline, try not to use too many of them. They complicate your pipeline and make it harder to understand its flow. If you see a lot of conditions in your pipeline template, it might indicate that a template might not be the best solution for the workflow you plan to run, and that you should redesign your pipeline.

Also, consider using YAML comments to explain the conditions you use, and any other aspects of your pipeline that might need additional explanation. Comments help make your pipeline easy to understand and work with in the future. You'll see some example YAML comments in the exercises throughout this module.
