Pipelines enable you to automate the steps in your deployment process. Your process might include several logical groups of jobs you would like to execute. In this unit, you'll learn about pipeline stages and how you use them when you're deploying Bicep code.

## What are pipeline stages?

*Stages* help you to divide your pipeline into multiple logical blocks. Each stage can contain one or more jobs. Stages run in a sequence that you specify.

Stages can be used in your pipeline to mark separation of concerns. When you work with code, *building* the code is a separate concern to *testing* the code, and *deploying* the code is separate again. When you use an automated pipeline, building and testing your code are often referred to as *continuous integration*, or CI for short. Deploying code in an automated pipeline is often called *continuous deployment*, or CD for short. 

In CI stages you typically test the validity of the changes that have been made to your code. You do this by building and testing the code. CI stages provide quality assurance, and they can be executed without impacting your actual running production environment. In addition to running them before every deployment, it's common to run CI stages during code reviews before changes are merged to the *main* branch. By doing this, you minimize the chance of your changes causing problems.

After your CI stages run successfully, you should have confidence that the changes you've made will deploy successfully too. In CD stages, you deploy your code to each of your environments, usually starting with test and other non-production environments, and moving through to production environments.

> [!NOTE]
> Using CI stages help you to run as many checks as possible early in your process, before you actually deploy anything. This is sometimes called *shifting left*. Imagine a timeline moving from left to right. The earlier in the process - the closer to the left of the timeline - that you find errors, the easier and quicker it is to fix them. The later in your process that you catch an error, the harder and more complicated it is to fix. 

The ideas of CI and CD also apply to your Bicep deployment pipelines. In the CI stages of your pipeline you should check the validity of your Bicep templates. In the CD stages you perform your actual deployment, starting with non-production environments.

## Order of stages

Stages run in a sequence. You can control how and when each stage runs. For example, you can configure your CD stages to only run after your CI stages successfully run. Or, you might have multiple CI stages that need to run in sequence, such as to build your code and then test it. You might also include a *rollback* stage that only runs if previous deployment stages failed.

> [!NOTE]
> CI stages also often get linked to pull requests in Azure DevOps. Pull requests typically represent changes that someone on your team wants to make to the code on your main branch.
>
> It's helpful to run your CI stages during pull request review. This acts as a check to ensure that the code still builds and tests successfully, even with the proposed changes. If the check succeeds, you have some confidence that the change won't cause problems when it's merged to your main branch. If the check fails, you know there's more work to do to before the pull request is ready to merge.
>
> Automated checks and tests in pull requests are only as effective as the tests you write, so it's important that you consider the things you need to test and the steps you need to perform.

## Define a pipeline stage

Every pipeline has at least one stage. If your pipeline only has a single stage, you don't need to explicitly define it - Azure Pipelines automatically does it for you. When you have multiple stages in a pipeline, you need to define each one.

Imagine we have built some code that will be deployed to infrastructure in the United States and Europe. Here's an illustration of a multistage pipeline to deploy the code:

:::image type="content" source="../media/2-stages-sequential.png" alt-text="TODO" border="false":::

Notice that in this example, there are four stages:

- **Test**, which includes two jobs.
- **DeployToPreProduction**, which deploys the code to a pre-production environment by running a single job.
- **DeployToProductionUS** and **DeployToProductionEurope**, each of which deploys the code to one of the production environments.

Here's how this is defined in a pipeline YAML file:

:::code language="yaml" source="code/2-stages-sequential.yml" :::

By default, the stages run in the order you define them, and a stage only runs if the previous stage was successful. You can add dependencies between them to change the order. Continuing the example above, imagine we want to run both of our production deployments in parallel, like this:

:::image type="content" source="../media/2-stages-dependson.png" alt-text="TODO" border="false":::

We can specify the dependencies between stages by using the `dependsOn` keyword:

:::code language="yaml" source="code/2-stages-dependson.yml" highlight="11, 16" :::

When you use the `dependsOn` keyword, Azure Pipelines waits for the dependent stage to complete successfully before it starts the next stage. Sometimes, though, you want to run a stage when a previous stage fails. For example, here's a different pipeline. If the production deployment fails, a stage called **Rollback** runs immediately afterwards:

:::image type="content" source="../media/2-stages-condition.png" alt-text="TODO" border="false":::

You use the `condition` keyword to specify a condition that should be met before a stage executes:

:::code language="yaml" source="code/2-stages-condition.yml" highlight="16" :::

In the preceding example, when everything goes well, Azure Pipelines runs the **Test** stage first, then it runs the **DeployToPreProduction** stage, and then the **DeployToProduction** stage. It skips the **Rollback** stage. However, if the **DeployToProduction** stage fails, it runs the **Rollback** stage.

TODO note that what the rollback stage does is up to you

## Stages and Bicep pipelines

The ideas of CI and CD stages apply to Bicep pipelines, too. The actual deployment of a Bicep file is included in the CD section of a pipeline. The CI section is a little different, though.

CI stages can contain all of the steps necessary to build confidence that the code can be integrated and deployed successfully. When you work with Bicep code, you can also include a **Build** stage, because Bicep code can be built (*transpiled*) into JSON ARM templates. Also, there are various tests and checks that you should run on your Bicep code, and it's a good idea to run them before your deployment starts.

```YAML
- stage: Build
  jobs:
  - job: Build

- stage: Deploy
  jobs:
  - job: Deploy
```

You can also check what changes will happen to your environment before your Bicep template gets actually deployed: 

```YAML
- stage: Build
  jobs:
  - job: Build

- stage: WhatIf
  jobs:
  - job: WhatIf

- stage: Deploy
  jobs:
  - job: Deploy
```

After your deployment executes, you may also want to confirm that your deployment succeeded, and whether the resources you intended to deploy are working as you expect:

```YAML
- stage: Build
  jobs:
  - job: Build

- stage: WhatIf
  jobs:
  - job: WhatIf

- stage: Deploy
  jobs:
  - job: Deploy

- stage: RunFunctionalTests
  jobs:
  - job: RunFunctionalTests
```

If your functional tests don't give you the result you expect, you might decide to roll back your changes: 

```YAML
- stage: Build
  jobs:
  - job: Build

- stage: WhatIf
  jobs:
  - job: WhatIf

- stage: Deploy
  jobs:
  - job: Deploy

- stage: RunFunctionalTests
  jobs:
  - job: RunFunctionalTests

- stage: Rollback
  dependsOn: [Deploy, RunFunctionalTests]
  condition: 'failed()'
  jobs:
  - job: Rollback
```

Throughout this module, you'll learn more about these stages. You'll also learn how to stop a deployment if anything unexpected happens in any of the previous stages, and how to stop execution until you manually verify what happened in a previous stage.
