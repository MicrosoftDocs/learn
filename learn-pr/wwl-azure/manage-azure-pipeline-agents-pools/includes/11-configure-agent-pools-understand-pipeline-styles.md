**Estimated time:** 45 minutes.

**Lab files:** none.

## Scenario

YAML-based pipelines allow you to fully implement CI/CD as code, in which pipeline definitions reside in the same repository as the code that is part of your Azure DevOps project. YAML-based pipelines support a wide range of features that are part of the classic pipelines, such as pull requests, code reviews, history, branching, and templates.

Regardless of the choice of the pipeline style, to build your code or deploy your solution by using Azure Pipelines, you need an agent. An agent hosts compute resources that run one job at a time. Jobs can be run directly on the host machine of the agent or in a container. You have an option to run your jobs using Microsoft-hosted agents, which are managed for you, or implementing a self-hosted agent that you set up and manage on your own.

In this lab, you will learn how to implement and use self-hosted agents with YAML pipelines.

## Objectives

After completing this lab, you'll be able to:

 -  Implement YAML-based pipelines.
 -  Implement self-hosted agents.

## Requirements

 -  This lab requires **Microsoft Edge** or an [Azure DevOps-supported browser](/azure/devops/server/compatibility).
 -  **Set up an Azure DevOps organization:** If you don't already have an Azure DevOps organization that you can use for this lab, create one by following the instructions available at [Create an organization or project collection](/azure/devops/organizations/accounts/create-organization).
 -  [Git for Windows](https://gitforwindows.org/) download page. This will be installed as part of the prerequisites for this lab.
 -  [Visual Studio Code](https://code.visualstudio.com/). This will be installed as part of the prerequisites for this lab.

## Exercises

During this lab, you'll complete the following exercises:

 -  Exercise 0: Configure the lab prerequisites.
 -  Exercise 1: Author YAML-based Azure Pipelines.
 -  Exercise 2: Manage Azure DevOps agent pools.

[:::image type="content" source="../media/launch-exercise-25d42425.png" alt-text="Screenshot of a launch button which will take you to the lab.":::
](https://aka.ms/az-400-configure-agent-pools-and-understand-pipeline-styles)
