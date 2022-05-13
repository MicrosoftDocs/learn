**Estimated time:** 50 minutes.

**Lab files:** none.<br>

## Scenario

Azure DevOps supports two types of version control, Git and Team Foundation Version Control (TFVC). Here's a quick overview of the two version control systems:

 -  **Team Foundation Version Control (TFVC):** TFVC is a centralized version control system. Typically, team members have only one version of each file on their dev machines. Historical data is maintained only on the server. Branches are path-based and created on the server.
 -  **Git:** Git is a distributed version control system. Git repositories can live locally (on a developer's machine). Each developer has a copy of the source repository on their dev machine. Developers can commit each set of changes on their dev machine and perform version control operations such as history and compare without a network connection.

Git is the default version control provider for new projects. You should use Git for version control in your projects unless you need centralized version control features in TFVC.

In this lab, you'll learn how to establish a local Git repository, which can easily be synchronized with a centralized Git repository in Azure DevOps. In addition, you'll learn about Git branching and merging support. You'll use Visual Studio Code, but the same processes apply to using any Git-compatible client.

## Objectives

After completing this lab, you'll be able to:

 -  Clone an existing repository.
 -  Save work with commits.
 -  Review history of changes.
 -  Work with branches by using Visual Studio Code.

## Requirements

 -  This lab requires **Microsoft Edge** or an [Azure DevOps-supported browser](/azure/devops/server/compatibility).
 -  **Set up an Azure DevOps organization:** If you don't already have an Azure DevOps organization that you can use for this lab, create one by following the instructions available at [Create an organization or project collection](/azure/devops/organizations/accounts/create-organization).<br>
 -  [Git for Windows](https://gitforwindows.org) download page. This will be installed as part of the prerequisites for this lab.<br>
 -  [Visual Studio Code](https://code.visualstudio.com). This will be installed as part of the prerequisites for this lab.<br>

## Exercises

During this lab, you'll complete the following exercises:

 -  Exercise 0: Configure the lab prerequisites.
 -  Exercise 1: Clone an existing repository.
 -  Exercise 2: Save work with commits.
 -  Exercise 3: Review history.
 -  Exercise 4: Work with branches.

[:::image type="content" source="../media/launch-exercise-25d42425.png" alt-text="Button to launch exercise.":::
](https://microsoftlearning.github.io/AZ400-DesigningandImplementingMicrosoftDevOpsSolutions/Instructions/Labs/AZ400_M01_Version_Controlling_with_Git_in_Azure_Repos.html)
