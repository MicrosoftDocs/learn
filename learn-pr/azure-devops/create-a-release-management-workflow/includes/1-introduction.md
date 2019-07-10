In [Create a release pipeline with Azure Pipelines](/learn/modules/create-release-pipeline?azure-portal=true), you built a basic pipeline that deploys a web application to Azure App Service.

**TODO**: What's wrong with that? What are the problems? ;)

In this module, you'll join the Tailspin web team as they design and build a release management workflow. _Release management_ involves moving a build artifact through the various stages, such as testing and staging, all the way out to a production environment that's available to your users.

A good release management workflow enables you to release more frequently and more consistently. In practice, you'll want to define a process that maps to your team's needs. Here, you'll define a basic workflow that deploys the _Space Game_ web application to a development, test, and pre-production environment, each running on App Service.

## Learning objectives

In this module, you will:

- Compare the various tools and methods you can use to define a release management workflow
- Identify what makes a high-quality release pipeline
- Promote a build through the development, test, and pre-production stages

## Prerequisites

TODO: Update

The prerequisites are the same as the [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline?azure-portal=true) module.

Make sure you have the _Space Game_ project loaded in Visual Studio Code and your _Space Game_ project on GitHub handy.

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more streamlined process using Azure DevOps.