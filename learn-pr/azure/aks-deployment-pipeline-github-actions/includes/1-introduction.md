Imagine you work for a video company. After a few months of planning, your team could successfully migrate all the company's technology stack to use AKS.

In the beginning everything was fine. However you began to notice that the team was spending too much time in image builds and application deployments. As a solution, you could use a deployment pipeline. You heard that was a technique other companies were using for years. When you brought this idea up to the management, they asked you to create a proof of concept using the company's new website.

In this module, you'll deploy Kubernetes workloads to an AKS cluster by using GitHub Actions.

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

All exercises will use [Azure Cloud Shell](https://docs.microsoft.com/azure/cloud-shell/overview?WT.mc_id=akspipeline_intro-learn-ludossan), which already has all the needed tooling installed. If you prefer to run the examples in your own terminal, you'll need to have the following tooling installed first:
- [Azure CLI](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough?WT.mc_id=akspipeline_intro-learn-ludossan)
- [Kubectl](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough?WT.mc_id=akspipeline_intro-learn-ludossan#connect-to-the-cluster)
