Continuous Delivery (CD) is the practice of using automation to build, test, configure, and deploy from the build environment all the way to the final production environment.

Suppose that your development team is working on the company's product support website. You previously set up continuous integration (CI) by using GitHub Actions and workflows. Now you need to implement CD. Your CI workflow saves a container image. Your CD workflow must deploy this container to your staging and production environments. You talked with IT about how to create and tear down these environments as needed. You all decided to use GitHub Actions and workflows to support infrastructure as code.

In this module, you learn how to use GitHub Actions and workflows to implement a CD solution that deploys to Microsoft Azure Web Apps. The deployment uses a GitHub Action from the GitHub Marketplace. You also automate the creation and teardown of the deployment environments by using a workflow.

## Learning objectives

In this module, you will:

- Discover options for triggering a CD GitHub Workflow
- Understand steps to remove workflow artifacts
- Identify important environment protections  
- Control workflow execution with job conditionals
- Deploy to Microsoft Azure with a GitHub deploy action
- Store credentials with GitHub Secrets
- Create and destroy Azure resources with GitHub Actions and workflows

## Prerequisites

- A GitHub account
- The ability to navigate and edit files in GitHub
  - For more information about GitHub, see [Introduction to GitHub](https://github.com/skills/introduction-to-github).
- Basic familiarity with GitHub Actions and workflows
  - If you aren't familiar with workflows, jobs and steps, check out the [Automate development tasks by using GitHub Actions](/training/modules/github-actions-automate-tasks/) module.
- Basic familiarity with continuous integration using GitHub Actions and workflows
  - If you're unfamiliar with continuous integration using GitHub Actions and workflows, check out [Build continuous integration workflows by using GitHub Actions](/training/modules/github-actions-ci/)
- An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true)

This module assumes that you're already familiar with GitHub Actions and workflows that are used in CI. For an introduction, complete the [Automate development tasks by using GitHub Actions](/training/modules/github-actions-automate-tasks/) module and [Build continuous integration workflows by using GitHub Actions](/training/modules/github-actions-ci/) module.
