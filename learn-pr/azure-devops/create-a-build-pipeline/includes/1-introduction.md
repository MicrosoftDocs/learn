In the [Get started with Azure DevOps](../../../paths/evolve-your-devops-practices/index.yml?azure-portal=true) learning path, you helped the Tailspin team start their DevOps journey by evaluating their current processes and technologies, and then planning their initial set of tasks on Azure Boards.

In this module, you'll help the team with their first task: setting up a continuous integration (CI) pipeline for their app.

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

## Prerequisites

The modules in this learning path and previous learning path form a progression.

To follow the progression from the beginning, be sure to first complete the [Get started with Azure DevOps](../../../paths/evolve-your-devops-practices/index.yml?azure-portal=true) learning path.

This module includes the option to use [GitHub Codespaces](https://github.com/features/codespaces) or a [Microsoft-hosted agent](/azure/devops/pipelines/agents/hosted). If you'd like to use a Microsoft-hosted agent, [check your parallel jobs and request a free grant](/azure/devops/pipelines/troubleshooting/troubleshooting#check-for-available-parallel-jobs).

* **GitHub Codespaces** - Choose **GitHub codespaces** to follow the steps of this module using a development environment provided in GitHub Codespaces. You won't need to install any development tools on your local machine, and the GitHib Codespaces environment also hosts the agent to run your pipeline.
* **Microsoft-hosted agent** - Choose **Microsoft-hosted agent** to follow the steps of this module using your local development environment and a Microsoft-hosted agent. Before starting, [check your parallel jobs](/azure/devops/pipelines/troubleshooting/troubleshooting#check-for-available-parallel-jobs), and if you don't have any, [request a free grant](https://aka.ms/azpipelines-parallelism-request). The approval process for the free grant typically takes 2-3 business days.

> [!IMPORTANT]
> You can't switch between **GitHub codespaces** and **Microsoft-hosted agent** when completing the training module.

The prerequisites for this learning path vary depending on which option you select.

#### [GitHub Codespaces](#tab/codespaces)

- An [Azure DevOps organization](/azure/devops/pipelines/get-started/pipelines-sign-up). If you don't already have an Azure DevOps organization, create a [free organization](/azure/devops/pipelines/get-started/pipelines-sign-up) before you begin.
- An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true). If you don't already have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.
- A [GitHub](https://github.com/join?azure-portal=true) account

#### [Microsoft-hosted agent](#tab/hosted-agent)

If you want to start with this learning path, you need to set up a development environment on your Windows, macOS, or Linux system. You need:

[!include[](../../shared/includes/prerequisites.md)]

---

If your company's policy doesn't allow you to create an Azure DevOps organization, you can create your own personal account. You can get started with Azure DevOps for free.

This environment lets you complete the exercises in this and future modules. You can also use it to apply your new skills to your own projects.

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

You met the *Space Game* web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module:

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps, and is helping the team adopt a more streamlined process by using Microsoft Azure DevOps.
