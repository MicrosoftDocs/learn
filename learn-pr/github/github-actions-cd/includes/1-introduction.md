Continuous delivery (CD) is the process of getting code changes to the customer quickly and safely. To do this, development teams might set up a workflow where code is checked in to a repository, the project is built, the unit tests are run, the package is deployed to a testing or staging environment, and finally the package is deployed to production.  All of these tasks are automated to enusre they are run often and that if a problem is encountered in one task, it does not move forward to the next task. 

In this module you will learn how to use GitHub Actions and GitHub workflows to implement a continuous delivery solution to deploy a container-based webb app to Microsoft Azure Web Apps.

## Learning objectives

In this module, you will:

- Learn about options for Triggering a continuous delivery GitHub Workflow
- Learn to control execution with job conditionals
- Learn about deploying to Microsoft Azure with a GitHub deploy action
- Learn about storing credentials with GitHub Secrets
- Learn to create and destroy Azure resources with GitHub Actions

## Prerequisites

This module assumes you have completed the (module 1 -hello) and (module 2 - ci) module or that you are already familiar with GitHub Actions and GitHub Workflow basics used in continuous integration.

- A GitHub account
- The ability to navigate and edit files in GitHub
  - (For more information about GitHub, see [Introduction to GitHub](https://lab.github.com/githubtraining/introduction-to-github?azure-portal=true).)
- Basic familiarity with GitHub Actions and GitHub Workflows
  - If you are unfamiliar with GitHub Actions or GitHub Workflows, check out ..... (hello world module)
- Basic familiarity with continuous integration using GitHub Actions and GitHub Workflows
  - If you are unfamiliar with continuous integration using GitHub Actions or GitHub Workflows, check out ..... (ci module)
- An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true).
- An understanding of [Azure Fundamentals](https://docs.microsoft.com/learn/paths/azure-fundamentals/?aure-portal=true)
