In this exercise, you will deploy a project plan template to Azure DevOps. That template will give you a sense of the work that needs to be done during this cloud adoption effort. In later exercises, you will expand that plan to include data gathered from the assessment features of Azure Migrate to create a refined plan for both migration and new innovation projects.

## Introduction to the cloud adoption plans

Azure DevOps is the set of cloud-based tools for Azure customers who manage iterative projects. It also includes tools for managing deployment pipelines and other important aspects of DevOps.

In this unit, you'll learn how to quickly deploy a backlog to Azure DevOps using a template. This template aligns cloud adoption efforts to a standardized process based on the guidance in the Cloud Adoption Framework.

## Pre-requisites

In Azure DevOps, users have different access levels - Basic, Stakeholder, and Visual Studio Subscriber. Access levels determine what features are available to users. In order to provision projects using the demo generator, you need at least a Basic access level. This error indicates the user has a stakeholder license, which does not grant permissions to writing shared queries

### Create an Azure DevOps account

If you don't have an Azure DevOps account, you can create one for free.

1) Browse to the [Azure DevOps homepage - https://azure.microsoft.com/en-us/services/devops/](https://azure.microsoft.com/en-us/services/devops/?azure-portal=true)
2) Click the "Start Free" link
:::image type="content" source="../media/azure-devops-start-free.png" alt-text="Azure DevOps home page with link to Start Free" border="false":::

3) Sign in using a Microsoft or GitHub Account
:::image type="content" source="../media/azure-devops-sign-in.png" alt-text="Azure DevOps sign in prompt" border="false":::

### Create a new organization in Azure DevOps

If you have an existing Azure DevOps account but don't have access to create new projects in your organization, you may want to create a new organization to use in this learn module.

1) [Sign in to Azure DevOps portal](https://dev.azure.com/?azure-portal=true)
2) Click the "New Organization" link in the left hand navigation
:::image type="content" source="../media/azure-devops-new-org.png" alt-text="Create a new organization in Azure DevOps" border="false":::
3) Enter a name for the new organization in the input box & click continue
:::image type="content" source="../media/azure-devops-new-org-create.png" alt-text="Name the new organization" border="false":::
4) If the organization has been successfully create, you will see a prompt to "Create a project"
:::image type="content" source="../media/azure-devops-new-org-project.png" alt-text="New organization created" border="false":::

You don't need to create a project at this time. But feel free to do so, if you'd like to get more familiar with Azure DevOps.

## Cloud adoption plan templates

To deploy the cloud adoption plan, open the [Azure DevOps demo generator](https://aka.ms/adopt/plan/generator?azure-portal=true).
The demo generator tool will require you to sign in with an account that has proper permissions, see pre-requisites above.
:::image type="content" source="../media/demo-generator-sign-in.png" alt-text="Sign in to the demo generator" border="false":::

Once you sign in, you'll be able to choose a template. There is a growing list of community-led Azure DevOps Templates for various purposes including DevOps Labs for demos of cool features or Microsoft Learn templates, which deploy projects you can use in other Learn Modules. The templates containing cloud adoption plans can be found in the "Cloud Adoption Framework" tab.
:::image type="content" source="../media/demo-generator-choose-template.png" alt-text="Choose a template" border="false":::

These templates help you plan out work required to implement some of the best practices found in CAF. In this case, choose the Cloud Adoption Plan template. This template will load a server migration planning that we can use throughout this module.
:::image type="content" source="../media/demo-generator-select-template.png" alt-text="Select the chosen template" border="false":::

Outside of this module, you can use the Cloud Adoption Plan templates to plan and manage work related to governance, SQL Migration, Knowledge mining, or a growing list of other cloud adoption activities.

> [!IMPORTANT]
> The suggested "Cloud Adoption Plan" template guides activities around migration and closely related upstream/downstream processes. There are a number of other templates which may be more applicable to your cloud adoption efforts, such as, AKS, SQL, WVD, or knowledge mining project plans. Feel free to use any of those plans during the remainder of this Learn module.

## Deploy your first cloud adoption plan

Once you've chosen your template, enter a name for the project (or plan) you want to deploy. I used "DemoForLearnModule" as my Project Name. You can do the same. Next, choose your DevOps Organization. If you don't have one, see the prerequisites above. Then click "Create Project".
:::image type="content" source="../media/demo-generator-create-project.png" alt-text="Create a project from the template" border="false":::

When your project is created, you will see a screen like the following. Click the "Navigate to project" button to open your new project template.
:::image type="content" source="../media/demo-generator-project-created.png" alt-text="Open your new project template" border="false":::

## Review your new backlog

When your new project opens, you will have access to a number of different DevOps related features. In this template, we will focus specifically on the backlog (or project plans).
:::image type="content" source="../media/new-project-home.png" alt-text="Get familiar with your new project" border="false":::

To open the project plan, hover on "Boards" in the left hand navigation. Then click on the "Backlogs" menu item.
:::image type="content" source="../media/new-project-backlogs.png" alt-text="Open the backlog" border="false":::

The backlog lists all of the different tasks in the project. But there is a better way to look at the project as a whole. Click on the "Stories" tab in the upper right corner. Then click on "Epics" to view the full project hierarchy. All of the tasks in this project are now grouped to align to the CAF Methodologies, or the phases of cloud adoption that you may need throughout your adoption journey.

:::image type="content" source="../media/new-project-epics.png" alt-text="Change view to Epic hierarchy" border="false":::

This new view is hierarchial. To drill into each phase, click the carrot next to any work item. That will expose it's child work items.
:::image type="content" source="../media/new-project-home.png" alt-text="Expand nodes in the hierarchy" border="false":::

The following list provides a quick translation of Azure DevOps terms to more traditional project terms:

- Epic: In this template, an epic is a phase of your cloud adoption or digital transformation program.
- Feature: In this template, each feature is a project required to complete that phase of adoption.
- User story: Each User Story is a shared goal or deliverable you will need to be successful when that phase is complete.
- Task: Each task is a unit of work that must be done to realize the goal or deliverable.

> [!WARNING]
> Bookmark the address of your new Azure DevOps project in this Epic backlog view. You will need this in the last unit of this learn module.

## Next Steps

You now have your first cloud adoption plan deployed. In future units, we will update this plan to reflect the actual work you need to complete specific to your business objectives.