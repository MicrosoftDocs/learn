Pipelines allow you to automate the steps in your deployment process. Your process might include several logical groups of jobs that you want to run. In this unit, you'll learn about pipeline stages and how you use them to add quality control processes to your Bicep deployments.

## What are pipeline stages?

_Stages_ help you to divide your pipeline into multiple logical blocks. Each stage can contain one or more jobs. Jobs contain an ordered list of steps that should be completed, like running command-line scripts.

:::image type="content" source="../media/2-stages.png" alt-text="Diagram that shows a pipeline with a stage containing one job. The job contains four steps." border="false":::

Stages can be used in your pipeline to mark a separation of concerns. For example, when you work with Bicep code, _validating_ the code is a separate concern from _deploying_ your Bicep file. When you use an automated pipeline, building and testing your code are often called _continuous integration_ (CI). Deploying code in an automated pipeline is often called _continuous deployment_ (CD).

In CI stages, you check the validity of the changes that have been made to your code. CI stages provide quality assurance. They can be run without affecting your live production environment.

In many programming languages, code needs to be _built_ before someone can run it. When a Bicep file is deployed, it's converted, or _transpiled_, from Bicep to JSON. The tooling performs this process automatically. In most situations, you don't need to manually build Bicep code to JSON templates within your pipeline. We still use the term _continuous integration_ when we talk about Bicep code, though, because the other parts of CI still apply, such as validating your code.

After your CI stages run successfully, you should've increased your confidence that the changes you've made will deploy successfully too. In CD stages, you'll deploy your code to each of your environments. You'll usually start with test and other non-production environments and move through to production environments. In this module, we'll deploy to a single environment. In a future module, you'll learn how to extend your deployment pipeline to deploy to multiple environments, such as non-production and production environments.

Stages run in a sequence. You can control how and when each stage runs. For example, you can configure your CD stages to run only after your CI stages successfully run. Or, you might have multiple CI stages that need to run in sequence, such as to build your code and then test it. You might also include a _rollback_ stage that runs only if previous deployment stages failed.

## Shifting left

By using stages, you can verify the quality of your code before you deploy it. These stages are sometimes called _shifting left_.

Consider a timeline of the activities that you perform when you write code. The timeline starts from the planning and design phases. It then moves to the building and testing phases. Finally, you deploy and then have to support your solution.

:::image type="content" source="../../includes/media/shift-left.png" alt-text="Chart with a timeline on the horizontal axis, cost on the vertical axis, and a line showing that the cost increases the later an error is identified." border="false":::

It's a well-understood rule in software development that the earlier in the process that you find an error (the closer to the left of the timeline), the easier, quicker, and cheaper it is to fix. The later in the process that you catch an error, the harder it is to fix.

So, the goal is to shift the discovery of problems toward the left of the preceding diagram. Throughout this module, you'll see how you can add more validation and testing to your pipeline as it progresses.

You can even add validation well before your deployment begins. When you work with tools like Azure DevOps, _pull requests_ typically represent changes that someone on your team wants to make to the code on your main branch. It's helpful to create another pipeline that automatically runs your CI steps during the review process for the pull request. This technique helps validate that the code still works, even with the proposed changes. If the validation succeeds, you have some confidence that the change won't cause problems when it's merged to your main branch. If the check fails, you know there's more work to do to before the pull request is ready to merge.

> [!IMPORTANT]
> Automated validation and tests are only as effective as the tests you write. It's important to consider the things you need to test and the steps you need to perform to be confident that your deployment is OK.

## Define a pipeline stage

Every pipeline contains at least one stage. If your pipeline has only a single stage, you don't need to explicitly define it. Azure Pipelines automatically defines it for you. When you have multiple stages in a pipeline, you need to define each one. Stages run in a sequence that you specify.

Imagine that you've built a Bicep file that you need to deploy twice: once to infrastructure in the United States and once to infrastructure in Europe. Before you deploy, you validate your Bicep code. Here's an illustration of a multistage pipeline that defines this process:

