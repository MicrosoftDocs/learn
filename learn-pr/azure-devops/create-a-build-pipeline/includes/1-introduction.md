In the [Get started with Azure DevOps](../../../paths/evolve-your-devops-practices/index.yml?azure-portal=true) learning path, you helped the Tailspin team start their DevOps journey by evaluating their current processes and technologies, and then planning their initial set of tasks on Azure Boards.

In this module, you'll help the team with their first task: setting up a continuous integration (CI) pipeline for their app.

## Choose your training module development environment

This training module provides two options for running the pipeline that you create while completing the module.

* Choose **Local development environment using a Microsoft-hosted agent** if you want to use a Microsoft-hosted agent to run your pipeline. To run pipelines on a Microsoft-hosted agent, your Azure DevOps organization must have at least one Microsoft-hosted parallel job. [Check your Microsoft-hosted parallel jobs count](/azure/devops/pipelines/troubleshooting/troubleshooting#check-for-available-parallel-jobs) and if you don't have any:
  * [Request a free grant of parallel jobs](https://aka.ms/azpipelines-parallelism-request). The approval process for the free grant typically takes 2-3 business days. You can apply for the grant and return to complete the module when your request is approved.
  * [Pay for a parallel job](/azure/devops/pipelines/licensing/concurrent-jobs). If you want to use a Microsoft-hosted agent and don't want to wait 2-3 business days for the free grant, you can purchase a parallel job and complete the training using the paid job. For more information, see [Configure and pay for parallel jobs](/azure/devops/pipelines/licensing/concurrent-jobs).
* Choose **GitHub Codespaces development environment using a self-hosted agent** if you don't have any parallel jobs and you don't want to wait 2-3 business days for the free grant in order to use a Microsoft-hosted agent. The GitHub Codespaces environment for this training module includes the required development tools, and provides a self-hosted agent that runs the pipeline that you create in the training module. This is not a typical production scenario, but it does provide an environment for completing this training module. GitHub Codespaces provides a free tier of [included usage hours and storage](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts) ([charges may apply if you exceed the free tier - check your usage](https://docs.github.com/billing/managing-billing-for-github-codespaces/viewing-your-github-codespaces-usage)).

> [!NOTE]
> If you decide to change between **Local development environment using a Microsoft-hosted agent** and **GitHub Codespaces development environment using a self-hosted agent** after starting the training module, you should restart the module and follow the steps from the beginning.

## Training module scenario

The Tailspin web team is being pulled in many directions. Andy, the lead dev, is running from one meeting to another and never has any time. Amita, the QA person, is helping a tester on another team. Tim, who's in Ops, is upgrading his servers and hasn't been seen for days. Mara's dream of a true DevOps team is stalled (again).

But she isn't giving up. She remembers that she and the team used Azure Boards to create a backlog of issues with the build process:

:::image type="content" source="../../shared/media/build-all-tasks.png" alt-text="Screenshot of Azure Boards showing a backlog of issues.":::

She also remembers that they picked three of the issues to fix within the next two weeks. (Of course, everyone else has forgotten about them.)

:::image type="content" source="../../shared/media/build-initial-tasks.png" alt-text="Screenshot of Azure Boards showing the initial three tasks.":::

Mara decides to take an initial pass on the biggest issue, **Stabilize the build server**, herself. She won't try to fix everything. Instead, she's going to see if she can use Microsoft Azure Pipelines to replicate the current build process. She's convinced that Azure Pipelines provides enough benefits to improve the process. If she's right, she'll show her version to the team to see if she can make them more enthusiastic.

## Learning objectives

After completing this module, you'll be able to:

- Create a build pipeline in Azure Pipelines.
- Map manual build steps to automated build tasks.
- Publish your builds so others can access them.
- Use templates to build multiple configurations.

## Configure your environment

The modules in this learning path and previous learning path form a progression.

To follow the progression from the beginning, be sure to first complete the [Get started with Azure DevOps](../../../paths/evolve-your-devops-practices/index.yml?azure-portal=true) learning path.

::: zone pivot="github-codespaces-agent"

To complete this training module using a self-hosted agent with GitHub Codespaces you must have:

- An [Azure DevOps organization](/azure/devops/pipelines/get-started/pipelines-sign-up). If you don't already have an Azure DevOps organization, create a [free organization](/azure/devops/pipelines/get-started/pipelines-sign-up) before you begin. If you have completed the [Get started with Azure DevOps](../../../paths/evolve-your-devops-practices/index.yml?azure-portal=true) learning path prerequisite, use that Azure DevOps organization.
- A [GitHub](https://github.com/join?azure-portal=true) account

::: zone-end

::: zone pivot="ms-hosted-agents"

To complete this training module using a Microsoft-hosted agent, you need to set up a development environment on your Windows, macOS, or Linux system. You need:

[!include[](../../shared/includes/prerequisites.md)]

::: zone-end  

If your company's policy doesn't allow you to create an Azure DevOps project in your existing company Azure DevOps organization, you can create your own personal Azure DevOps organization. You can get started with Azure DevOps for free.

This Azure DevOps environment lets you complete the exercises in this and future modules. You can also use it to apply your new skills to your own projects.

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

You met the *Space Game* web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module:

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps, and is helping the team adopt a more streamlined process by using Microsoft Azure DevOps.
