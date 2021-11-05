When you deploy your changes to multiple environments, the steps involved in deploying to each environment are usually very similar or even identical. In this unit, you'll learn how to use called workflows to avoid repetition and to allow for reuse of your workflow code.

## Deployment to multiple environments

After talking to your colleagues on the website team, you decide on the following workflow for your toy company's website:

:::image type="content" source="../media/3-workflow.png" alt-text="Diagram that shows a series of workflow jobs, including those for test and production deployments." border="false":::

1. The workflow runs the Bicep linter to check that the Bicep code is valid and follows best practices. 

   Linting happens on the Bicep code without needing to connect to Azure, so it doesn't matter how many environments you're deploying to. It runs only once.

1. The workflow deploys to the test environment. This stage requires:

   1. Running the Azure Resource Manager preflight validation.
   1. Deploying the Bicep code.
   1. Running some tests against your test environment.

1. If any part of the workflow fails, then the whole workflow stops so you can investigate and resolve the issue. But if everything succeeds, your workflow continues to deploy to your production environment:

   1. The workflow runs a preview job, which runs the what-if operation on your production environment to list the changes that will be made to your production Azure resources. The preview job also validates your deployment, so you don't need to run a separate validation stage for your production environment.
   1. The workflow pauses for manual validation. 
   1. If approval is received, the workflow runs the deployment and smoke tests against your production environment.

Some of these stages are repeated between your test and production environments, and some are run only for specific environments:

| Stage | Environments |
|-|-|
| Lint | Neither - linting doesn't work against an environment |
| Validate | Test only |
| Preview | Production only |
| Deploy | Both environments |
| Smoke Test | Both environments |

When you need to repeat steps in your workflow, you might try to copy and paste your step definitions. However, this isn't a good practice. It's easy to accidentally make subtle mistakes or for things to get out of sync when you duplicate your workflow's code. And in the future, when you need to make a change to the steps, you have to remember to apply the change in multiple places.

## Called workflows

GitHub Actions enables you to create reusable sections of workflow definitions by creating a separate workflow YAML file that defines steps or jobs. You can create YAML files to reuse parts of a workflow multiple times within a single workflow, or even in multiple workflow. The workflow that you reuse is a *called workflow*, and the workflow that includes it is a *caller workflow*. Conceptually, you can think of them as being similar to Bicep modules.

When you create a reusable workflow, you use the `workflow_call` trigger to tell GitHub Actions that the workflow can be called by other workflows. Here's a basic example of a reusable workflow, saved in a file named *script.yml*:

:::code language="yaml" source="code/3-called-workflow.yml" highlight="2" :::

In the caller workflow, you refer to the called workflow by including the `uses:` keyword and specifying the path to the called workflow:

:::code language="yaml" source="code/3-caller-workflow.yml" highlight="6" :::

Ensure the path includes your GitHub username, the repository name, and the path to the workflow file you're using.

## Called workflow inputs and secrets

You can use *inputs* and *secrets* to make your called workflows easier to reuse, because you can allow for small differences in your workflows whenever you use them.

When you create a called workflow, you can indicate its inputs and secrets at the top of the file:

:::code language="yaml" source="code/3-called-workflow-inputs.yml" :::

You can define as many inputs and secrets as you need. But just like Bicep parameters, try not to overuse workflow inputs. You should make it easy for someone else to reuse your workflow without having to specify too many settings.

Inputs can have several properties, including:

- The *name* of the input, which you use to refer to the input in your workflow definitions.
- The *type* of the input. Inputs support several different types of data, including *string*, *number*, and *Boolean*. You can also define more complex workflows that accept structured objects.
- The *default value* of the input. This is optional. If you don't specify a default value, then a value must be provided when the workflow is used in caller workflow.

Secrets have names, but they don't have types or default values. <!-- TODO verify that -->

In your pipeline template, you use a special syntax to refer to the value of the parameter. Use the `${{parameters.YOUR_PARAMETER_NAME}}` macro, like in this example: 

:::code language="yaml" source="code/3-called-workflow-inputs.yml" :::

You pass the value for inputs to a called workflow by using the `with` keyword, like in this example:

:::code language="yaml" source="code/3-caller-workflow-inputs.yml" :::

<!-- TODO here down -->

## Conditions

You can use workflow *conditions* to specify whether a step, a job, or even a stage should run depending on a rule that you specify. You can combine template parameters and workflow conditions to customize your deployment process for many different situations.

For example, imagine you define a workflow template that runs script steps. You plan to reuse the template for each of your environments. When you deploy your production environment, you want to run an additional step. Here's how you can achieve that by using the `if` macro and the `eq` (*equals*) operator: <!-- TODO redo this -->

:::code language="yaml" source="code/3-script-conditions.yml" range="1-12" highlight="10" :::

The condition here translates to: *if the environmentType parameter's value is equal to 'Production', then run the following steps*.

> [!TIP]
> Pay attention to the YAML file's indentation when you use conditions like in the example above. The steps that the condition applies to need to be indented by one extra level.

You can also specify the `condition` property on a stage, job, or step. Here's an example that shows how you can use the `ne` (*not equals*) operator to specify a condition like *if the environmentType parameter's value is not equal to 'Production', then run the following steps*: <!-- TODO redo this -->

:::code language="yaml" source="code/3-script-conditions.yml" range="14-16" highlight="3" :::

Although conditions are a way to add flexibility to your workflow, try not to use too many of them. They complicate your workflow and make it harder to understand its flow. If you see a lot of conditions in a called workflow, then a called workflow might not be the best solution for the workflow that you plan to run, and you might need to redesign your overall workflow.

Also, consider using YAML comments to explain the conditions that you use and any other aspects of your workflow that might need more explanation. Comments help make your workflow easy to understand and work with in the future. You'll see some example YAML comments in the exercises throughout this module.
