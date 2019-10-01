Throughout this learning path, you helped the Tailspin team set up an automated CI/CD pipeline, complete with multiple stages and both functional and non-functional tests. 

In this module, you help the team solve another problem. How do they implement a deployment pattern that lets them release to production in a way that's best both for the company and for their users? You'll help them evaluate the different possibilities and then implement the one they decide on.

## Learning objectives

In this module, you will:

- Learn why deployment patterns matter.
- Compare different deployment patterns so you can choose the one that best suits your needs.
- Apply the blue-green deployment pattern in your pipeline.

## Prerequisites

The modules in this learning path form a progression.

To follow the progression from the beginning, be sure to first complete these learning paths:

* [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true)
* [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true)

We also recommend you start at the beginning of this learning path, [Deploy applications with Azure DevOps](/learn/paths/deploy-applications-with-azure-devops?azure-portal=true).

To take just this module, go through these modules first to get set up with Azure DevOps and set up your development environment.

* [Get started with Azure DevOps](/learn/modules/get-started-with-devops?azure-portal=true)
* [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline?azure-portal=true)
* [Create a release pipeline with Azure Pipelines](/learn/modules/create-release-pipeline?azure-portal=true)

When you're ready, make sure you have:

* Your _Space Game_ project loaded in Visual Studio Code.
* A browser window pointing to your fork of the _Space Game_ web site project on GitHub.
* A browser window pointing to your Azure DevOps organization.

> [!IMPORTANT]
> You also need your own Azure subscription to complete the exercises in this module. You can [get started for free](https://azure.microsoft.com?azure-portal=true) if you don't have an Azure subscription.

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

[!include[](../../shared/includes/meet-irwin-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more automated process that uses Azure DevOps.