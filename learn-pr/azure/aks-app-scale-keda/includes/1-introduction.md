Kubernetes Event-driven Autoscaling (KEDA) works alongside standard Kubernetes components like the Horizontal Pod Autoscaler (HPA), and the Cluster Autoscaler. KEDA extends functionality without overwriting or duplication.

## Example scenario

You work for a growing video editing company that provides a cloud-based video rendering service.  Usage of its client application peaks at various times during a 24-hr period. Due to increasing and decreasing demand, the company needs to scale its application accordingly to provide a better experience to all customers. Since the application is event driven and receives a significant number of events at various times; CPU and Memory based metrics are not representative of pending work to scale properly. As the DevOps engineer, you need to assess which tools will help achieve the company's scaling needs.  

After experimenting with various options, you've determined that using Azure Kubernetes Services (AKS) and Kubernetes Event-driven Autoscaling (KEDA) fulfills all the requirements to scale for peak and off-peak usage. With clearance from leadership, you begin the journey of an event driven application that supports the company now and in the future!

In this module, you'll deploy KEDA into an AKS environment and deploy a scaler object to autoscale containers based on the number of messages (events) in a list.

## What will we be doing?

Here, you'll deploy a KEDA scaler object to AKS to autoscale containers based on the number messages in a list:

* **Understand**: Kubernetes scaling options including KEDA, Cluster Autoscaling (CA), and Horizontal Pod Autoscaling (HPA)

* **Deploy**: a container that processes messages from a Redis List

* **Deploy**: KEDA within AKS

* **Deploy**: a built-in KEDA scaler

## What is the main goal?

By the end of this session, you'll be able to understand which Kubernetes scaling option you should choose based on your scenario.

## Prerequisites

* Familiarity with Kubernetes concepts. If you're new to Kubernetes, start with the [basics of Kubernetes](https://azure.microsoft.com/topic/what-is-kubernetes).
* Familiarity with [Git](https://git-scm.com) and [GitHub](https://github.com).
* Familiarity with [Docker](https://docker.com) and Docker images.
* An active Azure [subscription](/azure/guides/developer/azure-developer-guide#understanding-accounts-subscriptions-and-billing).
* Ability to use the [Azure CLI](/azure/aks/kubernetes-walkthrough).
* Ability to create a Docker container. If you're new to Docker, start with the [intro to containers](/learn/modules/intro-to-containers).

All exercises will use [Azure Cloud Shell](/azure/cloud-shell/overview), which already has all the needed tooling installed. If you prefer to run the examples in your own terminal, you'll need to have the following tooling installed first:

* [Azure CLI](/azure/aks/kubernetes-walkthrough)
* [Kubectl](/azure/aks/kubernetes-walkthrough)

## Before we start

You need to create a simple Kubernetes cluster. Following these steps will give you a basic, functioning environment. In a Cloud Shell complete these tasks:

```azure-cli
RESOURCE_GROUP=rg-contoso-video
LOCATION=westus2
CLUSTER_NAME=contoso-video

az group create -n $RESOURCE_GROUP -l $LOCATION

az aks create \
 -g $RESOURCE_GROUP \
 -n $CLUSTER_NAME \
 --node-count 1 \
 --node-vm-size Standard_DS3_v2 \
 --generate-ssh-keys \
 --node-osdisk-type Ephemeral \
 --enable-addons http_application_routing

az aks get-credentials -n $CLUSTER_NAME -g $RESOURCE_GROUP
```

The complete cluster creation can take up to five minutes.

> [!IMPORTANT]
> Make a note of the `RESOURCE_GROUP` and `CLUSTER_NAME` variables for later use.

You need to create a simple Azure Cache for Redis. Following these steps will give you a basic, functioning cache. In a Cloud Shell environment complete these tasks:

```azure-cli
REDIS_NAME=redis-contoso-video-$RANDOM

az redis create --location $LOCATION --name $REDIS_NAME --resource-group $RESOURCE_GROUP --sku Basic --vm-size c0 --enable-non-ssl-port

REDIS_HOST=$(az redis show -n $REDIS_NAME -g $RESOURCE_GROUP -o tsv --query "hostName")
REDIS_KEY=$(az redis list-keys --name $REDIS_NAME --resource-group $RESOURCE_GROUP -o tsv --query "primaryKey")
```

> [!IMPORTANT]
> Creating these resources in this manner is not recommended for Production use and only recommended to experiment with this module.
