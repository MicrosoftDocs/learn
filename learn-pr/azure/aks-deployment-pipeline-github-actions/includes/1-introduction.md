Imagine that you work for a video production company. After a few months of planning, your team successfully migrated its technology stack to Azure Kubernetes Service (AKS).

The new AKS solution is running without any problems. However, you've noticed that the developer team spends a significant amount of time building container images and deploying applications. 

To reduce the team's time spent on these tasks, you decide to investigate using pipelines to deploy to AKS. When you approached management with this idea, they asked you to create a proof of concept by using the company's new website.

In this module, you'll deploy Kubernetes workloads to an AKS cluster by using GitHub Actions.

## Learning objectives

By the end of this module, you'll be able to:

- Describe a continuous integration (CI) and continuous delivery (CD) process that uses GitHub Actions
- Create a deployment pipeline by using GitHub Actions and Azure
- Deploy a cloud-native application to AKS by using GitHub Actions

## Prerequisites

- Familiarity with Kubernetes concepts (if you're new to Kubernetes, start with the [basics of Kubernetes](https://azure.microsoft.com/topic/what-is-kubernetes/?azure-portal=true&WT.mc_id=akspipeline_intro-learn-ludossan))
- Familiarity with [Git](https://docs.microsoft.com/contribute/git-github-fundamentals?WT.mc_id=akspipeline_intro-learn-ludossan) and [GitHub](https://lab.github.com/githubtraining/introduction-to-github)
- Familiarity with [GitHub Actions](https://lab.github.com/githubtraining/github-actions:-hello-world)
- An active [Azure subscription](https://azure.microsoft.com/free/services/kubernetes-service/?azure-portal=true&WT.mc_id=akspipeline_intro-learn-ludossan)
- Ability to use the [Azure CLI](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough?WT.mc_id=akspipeline_intro-learn-ludossan)
