
**Estimated time:** 60 minutes.

**Lab files:** none.

## Scenario

In the context of Azure DevOps, the term **technical debt** represents suboptimal means of reaching tactical goals, which negatively affects the ability to achieve strategic objectives in software development and deployment. Technical debt affects productivity by making code hard to understand, prone to failures, time-consuming to change, and difficult to validate. Without proper oversight and management, technical debt can accumulate over time and significantly impact the overall quality of the software and the productivity of development teams in the longer term.

[SonarCloud](https://sonarcloud.io) is a cloud-based code quality and security service. The main features of SonarCloud include:

 -  Support for 23 programming and scripting languages, including Java, JS, C\#, C/C++, Objective-C, TypeScript, Python, ABAP, PLSQL, and T-SQL.
 -  There are thousands of rules to track down hard-to-find bugs and quality issues based on powerful static code analyzers.
 -  Cloud-based integrations with popular CI services, including Travis, Azure DevOps, BitBucket, and AppVeyor.
 -  Deep code analysis for exploring all source files in branches and pull requests, helping reach a green Quality Gate and promote the build.
 -  Speed and scalability.

In this lab, you'll learn how to integrate Azure DevOps with SonarCloud.

> [!NOTE]
> Before you run this lab, ensure that you can run Azure Pipelines. Due to the change to public projects that took place in February 2021, access to pipelines will need to be requested: https://devblogs.microsoft.com/devops/change-in-azure-pipelines-grant-for-public-projects

## Objectives

After completing this lab, you'll be able to:

 -  Set up an Azure DevOps project and CI build to integrate with SonarCloud.
 -  Analyze SonarCloud reports.
 -  Integrate static analysis into the Azure DevOps pull request process.

## Requirements

 -  This lab requires **Microsoft Edge** or an [Azure DevOps-supported browser](/azure/devops/server/compatibility).
 -  **Set up an Azure DevOps organization:** If you don't already have an Azure DevOps organization that you can use for this lab, create one by following the instructions available at [Create an organization or project collection](/azure/devops/organizations/accounts/create-organization).

## Exercises

During this lab, you'll complete the following exercises:

 -  Exercise 0: Configure the lab prerequisites.
 -  Exercise 1: Configure Sonarcloud Setup.
 -  Exercise 2: Analyze SonarCloud reports.
 -  Exercise 3: Implement Azure DevOps pull request integration with SonarCloud.

[:::image type="content" source="../media/launch-exercise-25d42425.png" alt-text="Screenshot of a launch button which will take you to the lab.":::
](https://aka.ms/az-400-manage-technical-debt-with-sonarqube-and-azure-devops)
