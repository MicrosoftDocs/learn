In [Manage your release workflow with Azure Pipelines](/learn/modules/manage-release-workflow?azure-portal=true), you helped the Tailspin web team design and build a release management workflow. This workflow enables the team to move changes through a series of stages, such as the dev stage and the test stage, all the way out to a production environment that's available to your users.

**NOTE--I thought it was just through Staging (pre-production) because they can't move to production without management sayso**

Right now, in the test stage, Amita still tests the web application manually as she always has. When she's satisfied, she manually promotes the application to staging, where management reviews the new features and decides if they want to make the release publicly available.  

In [Run quality tests in your build pipeline using Azure Pipelines](/learn/modules/run-quality-tests-build-pipeline?azure-portal=true), you incorporated unit and code coverage tests into the build process. These help ensure that there are no regression bugs and that the code meets a company's standards for quality and style. But what kinds of tests do you run once a service is operational and actually deployed to an environment?

In this module, you'll work with Amita and Tim as they learn how to add functional and non-functional tests to the pipeline. 

## Learning objectives

In this module, you will:

- Describe the role of functional and non-functional tests in a release pipeline.
- Run functional UI tests in your pipeline's _Test_ stage.
- Run non-functional load tests during _Staging_.

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

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more automated process that uses Azure DevOps.