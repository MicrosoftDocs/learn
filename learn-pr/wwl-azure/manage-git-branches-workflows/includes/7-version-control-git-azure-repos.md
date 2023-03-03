> [!WARNING]
> Skip this lab. It will be retired soon.

**Estimated time:** 30 minutes.

**Lab files:** none.

## Scenario

Azure DevOps supports two types of version control, Git and Team Foundation Version Control (TFVC). Here's a quick overview of the two version control systems:

 -  **Team Foundation Version Control (TFVC):** TFVC is a centralized version control system. Typically, team members have only one version of each file on their dev machines. Historical data is maintained only on the server. Branches are path-based and created on the server.
 -  **Git:** Git is a distributed version control system. Git repositories can live locally (on a developer's machine). Each developer has a copy of the source repository on their dev machine. Developers can commit each set of changes on their dev machine, perform version control operations such as history, and compare without a network connection.

Git is the default version control provider for new projects. You should use Git for version control in your projects unless you need centralized version control features in TFVC.

In this lab, you'll learn how to work with branches and repositories in Azure DevOps.

## Objectives

After completing this lab, you'll be able to:

 -  Work with branches in Azure Repos.
 -  Work with repositories in Azure Repos.

## Requirements

 -  This lab requires **Microsoft Edge** or an [Azure DevOps-supported browser](/azure/devops/server/compatibility).
 -  **Set up an Azure DevOps organization:** If you don't already have an Azure DevOps organization that you can use for this lab, create one by following the instructions available at [Create an organization or project collection](/azure/devops/organizations/accounts/create-organization).
 -  [Git for Windows](https://gitforwindows.org/) download page. This will be installed as part of the prerequisites for this lab.
 -  [Visual Studio Code](https://code.visualstudio.com/). This will be installed as part of the prerequisites for this lab.

## Exercises

During this lab, you'll complete the following exercises:

> [!NOTE]
> If you completed **[Lab 02: Version Controlling with Git in Azure Repos](/learn/modules/work-azure-repos-github/7-version-control-git-azure-repos)**, you've already finished the steps in **Exercise 0: Configure the lab prerequisites** and **Exercise 1: Clone an existing repository** and can skip ahead to **Exercise 2: Manage branches from Azure DevOps**.

 -  Exercise 0: Configure the lab prerequisites.
 -  Exercise 1: Clone an existing repository.
 -  Exercise 2: Manage branches from Azure DevOps.
 -  Exercise 3: Manage repositories.

[:::image type="content" source="../media/launch-exercise-25d42425.png" alt-text="Screenshot of a launch button which will take you to the lab.":::
](https://microsoftlearning.github.io/AZ400-DesigningandImplementingMicrosoftDevOpsSolutions/Instructions/Labs/AZ400_M02_L02_Version_Controlling_with_Git_in_Azure_Repos.html)
