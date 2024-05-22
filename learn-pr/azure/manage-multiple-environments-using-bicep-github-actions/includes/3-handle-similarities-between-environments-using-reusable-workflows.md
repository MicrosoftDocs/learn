When you deploy your changes to multiple environments, the steps involved in deploying to each environment are similar or even identical. In this unit, you'll learn how to design your workflows to avoid repetition and to allow for reuse of your workflow code.

## Deployment to multiple environments

After talking to your colleagues on the website team, you decide on the following workflow for your toy company's website:

:::image type="content" source="../media/3-workflow.png" alt-text="Diagram that shows a series of workflow jobs and includes test and production deployments." border="false":::

1. The workflow runs the Bicep linter to check that the Bicep code is valid and follows best practices.

   Linting happens on the Bicep code without needing to connect to Azure, so it doesn't matter how many environments you're deploying to. It runs only once.

1. The workflow deploys to the test environment and requires:

   1. Running the Azure Resource Manager preflight validation.
   1. Deploying the Bicep code.
   1. Running some tests against your test environment.

1. If any part of the workflow fails, then the whole workflow stops so you can investigate and resolve the issue. But if everything succeeds, your workflow continues to deploy to your production environment:

   1. The workflow includes a preview step, which runs the what-if operation on your production environment to list the changes that will be made to your production Azure resources. The what-if operation also validates your deployment, so you don't need to run a separate validation step for your production environment.
   1. The workflow pauses for manual validation.
   1. If approval is received, the workflow runs the deployment and smoke tests against your production environment.

Some of these tasks are run in both your test and production environments, and some are run only for specific environments:

| Task | Environments |
|-|-|
| Lint | Neither - linting doesn't work against an environment |
| Validate | Test only |
| Preview | Production only |
| Deploy | Both environments |
| Smoke Test | Both environments |

When you need to repeat steps in your workflow, copying and pasting your step definitions isn't a good practice. It's easy to accidentally make subtle mistakes or for things to get out of sync when you duplicate your workflow's code. And in the future, when you need to make a change to the steps, you have to remember to apply the change in multiple places. A better practice is to use reusable workflows.

## Reusable workflows

GitHub Actions enables you to create reusable sections of workflow definitions by creating a separate workflow YAML file that defines steps or jobs. You can create YAML files to reuse parts of a workflow multiple times within a single workflow, or even in multiple workflows. The workflow that you reuse is a _called workflow_, and the workflow that includes it's a _caller workflow_. Conceptually, you can think of them as being analogous to Bicep modules.

When you create a reusable workflow, you use the `workflow_call` trigger to tell GitHub Actions that the workflow can be called by other workflows. Here's a basic example of a reusable workflow, saved in a file named _script.yml_:

:::code language="yaml" source="code/3-called-workflow.yml" highlight="2" :::

In the caller workflow, you refer to the called workflow by including the `uses:` keyword and specifying the path to the called workflow within the current repository:

:::code language="yaml" source="code/3-caller-workflow.yml" highlight="6" :::

You can also refer to a workflow definition file in another repository.

## Called workflow inputs and secrets

You can use _inputs_ and _secrets_ to make your called workflows easier to reuse, because you can allow for small differences in your workflows whenever you use them.

When you create a called workflow, you can indicate its inputs and secrets at the top of the file:

:::code language="yaml" source="code/3-called-workflow-inputs.yml" range="1-13" :::

You can define as many inputs and secrets as you need. But just like Bicep parameters, try not to overuse workflow inputs. You should make it easy for someone else to reuse your workflow without having to specify too many settings.

Inputs can have several properties, including:

- The _name_, which you use to refer to the input in your workflow definitions.
- The _type_. Inputs support _string_, _number_, and _Boolean_ values.
- The _default value_, which is optional. If you don't specify a default value, then a value must be provided when the workflow is used in a caller workflow.

Secrets have names, but they don't have types or default values.

In the example, the workflow defines a mandatory string input named `environmentType`, and three mandatory secrets named `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, and `AZURE_SUBSCRIPTION_ID`.

In your workflow, you use a special syntax to refer to the value of the parameter, like in this example:

:::code language="yaml" source="code/3-called-workflow-inputs.yml" range="15-20" highlight="6" :::

You pass the value for inputs to a called workflow by using the `with` keyword. You need to define the values for each input within the `with` section - you can't use the `env` keyword to refer to a workflow's environment variables. You pass secret values to a called workflow by using the `secrets` keyword.

:::code language="yaml" source="code/3-caller-workflow-inputs.yml" highlight="11-16, 20-25" :::

## Use workload identities from called workflows

When you work with called workflows, you often define some of your deployment actions across multiple workflow definition files. You need to grant permission to the caller workflow, which then ensures that every called workflow is able to access the workflow's identity and authenticate to Azure:

:::code language="yaml" source="code/3-caller-workflow-inputs.yml" highlight="4-6" :::

## Conditions

You use workflow _conditions_ to specify whether a step or a job should run depending on a rule that you create. You can combine inputs and workflow conditions to customize your deployment process to suit your needs.

For example, imagine you define a workflow that runs the steps in a script. You plan to reuse the template for each of your environments. When you deploy your production environment, you want to run another step. Here's how you can achieve that by using the `if` condition on the step:

:::code language="yaml" source="code/3-script-conditions.yml" range="15-24" highlight="10" :::

The condition here translates to: _if the environmentType parameter's value is equal to 'Production', then run the step_.

Although conditions add flexibility to your workflow, too many of them can complicate your workflow and make it harder to understand. If you have many conditions in a called workflow, you might want to consider redesigning it.

Also, use YAML comments to explain the conditions that you use and any other aspects of your workflow that might need more explanation. Comments help make your workflow easier to understand and work with in the future. There are some example YAML comments in the exercises throughout this module.
