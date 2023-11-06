Imagine that you're an infrastructure manager who's been asked to provision your Azure resources by using Terraform. After you've created your project, you plan to build and deploy your application by using an automation workflow.

## Provision, build, and deploy tracks

Automation ordinarily uses three tracks: *Provision*, *Build*, and *Deploy*. Each track can have one or more *pipelines*.

The following image displays multiple pipelines in the **Provision** track, with each pipeline focusing on the infrastructure for a team:

![Diagram highlighting the Provision pipeline elements for the various teams.](../media/1-tracks.png)

In this module's scenario, you'll use all three tracks by implementing multiple pipelines.

Azure supports several automation tools such as Jenkins, GitLab, GitHub Actions, and Azure Pipelines.

In this module, you can complete the exercises using GitHub Actions or Azure Pipelines.

## Learning objectives

In this module, you will:

- Create a Terraform configuration for your Azure resources.
- Provision your infrastructure and deploy it to Azure.
- Set up your project for continuous integration and continuous delivery (CI/CD) by using with an automation workflow (either GitHub Actions or Azure Pipelines).

## Prerequisites

- An Azure subscription
- A GitHub account
- (Optionally if you choose to use Azure Pipelines)
  - An Azure DevOps organization
  - [Terraform Azure Pipelines extension](https://marketplace.visualstudio.com/items?itemName=ms-devlabs.custom-terraform-tasks)
- Basic knowledge of software development
- Basic knowledge of managing and provisioning Azure resources
