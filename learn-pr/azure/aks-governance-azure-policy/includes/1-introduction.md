Imagine that you work for a browser based video game company. After a few months of planning, your team successfully migrated its technology stack to Azure Kubernetes Service (AKS).

You just came out of a review with the security and compliance teams. They expressed concerns about the compliance status of your cluster. For example, they only want you to deploy images from trusted registries.

You need to be able to block new deployments from untrusted registries, and present a report of the status of your cluster against that policy. It's up to you to find out how you can meet this requirement and present a solution to the security and compliance teams. 

In this module, you'll learn how to achieve this by using Azure policy for Kubernetes.

## Learning objectives

By the end of this module, you'll be able to:

- Understand how Azure Policy integrates with Azure Kubernetes Service
- Deploy the Azure Policy add-on for Azure Kubernetes Service
- Configure policies to manage compliance state of an Azure Kubernetes Service cluster
- Monitor cluster compliance status using Azure policy

## Prerequisites

- Familiarity with Kubernetes concepts. If you're new to Kubernetes, start with the [basics of Kubernetes](https://azure.microsoft.com/topic/what-is-kubernetes/?azure-portal=true&WT.mc_id=akspipeline_intro-learn-ludossan)).
- An active [Azure subscription](https://azure.microsoft.com/free/services/kubernetes-service/?azure-portal=true&WT.mc_id=akspipeline_intro-learn-ludossan)
- Ability to use the [Azure CLI](/azure/aks/kubernetes-walkthrough?WT.mc_id=akspipeline_intro-learn-ludossan)