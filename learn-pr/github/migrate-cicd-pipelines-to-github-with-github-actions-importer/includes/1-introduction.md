GitHub Actions Importer is designed to help you forecast, plan, and facilitate migrations from your current CI/CD tool to GitHub Actions.

Doing individual migrations is relatively easy in isolation. However, if you have a large and established CI/CD footprint, having a tool that can assist with migrations is key to your ability to adopt GitHub Actions at scale.

## Learning objectives

In this module, you:

- Learn about the two distinct phases of a GitHub Actions Importer migration and the phases' associated commands.
- Run through a mock migration lab exercise for one of the supported CI/CD platforms.

## Prerequisites

- A GitHub account
- Previous working knowledge of GitHub Actions
- Organizational access to one of the supported CI/CD platforms
- Ability to execute the accompanying labs exercises within Codespaces

## Important notes

As you learn from this module, you can use GitHub Actions Importer to plan and automatically migrate your CI/CD pipelines to GitHub Actions from the following supported platforms:

- Azure DevOps
- CircleCI
- GitLab
- Jenkins
- Travis CI

It's imperative to review every workflow that the GitHub Actions Importer converts for correctness before using it as a production workload.

The goal is to achieve an 80% conversion rate for every workflow. However, like all things, the actual conversion rate depends on your specific makeup of your pipelines.

To set expectations, remember that some things aren't automatically migrated when you use GitHub Actions Importer.

### What *isn't* automatically migrated

- Secrets and encrypted values
- Self-hosted build agents
- Historical packages
- Permissions for CI/CD pipelines
- Less commonly used build steps or build triggers

Now, let's dive into how to install GitHub Actions Importer and ensure it's up to date.
