This module is all about setting up a continuous integration (CI) pipeline for your application.

The *Space Game* web team is being pulled in many directions. Andy, the lead dev, is running from one meeting to another and never has any time. Amita, the QA person, is helping a tester on another team. Tim, who's in ops, is upgrading his servers and hasn't been seen for days. Mara's dream of a true DevOps team is stalled (again).

But she isn't giving up. She remembers that she and the team used Azure Boards to create a backlog of issues with the build process:

![Backlog of tasks](../../shared/media/build-all-tasks.png)

She also remembers that they picked three of the problems to fix within the next two weeks. (Of course, everyone else has forgotten about them.)

![Azure Boards showing the initial three tasks](../../shared/media/build-initial-tasks.png)

Mara decides to take an initial pass on the biggest issue, **Stabilize the build server**, herself. She won't try to fix everything. Instead, she's going to see if she can use Azure Pipelines to replicate the current build process. She's convinced that Azure Pipelines provides enough benefits to improve the process. If she's right, she'll show her version to the team to see if she can make them more enthusiastic.

## Learning objectives

In this module, you will:

- Create a build pipeline in Azure Pipelines
- Map the manual build steps to automated build tasks
- Publish your builds so others can access them
- Use templates to build multiple configurations

## Prerequisites

If you don't already have an [Azure DevOps](https://dev.azure.com?azure-portal=true) organization, work through the [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true) learning path before starting this module.

You'll also need to set up a development environment on your Windows, macOS, or Linux system. You'll need:

* [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
* [.NET Core 2.1](https://www.microsoft.com/net/download?azure-portal=true)
* [Git](https://git-scm.com/downloads?azure-portal=true)
* A [GitHub](https://github.com/join?azure-portal=true) account

This environment lets you complete the exercises in this and future modules. You can also use it to apply your new skills to your own projects.

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

You met the *Space Game* web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module:

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more streamlined process by using Azure DevOps.