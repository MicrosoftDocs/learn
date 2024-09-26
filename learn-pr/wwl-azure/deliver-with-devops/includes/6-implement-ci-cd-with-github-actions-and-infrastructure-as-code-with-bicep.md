
**Estimated time:** 40 minutes.

## Scenario

Remember this module’s scenario in which you work for a software development company in the retail industry that wants to ensure that the release process of a new version of their online store application is efficient and reliable while minimizing the risk of errors. Since you have decided to use GitHub to facilitate application lifecycle management, this lab gives you the opportunity to fork and review the GitHub repo containing the source code of a web app, a GitHub Actions workflow, and a Bicep template. Additionally, you’ll be able to configure the target environment and validate the Infrastructure as Code (IaC) and CI/CD functionality.

Please note that in the previous lab, you configured GitHub Pages, which means you have already implemented continuous deployment, potentially without even realizing it. GitHub Pages uses GitHub Actions in the background to perform automated deployments following any commits to the main branch. You can verify this by navigating to the Actions tab on the main page of the forked repo, Spoon-Knife. Now, you will enhance this functionality. Specifically, you will use a custom-developed GitHub Actions workflow with a Bicep template to provision a couple of Azure App Service web apps in different Azure regions and deploy a custom .NET web app into both of them.

## Objectives

In this lab, you will:

 -  Prepare the Azure subscription for the lab
 -  Implement Infrastructure as Code (IaC) and CI/CD with GitHub Actions and a Bicep template

## Prerequisites

 -  Use the same GitHub account you created for the purpose of the [first lab](https://go.microsoft.com/fwlink/?linkid=2261093).
 -  Complete the first lab in this series, [Lab 01 - Agile Planning and Management using GitHub](https://go.microsoft.com/fwlink/?linkid=2261093).
 -  Complete the second lab in this series, [Lab 02 - Implement Flow of Work with GitHub](https://go.microsoft.com/fwlink/?linkid=2261094).

## Requirements

 -  This lab requires **Microsoft Edge** or an [Azure DevOps-supported browser](/azure/devops/server/compatibility).
 -  **GitHub account:** If you don't already have a GitHub account that you can use for this lab, create one by following the instructions available in the article [Creating an account on GitHub](https://docs.github.com/get-started/quickstart/creating-an-account-on-github).
 -  An **Azure subscription** to which you have at least the **Contributor-level access**. If you don't have an Azure subscription, you can sign up for a [free trial](https://azure.microsoft.com/free).

## Exercises

During this lab, you'll complete the following exercises:

 -  Exercise 0: Prepare the Azure subscription for the lab
 -  Exercise 1: Implement Infrastructure as Code (IaC) and CI/CD with GitHub Actions and a Bicep template

[:::image type="content" source="../media/launch-exercise-25d42425-89186225-a01e310c.png" alt-text="Screenshot of a launch button, which will take you to the lab.":::
 ](https://go.microsoft.com/fwlink/?linkid=2261725)
