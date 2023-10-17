
**Estimated time:** 45 minutes.

**Lab files:** none.

## Scenario

In this lab, you'll use **Mend Bolt (formerly WhiteSource) with Azure DevOps** to automatically detect vulnerable open source components, outdated libraries, and license compliance issues in your code. You'll use WebGoat, an intentionally insecure web application maintained by OWASP designed to illustrate common web application security issues.

[Mend](https://www.mend.io/) is the leader in continuous open source software security and compliance management. Mend integrates into your build process, irrespective of your programming languages, build tools, or development environments. It works automatically, continuously, and silently in the background, checking your open source components' security, licensing, and quality against Mend constantly updated definitive database of open source repositories.

Mend provides Mend Bolt, a lightweight open source security and management solution developed specifically for integrating Azure DevOps.

> [!NOTE]
> Mend Bolt works per project and doesn't offer real-time alert capabilities, which requires a **Full platform.**

Mend Bolt is recommended for larger development teams that want to automate their open source management throughout the entire software development lifecycle (from the repositories to post-deployment stages) and across all projects and products.

Azure DevOps integration with Mend Bolt will enable you to:

 -  Detect and remedy vulnerable open source components.
 -  Generate comprehensive open source inventory reports per project or build.
 -  Enforce open source license compliance, including dependencies' licenses.
 -  Identify outdated open source libraries with recommendations to update.

## Objectives

After completing this lab, you'll be able to:

 -  Activate Mend Bolt.
 -  Run a build pipeline and review the Mend security and compliance report.

## Requirements

 -  This lab requires **Microsoft Edge** or an [Azure DevOps-supported browser](/azure/devops/server/compatibility).
 -  **Set up an Azure DevOps organization:** If you don't already have an Azure DevOps organization that you can use for this lab, create one by following the instructions available at [Create an organization or project collection](/azure/devops/organizations/accounts/create-organization).

## Exercises

During this lab, you'll complete the following exercises:

 -  Exercise 0: Configure the lab prerequisites.
 -  Exercise 1: Implement Security and Compliance in an Azure DevOps pipeline using Mend Bolt.

[:::image type="content" source="../media/launch-exercise-25d42425.png" alt-text="Screenshot of a launch button which will take you to the lab.":::
](https://aka.ms/az-400-implement-security-and-compliance-azure-devops-pipeline)
