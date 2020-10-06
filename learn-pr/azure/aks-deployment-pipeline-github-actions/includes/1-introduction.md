Imagine you work for a video company. After a few months of planning, your team successfully migrated its technology stack to use Azure Kubernetes Service.

The solution is running without any problems. However, you've noticed the team is spending a lot of time on container image builds and application deployments. To reduce the team's amount of time, you decide to investigate deployments to Azure Kubernetes Service using pipelines. When you brought this idea up to the management, they asked you to create a proof of concept using the company's new website.

In this module, you'll deploy Kubernetes workloads to an Azure Kubernetes Service cluster using GitHub Actions.

## Learning objectives

By the end of this module, you'll be able to:

- Describe a continuos integration (CI) and continuous deployment (CD) process using GitHub Actions
- Create a deployment pipeline using GitHub Actions and Azure
- Deploy a cloud-native application to Azure Kubernetes service (AKS) by using GitHub Actions

## Prerequisites

- Familiarity with Kubernetes concepts. If you're new to Kubernetes, start with the [basics of Kubernetes](https://azure.microsoft.com/topic/what-is-kubernetes/?azure-portal=true&WT.mc_id=akspipeline_intro-learn-ludossan).
- Familiarity with [Git](https://docs.microsoft.com/contribute/git-github-fundamentals?WT.mc_id=akspipeline_intro-learn-ludossan) and [GitHub](https://lab.github.com/githubtraining/introduction-to-github).
- Familiarity with [GitHub Actions](https://lab.github.com/githubtraining/github-actions:-hello-world)
- An active Azure [subscription](https://azure.microsoft.com/free/services/kubernetes-service/?azure-portal=true&WT.mc_id=akspipeline_intro-learn-ludossan).
- Ability to use the [Azure CLI](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough?WT.mc_id=akspipeline_intro-learn-ludossan).
