Talk about CD and release pipeline.

## Learning objectives

In this module, you will:

- Learn about continuous delivery
- Create a release pipeline that deploys an app to an Azure AppService
- Create a release dashboard that monitors the success of the deployments

## Prerequisites

If you don't already have an [Azure DevOps](https://dev.azure.com?azure-portal=true) organization, go through the [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true) learning path before starting this module.

You'll also need to set up a development environment on your Windows, macOS, or Linux system. You'll need:

* [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
* [.NET Core 2.1](https://www.microsoft.com/net/download?azure-portal=true)
* [Git](https://git-scm.com/downloads?azure-portal=true)
* A [GitHub](https://github.com/join?azure-portal=true) account

This environment lets you complete the exercises in this and future modules. You can also use it to apply your new skills to your own projects.

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more streamlined process using Azure DevOps.

The Tailspin team is starting to feel better about their build process. They’ve got an automated version running on Azure Pipelines, which means the build environment is stable. Amita knows immediately when there’s an artifact for her to test. She’s finding fewer bugs because Andy and Mara have started to add unit tests and code quality tests. Life is looking good. 

Everyone on the team is in the meeting room waiting for Irwin, the product manager, who says he wants to talk to them. They’re looking forward to telling him about the progress they’ve made. But when Irwin walks in, he doesn’t look happy. He starts talking right away.

“I had a meeting this morning with the execs. They want to know why we’re taking so long to release our games and websites. Our closest competitors get new features and new games out there much faster than we do. We need to speed things up. I’m not just saying this to you. I’m saying it to all the teams. What can we do to help your team deploy faster?” He looks around. “Anyone?”

Andy clears his throat. “This is a little sudden but we’re a bit ahead of you. We’ve been automating our build process and that’s been helpful. Maybe now it’s time to extend our automation to how we deploy our apps.”

Irwin asks, “How do you do this?”

Mara says, “We created an automated build pipeline with Azure Pipelines. It builds an artifact that Amita can test. We could also use Azure Pipelines to build a continuous delivery pipeline (CD).”

“Which is what?”

“It’s a pipeline that...

Irwin's mobile beeps. He reads a text, mutters under his breath, and says, "I'm really sorry but this is urgent. I have to go. Why don't you all figure out this CD business and get back to me--soon." 

Andy looks around at his team. "Coffee?"









