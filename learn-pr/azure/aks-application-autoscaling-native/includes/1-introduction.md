## Example scenario

Imagine you work for a growing video editing company that provides a cloud-based video rendering service. Your company is experiencing increased demand for its video rendering service because of recent international expansion and wants to find a way to scale the product to provide a better experience to your customers. Since the application is already deployed to a Kubernetes cluster, management tasked you to find solutions to scale the application without the need for many changes.

You know that AKS provides scalability tooling from Kubernetes straight out of the box. However, you want a better understanding of the aspects of scalability and how to tune this tooling to your needs.

In this module, you learn what scalability is and how it applies to Kubernetes. Then, you learn how to scale a Kubernetes application up and down by using the native autoscaler provided by Kubernetes, without the need for changes in your infrastructure.

## Learning goals

By the end of this module, you're able to:

- Understand the concept of scalability and how it applies to Kubernetes.
- Create and set up native scalability within AKS.
- Choose how to configure and fine-tune HPAs.

## Prerequisites

- Familiarity with Kubernetes concepts. If you're new to Kubernetes, start with the [basics of Kubernetes](https://azure.microsoft.com/topic/what-is-kubernetes/?azure-portal=true&WT.mc_id=deploycontainerapps_intro-learn-ludossan).
- Familiarity with [Git](/contribute/git-github-fundamentals?WT.mc_id=deploycontainerapps_intro-learn-ludossan) and [GitHub](https://github.com).
- An active Azure [subscription](https://azure.microsoft.com/free/services/kubernetes-service/?azure-portal=true&WT.mc_id=deploycontainerapps_intro-learn-ludossan).
- Ability to use the [Azure CLI](/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_intro-learn-ludossan).
- Ability to create a Docker container. If you're new to Docker, start with the [intro to containers](/training/modules/intro-to-containers/?WT.mc_id=deploycontainerapps_intro-learn-ludossan).

All exercises use [Azure Cloud Shell](/azure/cloud-shell/overview?WT.mc_id=deploycontainerapps_intro-learn-ludossan), which already has all the needed tooling installed. If you prefer to run the examples in your own terminal, you need to have the [Azure CLI](/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_intro-learn-ludossan) and [Kubectl](/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_intro-learn-ludossan#connect-to-the-cluster) installed. If you're on Windows, you need to install [WSL](/windows/wsl/install-win10)

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]
