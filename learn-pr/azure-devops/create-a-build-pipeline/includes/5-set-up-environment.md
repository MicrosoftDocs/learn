In this section, you'll ensure that your Microsoft Azure DevOps organization is set up to complete the rest of this module.

The modules in this learning path form a progression in which you follow the Tailspin web team through its DevOps journey.

This learning path also builds on the [Get started with Azure DevOps](../../../paths/evolve-your-devops-practices/index.yml?azure-portal=true) learning path. There, you used the Basic process to set up your Azure DevOps organization and created a task backlog on Azure Boards.

## Get the Azure DevOps project

Here, you ensure that your Azure DevOps organization is set up to complete the rest of this module. You do this by running a template that creates a project for you in Azure DevOps.

The modules in this learning path form a progression, where you follow the Tailspin web team through their DevOps journey. For learning purposes, each module has an associated Azure DevOps project, so you can start each module even if you haven't completed the previous modules.

### Run the template

To set up everything in your Azure DevOps organization, run a template.

> [!div class="nextstepaction"]
> [Run the template](https://azuredevopsdemogenerator.azurewebsites.net/?x-ms-routing-name=self&name=create-build-pipeline&azure-portal=true)

On the Azure DevOps Demo Generator site, to run the template, do these steps:

1. Select **Sign In** and accept the usage terms.
1. On the **Create New Project** page, enter a project name, like *Space Game - web - Pipeline*, select your Azure DevOps organization (in this example the organization name is `fabrikam`), and select **Create Project**.

    ::: zone pivot="github-codespaces-agent"

    > [!IMPORTANT]
    > You must specify the same Azure DevOps organization name here that you specified as your GitHub Codespaces secret for `ADO_ORG` in the [Set up secrets for self-hosted agent](../3-build-locally.yml#set-up-secrets-for-self-hosted-agent) procedure.

    ::: zone-end

    :::image type="content" source="../media/5-create-new-project.png" alt-text="Screenshot of creating a project through the Azure DevOps Demo Generator.":::

    It takes a moment for the template to run.
1. To go to your project in Azure DevOps, select **Navigate to project**.

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/training/modules/create-a-build-pipeline/9-clean-up-environment?azure-portal=true) unit at the end of this module provides important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes for Microst-hosted agents ([check your usage](/azure/devops/pipelines/troubleshooting/troubleshooting#check-for-available-parallel-jobs)), or GitHub Codespaces [included usage hours and storage](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts) ([charges may apply if you exceed the free tier - check your usage](https://docs.github.com/billing/managing-billing-for-github-codespaces/viewing-your-github-codespaces-usage)). Be sure to do the cleanup steps even if you don't complete this module.
