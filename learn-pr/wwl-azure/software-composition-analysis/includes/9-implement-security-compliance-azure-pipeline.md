**Estimated time:** 45 minutes.

**Lab files:** none.

## Scenario

In this lab, you'll use **WhiteSource Bolt with Azure DevOps** to automatically detect vulnerable open source components, outdated libraries, and license compliance issues in your code. You'll use WebGoat, an intentionally insecure web application maintained by OWASP designed to illustrate common web application security issues.

[WhiteSource](https://www.whitesourcesoftware.com) is the leader in continuous open source software security and compliance management. WhiteSource integrates into your build process, irrespective of your programming languages, build tools, or development environments. It works automatically, continuously, and silently in the background, checking your open source components' security, licensing, and quality against WhiteSource constantly updated definitive database of open source repositories.

WhiteSource provides WhiteSource Bolt, a lightweight open source security and management solution developed specifically for integrating Azure DevOps.

> [!NOTE]
> WhiteSource Bolt works per project and doesn't offer real-time alert capabilities, which requires a **Full platform.**

WhiteSource Bolt generally is recommended for larger development teams that want to automate their open source management throughout the entire software development lifecycle (from the repositories to post-deployment stages) and across all projects and products.

Azure DevOps integration with WhiteSource Bolt will enable you to:

 -  Detect and remedy vulnerable open source components.
 -  Generate comprehensive open source inventory reports per project or build.
 -  Enforce open source license compliance, including dependencies’ licenses.
 -  Identify outdated open source libraries with recommendations to update.

## Objectives

After completing this lab, you'll be able to:

 -  Activate WhiteSource Bolt.
 -  Run a build pipeline and review the WhiteSource security and compliance report.

## Requirements

 -  This lab requires **Microsoft Edge** or an [Azure DevOps-supported browser](/azure/devops/server/compatibility).
 -  **Set up an Azure DevOps organization:** If you don't already have an Azure DevOps organization that you can use for this lab, create one by following the instructions available at [Create an organization or project collection](/azure/devops/organizations/accounts/create-organization).

## Exercises

During this lab, you'll complete the following exercises:

 -  Exercise 0: Configure the lab prerequisites.
 -  Exercise 1: Implement Security and Compliance in an Azure Pipeline using WhiteSource Bolt.

[:::image type="content" source="../media/launch-exercise-25d42425.png" alt-text="Screenshot of a launch button which will take you to the lab.":::
](https://microsoftlearning.github.io/AZ400-DesigningandImplementingMicrosoftDevOpsSolutions/Instructions/Labs/AZ400_M07_L15_Implement_Security_and_Compliance_in_an_Azure_Pipeline.html)
