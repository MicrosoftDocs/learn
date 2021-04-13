Continuous Delivery (CD) is the practice of using automation to build, test, configure and deploy from the build environment all the way to the final production environment.  

Suppose that your development team is working on the company's product support website. You've already set up continuous integration (CI) by using GitHub Actions and workflows. Now you need to implement CD. Your CI workflow saves a container image. Your CD workflow will deploy this container to your staging and production environments. You've talked with IT about how to create and tear down these environments as needed and you've all decided to use GitHub Actions and workflows to support infrastructure as code.

In this module, you learn how to use GitHub Actions and workflows to implement a CD solution that deploys to Microsoft Azure Web Apps with a GitHub Action from the GitHub Marketplace. You also automate the creation and teardown of the deployment environments by using a workflow.

## Learning objectives

In this module, you will:

- Discover options for triggering a CD GitHub Workflow
- Control workflow execution with job conditionals
- Deploy to Microsoft Azure with a GitHub deploy action
- Store credentials with GitHub Secrets
- Create and destroy Azure resources with GitHub Actions and workflows

## Prerequisites

This module assumes you've completed the [Automate development tasks by using GitHub Actions](/learn/modules/github-actions-automate-tasks/) module and [Build continuous integration workflows by using GitHub Actions](/learn/modules/github-actions-ci/) module or that you're already familiar with GitHub Actions and workflows that are used in CI.

- A GitHub account
- The ability to navigate and edit files in GitHub
  - For more information about GitHub, see [Introduction to GitHub](https://lab.github.com/githubtraining/introduction-to-github?azure-portal=true).
- Basic familiarity with GitHub Actions and workflows
  - If you aren't familiar with workflows, jobs and steps, check out the [Automate development tasks by using GitHub Actions](/learn/modules/github-actions-automate-tasks/) module.
- Basic familiarity with continuous integration using GitHub Actions and workflows
  - If you're unfamiliar with continuous integration using GitHub Actions and workflows, check out [Build continuous integration workflows by using GitHub Actions](/learn/modules/github-actions-ci/)
- An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true).
- An understanding of [Microsoft Azure Fundamentals](https://docs.microsoft.com/learn/paths/az-900-describe-cloud-concepts/)