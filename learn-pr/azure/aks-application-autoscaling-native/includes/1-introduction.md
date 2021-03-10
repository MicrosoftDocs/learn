Imagine you work for a growing video editing company that provides a cloud-based video rendering service. Your company is experiencing increased demand for its video rendering service because of its international expansion. They're looking for ways to scale the product to provide a better experience to all customers. Since the application is already deployed to a Kubernetes cluster, management tasked you to find solutions to scale the application without the need of many changes.

You knew that AKS provides scalability tooling from Kubernetes straight out of the box. However, you need a better understanding of aspects of scalability and how to tune this tooling to your needs.

In this module, you'll learn what scalability is and how to scale a Kubernetes application up and down using the native autoscaler that is provided by Kubernetes without the need of changes in your infrastructure.

## Learning goals

By the end of this module, you'll be able to:

- Understand the concept of scalability and how it applies to Kubernetes
- Create and set up native scalability within AKS
- Choose how to configure and fine-tune HPAs

## Prerequisites

- Familiarity with Kubernetes concepts. If you're new to Kubernetes, start with the [basics of Kubernetes](https://azure.microsoft.com/topic/what-is-kubernetes/?azure-portal=true&WT.mc_id=deploycontainerapps_intro-learn-ludossan).
- Familiarity with [Git](https://docs.microsoft.com/contribute/git-github-fundamentals?WT.mc_id=deploycontainerapps_intro-learn-ludossan) and [GitHub](https://github.com).
- An active Azure [subscription](https://azure.microsoft.com/free/services/kubernetes-service/?azure-portal=true&WT.mc_id=deploycontainerapps_intro-learn-ludossan).
- Ability to use the [Azure CLI](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_intro-learn-ludossan).
- Ability to create a Docker container. If you're new to Docker, start with the [intro to containers](https://docs.microsoft.com/learn/modules/intro-to-containers/?WT.mc_id=deploycontainerapps_intro-learn-ludossan).

All exercises will use [Azure Cloud Shell](https://docs.microsoft.com/azure/cloud-shell/overview?WT.mc_id=deploycontainerapps_intro-learn-ludossan), which already has all the needed tooling installed. If you prefer to run the examples in your own terminal, you'll need to have the following tooling installed first:

- [Azure CLI](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_intro-learn-ludossan)
- [Kubectl](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_intro-learn-ludossan#connect-to-the-cluster)
- If you're on Windows, install [WSL](https://docs.microsoft.com/windows/wsl/install-win10)

## Before you begin

This module assumes you already have a running cluster. You'll need to create the cluster with the required resources. The [GitHub repository for this sample](https://github.com/Azure-Samples/mslearn-aks-application-scalability) has a script that will create the cluster, get the credentials, and deploy the application to it. You'll need to run it before you begin with the following steps.

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

First, sign in to Azure Cloud Shell with the account you want to deploy resources into.

> [!div class="nextstepaction"]
> [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

> [!IMPORTANT]
> We'll run all the scripts with Bash, so if you haven't created a Cloud Shell yet, select "Bash" as the running shell.

> [!NOTE]
> If you're on Windows and not on Cloud Shell, execute the previous commands in WSL for a better experience.

Then execute the following command.

```bash
curl -L https://aka.ms/learn-scalability-init?v=$RANDOM | bash
```

By the end of the command, you should have a cluster created with the `contoso-website` application deployed to it.
