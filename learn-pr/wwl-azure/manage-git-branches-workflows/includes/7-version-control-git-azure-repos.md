
**Estimated time:** 60 minutes.

**Lab files:** none.

## Scenario

Azure DevOps supports two types of version control, Git and Team Foundation Version Control (TFVC). Here's a quick overview of the two version control systems:

 -  **Team Foundation Version Control (TFVC):** TFVC is a centralized version control system. Typically, team members have only one version of each file on their dev machines. Historical data is maintained only on the server. Branches are path-based and created on the server.
 -  **Git:** Git is a distributed version control system. Git repositories can live locally (on a developer's machine). Each developer has a copy of the source repository on their dev machine. Developers can commit each set of changes on their dev machine, perform version control operations such as history, and compare without a network connection.

Git is the default version control provider for new projects. You should use Git for version control in your projects unless you need centralized version control features in TFVC.

In this lab, you'll learn to establish a local Git repository, which can easily be synchronized with a centralized Git repository in Azure DevOps. In addition, you'll learn about Git branching and merging support. You'll use Visual Studio Code, but the same processes apply to using any Git-compatible client.

## Objectives

After completing this lab, you'll be able to:

 -  Clone an existing repository.
 -  Save work with commits.
 -  Review the history of changes.
 -  Work with branches by using Visual Studio Code.

## Requirements

 -  This lab requires **Microsoft Edge** or an [Azure DevOps-supported browser](/azure/devops/server/compatibility).
 -  **Set up an Azure DevOps organization:** If you don't already have an Azure DevOps organization that you can use for this lab, create one by following the instructions available at [Create an organization or project collection](/azure/devops/organizations/accounts/create-organization).
 -  If you don't have Git **2.29.2** or later installed, start a web browser, navigate to the [Git for Windows download page](https://gitforwindows.org/), and install it.
 -  If you don't have Visual Studio Code installed yet, navigate to the [Visual Studio Code download page](https://code.visualstudio.com/) from the web browser window, download it, and install it.
 -  If you don't have the Visual Studio C\# extension installed yet, navigate to the [C\# extension installation page](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp) in the web browser window and install it.

## Exercises

During this lab, you'll complete the following exercises:

 -  Exercise 0: Configure the lab prerequisites.
 -  Exercise 1: Clone an existing repository.
 -  Exercise 2: Save work with commits.
 -  Exercise 3: Review history.
 -  Exercise 4: Work with branches.

[:::image type="content" source="../media/launch-exercise-25d42425.png" alt-text="Screenshot of a launch button, which will take you to the lab.":::
](https://aka.ms/az-400-version-control-with-git-in-azure-repos)
