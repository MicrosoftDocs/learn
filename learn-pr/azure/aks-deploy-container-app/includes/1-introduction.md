Imagine you work for a growing video editing company that provides a cloud-based video rendering service. Your company is experiencing increased demand for its video rendering service because of its international expansion. They're looking for ways to scale the product to provide a better experience to all customers. Management tasked you to assess which Azure service would improve the ability to deploy your video rendering service to meet customer demand.

You've identified Azure Kubernetes Service (AKS) as a potential solution. AKS meets the requirements that allow you to deploy your app and handle the company's increased growth. You want to understand how to deploy your app to an AKS cluster and allow customers access to the app's services.

In this module, you'll deploy Kubernetes workloads declaratively to an AKS cluster by using manifest files. You'll create different deployment manifest files that allow you to deploy and expose your application to your users.

## Learning objectives

By the end of this module, you'll be able to:

- Create and set up an AKS cluster.
- Deploy Kubernetes workloads by using deployment YAML files.
- Expose Kubernetes workloads by using services and ingress.

## Prerequisites

- Familiarity with Kubernetes concepts. If you're new to Kubernetes, start with the [basics of Kubernetes](https://azure.microsoft.com/topic/what-is-kubernetes/?azure-portal=true&WT.mc_id=deploycontainerapps_intro-learn-ludossan).
- Familiarity with [Git](https://docs.microsoft.com/contribute/git-github-fundamentals?WT.mc_id=deploycontainerapps_intro-learn-ludossan) and [GitHub](https://github.com).
- Familiarity with [Docker](https://docker.com) and Docker images.
- An active Azure [subscription](https://azure.microsoft.com/free/services/kubernetes-service/?azure-portal=true&WT.mc_id=deploycontainerapps_intro-learn-ludossan).
- Ability to use the [Azure CLI](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_intro-learn-ludossan).
- Ability to create a Docker container. If you're new to Docker, start with the [intro to containers](https://docs.microsoft.com/learn/modules/intro-to-containers/?WT.mc_id=deploycontainerapps_intro-learn-ludossan).

All exercises will use [Azure Cloud Shell](https://docs.microsoft.com/azure/cloud-shell/overview?WT.mc_id=deploycontainerapps_intro-learn-ludossan), which already has all the needed tooling installed. If you prefer to run the examples in your own terminal, you'll need to have the following tooling installed first:
- [Azure CLI](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_intro-learn-ludossan)
- [Kubectl](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_intro-learn-ludossan#connect-to-the-cluster)
