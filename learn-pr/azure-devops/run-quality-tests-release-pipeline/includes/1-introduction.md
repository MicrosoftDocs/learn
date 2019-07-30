In [Create a release management workflow](/learn/modules/create-a-release-management-workflow?azure-portal=true), you helped the Tailspin web team design and build a release management workflow. This workflow enables the team to move changes through a series of stages, such as the dev stage and the test stage, all the way out to a production environment that's available to your users.

**NOTE--I thought it was just through Staging (pre-production) because they can't move to production without management sayso**

Right now, in the test stage, Amita still tests the web application manually as she always has. When she's satisfied, she manually promotes the application to staging, where management reviews the new features and decides if they want to make the release publicly available.  

In [Run quality tests in your build pipeline using Azure Pipelines](/learn/modules/run-quality-tests-build-pipeline?azure-portal=true), you incorporated unit and code coverage tests into the build process. These help ensure that there are no regression bugs and that the code meets a company's standards for quality and style. But what kinds of tests do you run once a service is operational and actually deployed to an environment?

In this module, you'll work with Amita and Tim as they learn how to add functional and non-functional tests to the pipeline. 

## Learning objectives

In this module, you will:

- Learn what functional and non-functional tests are
- Add a functional UI test to the pipeline's test environment
- Add a non-functional load test to the pipeline's staging environment

## Prerequisites

TODO: Update

TODO: Also talk about how you need your own Azure sub and how to set one up :/

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

Mara has prior experience with DevOps and is helping the team adopt a more automated process using Azure DevOps.