Pipelines enable you to automate the steps in your deployment process. Your process might include several logical groups of jobs you would like to execute. In this unit, you'll learn about pipeline stages and how you use them when you're deploying Bicep code.

## What are pipeline stages?

*Stages* help you to divide your pipeline into multiple logical blocks. Each stage can contain one or more jobs, and as you learned previously, jobs contain an ordered list of steps to run, like running command-line scripts.

Stages can be used in your pipeline to mark separation of concerns. When you work with Bicep code, *validating* the code is a separate concern to *deploying* your Bicep file. When you use an automated pipeline, building and testing your code are often referred to as *continuous integration*, or CI for short. Deploying code in an automated pipeline is often called *continuous deployment*, or CD for short.

In CI stages you check the validity of the changes that have been made to your code. CI stages provide quality assurance, and they can be executed without impacting your live production environment. In addition to running them before every deployment, it's common to run CI stages during code reviews before changes are merged to the *main* branch. By doing this, you minimize the chance of your changes causing problems.

> [!NOTE]
> In many programming languages, code needs to be *built* before someone can run it. While Bicep code gets transpiled to JSON ARM templates, this process is usually performed automatically by tooling. So, in most situations, you don't need to build Bicep code in your pipeline. We still use the terms *continuous integration* and *CI* when we talk about Bicep code, though, because the other parts of CI still apply, such as validating your code.

After your CI stages run successfully, you should have confidence that the changes you've made will deploy successfully too. In CD stages, you deploy your code to each of your environments, usually starting with test and other non-production environments, and moving through to production environments.

> [!NOTE]
> In this module, we'll deploy to a single environment. In a future module you'll learn how to extend your deployment pipeline to deploy to multiple environments, such as non-production and production environments.

Stages run in a sequence. You can control how and when each stage runs. For example, you can configure your CD stages to only run after your CI stages successfully run. Or, you might have multiple CI stages that need to run in sequence, such as to build your code and then test it. You might also include a *rollback* stage that only runs if previous deployment stages failed.

## Shifting left

By using stages, you can verify the quality of your code before you deploy it. This is sometimes called *shifting left*. Consider a timeline of the activities you perform when you write code, starting from the planning and design phases, through to the building and testing phases, to when you finally deploy and then have to support your code:

:::image type="content" source="../media/2-shift-left.png" alt-text="Chart with a timeline on the horizontal axis, cost on the vertical axis, and a line showing that the cost increases the later an error is identified." border="false":::

It's a well-understood rule in software development that the earlier in the process that you find errors - the closer to the left of the timeline - the easier and quicker it is to fix them. The later in your process that you catch an error, the harder and more complicated it is to fix. Throughout this module, you'll see how you can add increasingly more validation and testing to your pipeline as it progresses.

> [!TIP]
> Pull requests typically represent changes that someone on your team wants to make to the code on your main branch. It's helpful to create another pipeline that runs your CI steps during the pull request review process. This acts as a way to validate that the code still works, even with the proposed changes. If the validation succeeds, you have some confidence that the change won't cause problems when it's merged to your main branch. If the check fails, you know there's more work to do to before the pull request is ready to merge.

> [!IMPORTANT]
> Automated validation and tests are only as effective as the tests you write. So, it's important that you consider the things you need to test and the steps you need to perform to be confident that your deployment is OK.

## Define a pipeline stage

Every pipeline contains at least one stage. If your pipeline only has a single stage, you don't need to explicitly define it - Azure Pipelines automatically does it for you. When you have multiple stages in a pipeline, you need to define each one. Stages run in a sequence that you specify.

Imagine we have built a Bicep file that we need to deploy twice - once to infrastructure in the United States, and also to infrastructure in Europe. Before you deploy, you validate your Bicep code. Here's an illustration of a multistage pipeline to deploy the code:

:::image type="content" source="../media/2-stages-sequential.png" alt-text="Diagram showing a pipeline with a validate stage, a Deploy U S stage, and a Deploy Europe stage, running in sequence." border="false":::

Notice that in this example, there are three stages:

- **Validate**.
- **DeployUS** and **DeployEurope**, each of which deploys the code to one of the environments.

Here's how this is defined in a pipeline YAML file:

:::code language="yaml" source="code/2-stages-sequential.yml" :::

## Control the sequence of stages

By default, the stages run in the order you define them, and a stage only runs if the previous stage was successful. You can add dependencies between them to change the order. Continuing the example above, imagine you want to run both of our deployments in parallel, like this:

:::image type="content" source="../media/2-stages-dependson.png" alt-text="Diagram showing a pipeline with a validate stage, a Deploy U S stage, and a Deploy Europe stage, with the two deployment stages running in parallel." border="false":::

> [!TIP]
> Although you can configure your pipeline stages to run in parallel, in reality, they won't run in parallel unless you have enough agents to run multiple jobs at the same time. When you use Microsoft-hosted agents, you need to purchase additional *parallel jobs*.

You can specify the dependencies between stages by using the `dependsOn` keyword:

:::code language="yaml" source="code/2-stages-dependson.yml" highlight="7, 12" :::

When you use the `dependsOn` keyword, Azure Pipelines waits for the dependent stage to complete successfully before it starts the next stage. Sometimes, though, you want to run a stage when a previous stage fails. For example, here's a different pipeline. If the deployment fails, a stage called **Rollback** runs immediately afterwards:

:::image type="content" source="../media/2-stages-condition.png" alt-text="Diagram showing a pipeline with a deploy stage, and a condition so that a failure in the deploy stage results in the rollback stage running." border="false":::

You use the `condition` keyword to specify a condition that should be met before a stage executes:

:::code language="yaml" source="code/2-stages-condition.yml" highlight="12" :::

In the preceding example, when everything goes well, Azure Pipelines runs the **Validate** stage first, then it runs the **Deploy** stage. It skips the **Rollback** stage. However, if the **Deploy** stage fails, it runs the **Rollback** stage. You'll learn more about rollback later in this module.

## Bicep deployment stages

A typical Bicep deployment pipeline contains several stages. As the pipeline moves through the stages, the goal is to become increasingly confident that the later stages will succeed. Here are the common stages for a Bicep deployment pipeline:

:::image type="content" source="../media/2-stages.png" alt-text="Diagram showing a pipeline with five stages: Lint, Validate, Preview, Deploy, and Smoke Test." border="false":::

1. **Lint:** Check that the Bicep file is well-formed and doesn't contain any obvious errors.
1. **Validate:** Use the Resource Manager *preflight validation* process to check for problems that might occur when you deploy.
1. **Preview:** Use the what-if command to validate the list of changes that will be applied against your Azure environment. Ask a human to manually review the what-if results and approve the pipeline to proceed.
1. **Deploy:** Submit your deployment to Resource Manager and wait for it to complete.
1. **Smoke Test:** Run post-deployment smoke tests against some of the important resources that you've deployed.

> [!NOTE]
> Your organization might have a different sequence of stages, or you might need to integrate your Bicep deployments into a pipeline that deploys other components. Once you understand how the stages above work, you can design a pipeline to suit your needs.

Throughout this module, you'll learn more about these stages and progressively build a pipeline that includes each stage. You'll also learn how to stop a deployment if anything unexpected happens in any of the previous stages, and how to stop execution until you manually verify what happened in a previous stage.
