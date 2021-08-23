With _pipelines_ you can automate the steps in your process. This process might include several stages or logical groups of jobs you would like to execute. A stage is a logical boundary in a pipeline. 

In this unit, you'll learn about pipeline stages.

## What are pipeline Stages

*Stages* help you to divide your pipeline into multiple logical blocks. Each stage can contain one or more jobs. The stages you define in your pipeline run in a sequence that you specify.

Stages can be used in your pipeline to mark separation of concerns. When you work with code, *building* the code is a separate concern to *testing* the code, and *deploying* the code is separate again. When you use an automated pipeline, building and testing your code are often referred to as *continuous integration*, or CI for short. Deploying code in an automated pipeline is often called *continuous deployment*, or CD for short. 

In CI stages you typically test the validity of the changes that you made to your code. You do this by building and testing the code. CI stages provide quality assurance, and they can be executed without impacting your actual running production environment. You often run CI stages during code reviews before your changes are merged to your *main* branch. This way, you minimize the chance of your changes causing problems.

After your CI stages run successfully, you should have confidence that the changes you've made will deploy successfully too. In CD stages, you deploy your code to each of your environments, usually starting with test environments and moving through to production.

> [!NOTE]
> Using CI stages in a pipeline helps you to *shift left*. This means that you do as many checks as possible early in your process, before you actually deploy anything. Shifting left helps you to catch errors early in your process. The later in your process you catch an error, the harder and more complicated it is to fix. 

The ideas of CI and CD also apply to your Bicep deployment pipelines. In the CI stages of your pipeline you should check the validity of your Bicep templates. In the CD stages you perform your actual deployment.

Stages will run in a sequence. You can control how and when each stage runs. For example, you can configure your CD stages to only run after your CI stages successfully run. Or, you might have multiple CI stages that need to run in sequence, such as to build your code and then test it. You might also include a *rollback* stage that only runs if a previous stage failed.

> [!NOTE]
> CI stages also often get linked to pull requests in Azure DevOps. Pull requests typically represent changes that someone on your team wants to make to the code on your main branch.
>
> It's helpful to run your CI stages during pull request review. This acts as a check to ensure that the code still builds and tests successfully, even with the proposed changes. If the check succeeds, you have some confidence that the change won't cause problems when it's merged to your main branch. If the check fails, you know there's more work to do to before the pull request is ready to merge.
>
> Automated checks and tests in pull requests are only as effective as the tests you write, so it's important that you consider the things you need to test and the steps you need to perform.

## How do you define pipeline stages?

Every pipeline has at least one stage. If your pipeline only has a single stage, you don't need to explicitly define it - Azure Pipelines will automatically do that for you. When you have multiple stages in a pipeline, you need to define each one. A stage contains multiple jobs, like in this example:

```YAML
stages:
- stage: Build
  jobs:
  - job: BuildFrontEnd
  - job: BuildBackEnd

- stage: Test
  - job: RunSyntaxTests
  - job: RunUnitTests

- stage: DeployToDev
  jobs:
  - job: DeployToDev

- stage: DeployToProduction
  jobs: 
  - job: DeployToProduction
```

By default, the stages run in the order you defined them, and a stage will only run if the previous stage was successful. You can also add dependencies between them to change the order, like this:

```yaml
stages:
- stage: Test

- stage: DeployUS1
  dependsOn: Test    # this stage runs after Test

- stage: DeployUS2
  dependsOn: Test    # this stage runs in parallel with DeployUS1, after Test

- stage: DeployEurope
  dependsOn:         # this stage runs after DeployUS1 and DeployUS2
  - DeployUS1
  - DeployUS2
```

You can also define *conditions*. Conditions enable you to indicate that a previous stage needs to have run successfully before starting the next stage, or even that a stage can only run if a previous stage failed, as in this example:

```YAML
stages:
- stage: Build
  jobs:
  - job: BuildFrontEnd
  - job: BuildBackEnd

- stage: Test
  dependsOn: Build
  condition: succeed('Build')
  - job: RunSyntaxTests
  - job: RunUnitTests

- stage: DeployToDev
  dependsOn: Test
  condition: succeed('Test')
  jobs:
  - job: DeployToDev

- stage: DeployToProduction
  dependsOn: DeployToDev
  condition: succeed('DeployToDev')
  jobs: 
  - job: DeployToProduction

- stage: Failover
  dependsOn: DeployToProduction
  condition: failed('DeployToProduction')
  jobs: 
  - job: Failover
```

In the above example, the **Build**, **Test**, **DeployToDev**, and **DeployToProduction** stages run in sequence assuming that the previous stage completed successfully. The **Failover** stage will only run in case the deployment to production fails.

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