:::image type="content" source="../media/2-stages-sequential.png" alt-text="Diagram that shows a pipeline with a Validate stage, a Deploy U S stage, and a Deploy Europe stage, running in sequence." border="false":::

Notice that this example has three stages. The **Validate** stage is similar to a CI stage. Then, the **DeployUS** and **DeployEurope** stages run. Each deploys the code to one of the environments.

Here's how the stages are defined in a pipeline YAML file:

:::code language="yaml" source="code/2-stages-sequential.yml" :::

## Control the sequence of stages

By default, the stages run in the order that you define. A stage runs only if the previous stage was successful. You can add dependencies between the stages to change the order.

Continuing the previous example, imagine that you want to run both of your deployments in parallel, like this:

:::image type="content" source="../media/2-stages-dependson.png" alt-text="Diagram that shows a pipeline with a Validate stage, a Deploy U S stage, and a Deploy Europe stage, with the two deployment stages running in parallel." border="false":::

You can specify the dependencies between stages by using the `dependsOn` keyword:

:::code language="yaml" source="code/2-stages-dependson.yml" highlight="8, 13" :::

When you use the `dependsOn` keyword, Azure Pipelines waits for the dependent stage to finish successfully before it starts the next stage. If Azure Pipelines detects that all of the dependencies for multiple stages have been satisfied, it can run those stages in parallel.

> [!NOTE]
> In reality, stages and jobs run in parallel only if you have enough agents to run multiple jobs at the same time. When you use Microsoft-hosted agents, you might need to purchase additional _parallel jobs_ to achieve this.

Sometimes, you want to run a stage when a previous stage fails. For example, here's a different pipeline. If the deployment fails, a stage called **Rollback** runs immediately afterward:

:::image type="content" source="../media/2-stages-condition.png" alt-text="Diagram that shows a pipeline with a Deploy stage, and a condition so that a failure in the Deploy stage results in the Rollback stage running." border="false":::

You can use the `condition` keyword to specify a condition that should be met before a stage runs:

:::code language="yaml" source="code/2-stages-condition.yml" highlight="13" :::

In the preceding example, when everything goes well, Azure Pipelines runs the **Validate** stage first, and then it runs the **Deploy** stage. It skips the **Rollback** stage. However, if the **Deploy** stage fails, Azure Pipelines runs the **Rollback** stage. You'll learn more about rollback later in this module.

Every job executes on a new agent. That means that every job will start from a clean environment, so in every job you typically need to check out the source code as your first step.

## Bicep deployment stages

A typical Bicep deployment pipeline contains several stages. As the pipeline moves through the stages, the goal is to become increasingly confident that the later stages will succeed. Here are the common stages for a Bicep deployment pipeline:

:::image type="content" source="../media/2-stages-bicep.png" alt-text="Diagram that shows a Bicep deployment pipeline with five stages: Lint, Validate, Preview, Deploy, and Smoke Test." border="false":::

1. **Lint**: Use the Bicep linter to verify that the Bicep file is well formed and doesn't contain any obvious errors.
1. **Validate**: Use the Azure Resource Manager preflight validation process to check for problems that might occur when you deploy.
1. **Preview**: Use the what-if command to validate the list of changes that will be applied against your Azure environment. Ask a human to manually review the what-if results and approve the pipeline to proceed.
1. **Deploy**: Submit your deployment to Resource Manager and wait for it to finish.
1. **Smoke Test**: Run basic post-deployment checks against some of the important resources that you've deployed. These reviews are called _infrastructure smoke tests_.

Your organization might have a different sequence of stages, or you might need to integrate your Bicep deployments into a pipeline that deploys other components. After you understand how the stages work, you can design a pipeline to suit your needs.

Throughout this module, you'll learn more about the stages listed here, and you'll progressively build a pipeline that includes each stage. You'll also learn:

- How pipelines stop the deployment process if anything unexpected happens in any of the previous stages.
- How to configure your pipeline to pause until you manually verify what happened in a previous stage.
