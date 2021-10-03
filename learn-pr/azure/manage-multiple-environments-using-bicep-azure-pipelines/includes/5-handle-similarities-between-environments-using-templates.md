Even though you deploy your changes to multiple separate environments, the steps involved in deploying to each environment are usually identical or very similar. But, it's a good idea to avoid repetition in your pipeline code, because repetition can lead to errors. In this unit, you'll learn how to use pipeline templates to avoid repetition and to allow for reuse. 

## Pipeline templates

*Pipeline templates* enable you to create reusable sections of pipeline definitions. Templates can define steps, jobs, or even entire stages. You can use templates to reuse definitions multiple times in a single pipeline, or even in multiple pipelines. You can also create a template for a set of variables you want to reuse in multiple pipelines.

A template is simply a YAML file that contains your reusable content. A simple template might look like this, which could be saved in a file named *script.yml*:

:::code language="yaml" source="code/5-script.yml" :::

You can use a template in your pipeline by using the `template` keyword:

:::code language="yaml" source="code/5-jobs.yml" highlight="6, 12" :::

## Nest templates

You can nest templates in other templates, too. Suppose the preceding file was named *jobs.yml*, and you create a file named *azure-pipelines.yml* that reuses the job template in multiple pipeline stages:

:::code language="yaml" source="code/5-stages.yml" highlight="13, 17" :::

When you nest templates, or reuse them multiple times in a single pipeline, you need to be careful that you don't accidentally use the same name multiple times. For example, each job within a stage needs its own name, so if you define the job name in a template then you can't reuse it multiple times in the same stage.

> [!NOTE]
> When you work with complex sets of deployments, it can be helpful to create a dedicated Git repository for your templates. Then, you can reuse the same repository in multiple pipelines, even if they're for different projects. We provide a link to more information in the summary.

<!-- TODO figure out what this is about
> [!NOTE]
> Another way of using a template in a pipeline is by extending from it. This gives you an inheritance relationship between the template and your pipeline as opposed to a usage relationship. Additionally you can add extra security to your pipeline through this inheritance relationship. For the use case of Bicep template deployments to multiple environments extending from a template is out of scope. 
-->

## Template parameters

Pipeline template parameters make your template files easier to reuse, because you can allow for small differences whenever you use them.

When you create a pipeline template, you can indicate its parameters at the top of the file: 

:::code language="yaml" source="code/5-script-parameters.yml" range="1-6" :::

You can define as many parameters as you need. But just like Bicep parameters, try not to overuse pipeline template parameters - make it easy for someone else to reuse your template without having to specify too many settings.

Each pipeline template parameter has three properties:

- The *name* of the parameter, which you use to refer to the parameter in your template files.
- The *type* of the parameter. Parameters support several different types of data, including *string*, *number*, and *boolean*. You can also define more complex templates that accept structured objects and pipeline definitions like steps, jobs, and stages.
- The *default value* of the parameter. If you specify a default value, you effectively make the parameter optional.

In your pipeline template, you use a special syntax to refer to the value of the parameter. Use the `${{parameters.YOUR_PARAMETER_NAME}}` macro, like in this example: 

:::code language="yaml" source="code/5-script-parameters.yml" range="8-10" highlight="3" :::

You pass the value for a parameters to a pipeline template by using the `parameters` keyword, like in this example:

:::code language="yaml" source="code/5-parameters.yml" highlight="3-4, 6-7" :::

You can also use parameters when you assign names to your jobs and stages in pipeline templates too. This helps when you need to reuse the same template multiple times in your pipeline, like this:

:::code language="yaml" source="code/5-jobs-parameters.yml" highlight="7, 13" :::

## Conditions

You can use pipeline *conditions* to specify whether a step, job, or even stage should run depending on a value you specify. Template parameters and pipeline conditions can be used together to enable you to customize your deployment process for many different situations.

For example, imagine you define a pipeline template that runs a script steps. You'll reuse the template for each of your environments. When you deploy your production environment, you want to run an additional step. Here's how you can achieve that by using the `if` macro:

:::code language="yaml" source="code/5-script-conditions.yml" highlight="10" :::

The condition here translates to *if the environmentName parameter's value is equal to 'production', then run the following steps*.

> [!TIP]
> Pay attention to the YAML file's indentation when you use conditions. You need to indent the steps that the condition applies to by one extra level.

Even though conditions are a way to add flexibility to your pipeline, try not to not use too many of them. They complicate your pipeline and make it harder to reason about. If you see a lot of conditions in your pipeline template, it might indicate that a template might not be the best solution for the workflow you plan to run, and that you should redesign your pipeline.
