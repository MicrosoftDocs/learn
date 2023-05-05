Imagine that you work for a growing video editing company that provides a cloud-based video rendering service. The company is experiencing increased demand for its video rendering service because of its international expansion. They have already scaled the application using HorizontalPodAutoscalers, but the cluster doesn't seem to be following up. The DevOps engineer found out that the cluster could be manually scaled, but someone needs to keep a close eye on it all day long. Now, management has tasked you to find a solution to scale the cluster automatically and free up some employee time.

Since AKS already provides scaling tools for apps, you decided to check on a feature called "cluster autoscaler" to get more understanding of its aspects and how can it be implemented.

In this module, you learn what the cluster autoscaler is, how it works and how you can deploy it to an existing cluster on AKS.

## Learning goals

By the end of this module, you'll:

- Understand the concept of cluster scalability and how it applies to Kubernetes.
- Create and set up cluster scalability within AKS.

## Prerequisites

- Familiarity with Kubernetes concepts. If you're new to Kubernetes, start with the [basics of Kubernetes](https://azure.microsoft.com/topic/what-is-kubernetes/?azure-portal=true&WT.mc_id=deploycontainerapps_intro-learn-ludossan).
- Familiarity with [Git](/contribute/git-github-fundamentals?WT.mc_id=deploycontainerapps_intro-learn-ludossan) and [GitHub](https://github.com).
- An active Azure [subscription](https://azure.microsoft.com/free/services/kubernetes-service/?azure-portal=true&WT.mc_id=deploycontainerapps_intro-learn-ludossan).
- Ability to use the [Azure CLI](/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_intro-learn-ludossan).
- Ability to create a Docker container. If you're new to Docker, start with the [intro to containers](/training/modules/intro-to-containers/?WT.mc_id=deploycontainerapps_intro-learn-ludossan).

All exercises use [Azure Cloud Shell](/azure/cloud-shell/overview?WT.mc_id=deploycontainerapps_intro-learn-ludossan), which already has all the needed tooling installed. If you prefer to run the examples in your own terminal, you need to have the following tooling installed first:

- [Azure CLI](/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_intro-learn-ludossan)
- [Kubectl](/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_intro-learn-ludossan#connect-to-the-cluster)
- If you're on Windows, install [WSL](/windows/wsl/install-win10)

## Before you begin

This module assumes you already have a running cluster. You need to create the cluster with the required resources. The [GitHub repository for this sample](https://github.com/Azure-Samples/mslearn-aks-cluster-scalability) has a script that creates the cluster, gets the credentials, and deploys the application to it. You need to run it before you begin with the following steps.

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

First, sign in to Azure Cloud Shell with the account you want to deploy resources into.

> [!div class="nextstepaction"]
> [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

> [!IMPORTANT]
> We'll run all the scripts with Bash, so if you haven't created a Cloud Shell yet, select "Bash" as the running shell.
> If you're on Windows and not on Cloud Shell, execute the previous commands in WSL for a better experience.

Then execute the following command.

```bash
curl -L https://aka.ms/learn-cluster-scalability-init?v=$RANDOM | bash
```

When the command has completed, you should have a cluster created with the `contoso-website` application deployed to it with 35 pods. Notice that some of the pods are in a **Pending** state because the application is trying to scale past the number of pods that are able to be scheduled on the nodes.

```
NAME                                      READY   STATUS    RESTARTS   AGE
contoso-website-ttlpv                     1/1     Running   0          1m35s
contoso-website-anzcydsfk-80tfl           1/1     Running   0          1m35s
contoso-website-mb62hlxfx-tr3xm           1/1     Running   0          1m35s
contoso-website-aexxpkyfu-dveyn           0/1     Pending   0          1m35s
contoso-website-yien0mk3f-iy4bz           0/1     Pending   0          1m35s
contoso-website-zbg3hvswb-uptrn           0/1     Pending   0          1m35s
contoso-website-c04xe6ldd-i9mpx           0/1     Pending   0          1m35s
contoso-website-eaywf5glm-raz9q           0/1     Pending   0          1m35s
contoso-website-gbtgk04jj-c6usj           0/1     Pending   0          1m35s
contoso-website-oiedarxiy-5i3kz           0/1     Pending   0          1m35s
contoso-website-yeol8hald-6kg7y           0/1     Pending   0          1m35s
contoso-website-xkg9kmufy-juksf           0/1     Pending   0          1m35s
contoso-website-wb45271o4-30u0y           0/1     Pending   0          1m35s
...
```
