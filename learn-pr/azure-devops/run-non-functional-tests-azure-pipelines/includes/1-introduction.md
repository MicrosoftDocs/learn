In this module, you'll add non-functional tests &mdash; thats that check characteristics like performance and reliability &mdash; to the pipeline.

In [Run functional tests in Azure Pipelines](/learn/modules/run-functional-tests-azure-pipelines?azure-portal=true), you and the Tailspin web team added UI tests, a form of functional testing, to the pipeline. Functional tests verify the functionality, or behavior, of software. In other words, functional tests verify that each function of the software does what it should.

But what about the non-functional aspects of an application, such as performance and reliability? Once your service is operational and deployed to an environment, how can you determine the performance of your application under realistic and heavy loads? Does your application expose any possible loopholes or weaknesses which might cause an information breach?

In this module, you'll explore the types of non-functional tests you can run and run load tests in your pipeline with Apache JMeter.

## Learning objectives

In this module, you will:

- TODO Describe the role of functional and non-functional tests in a release pipeline.
- TODO Run functional UI tests in your pipeline's _Test_ stage.
- TODO Run non-functional load tests during _Staging_.

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