Continuous delivery (CD) is the process of getting code changes to the customer quickly and safely.

Suppose you work with a software development team that is working on your company's product support web site. You have set up continuous integration using GitHub Actions and workflows, and now you need to implement continuous delivery. In your continuous integration workflow, you've saved off a container image. You can now create a continuous delivery workflow to deploy this container to your staging and production environments. You talked with IT about getting these environments created and torn down as needed and you've all decided to use GitHub Actions workflows to support *infrastructure as code*.

In this module, you learn how to use GitHub Actions workflows to implement a continuous delivery solution to deploy a container-based web app to Microsoft Azure Web Apps. You also automate the creation and teardown of the deployment environments using a workflow.

## Learning objectives

In this module, you:

- discover options for triggering a continuous delivery GitHub Workflow
- control workflow execution with job conditionals
- deploying to Microsoft Azure with a GitHub deploy action
- store credentials with GitHub Secrets
- create and destroy Azure resources with GitHub Actions workflows

## Prerequisites

This module assumes you've completed the [Automate development tasks by using GitHub Actions](https://docs.microsoft.com/learn/github/github-actions-hello/?azure-portal=true) module and [Build continuous integration workflows by using GitHub Actions](https://docs.microsoft.com/learn/github/github-actions-ci/?azure-portal=true) module or that you're already familiar with GitHub Actions and workflow basics used in continuous integration.

- A GitHub account
- The ability to navigate and edit files in GitHub
  - For more information about GitHub, see [Introduction to GitHub](https://lab.github.com/githubtraining/introduction-to-github?azure-portal=true).
- Basic familiarity with GitHub Actions and workflows
  - If you aren't familiar with workflows, jobs and steps, check out the [Automate development tasks by using GitHub Actions](https://docs.microsoft.com/learn/github/github-actions-hello/?azure-portal=true) module.
- Basic familiarity with continuous integration using GitHub Actions and workflows
  - If you're unfamiliar with continuous integration using GitHub Actions and workflows, check out [Build continuous integration workflows by using GitHub Actions](https://docs.microsoft.com/learn/github/github-actions-ci/?azure-portal=true)
- An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true).
- An understanding of [Microsoft Azure Fundamentals](https://docs.microsoft.com/learn/paths/azure-fundamentals/?aure-portal=true)
