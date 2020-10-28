Suppose that you work as a DevOps lead at a drone-tracking and management company. Your company provides a drone-tracking solution to customers worldwide and uses Azure Kubernetes Service (AKS) to orchestrate many containerized instances of that solution. You've realized that cost management of your AKS compute resources has become increasingly important because of two driving factors. First, your customer base has increased and you need to process and track many more drones. Second, more development teams have started embracing the company's new cloud-native processes for application development.

You want to address both of these factors to save costs. First, you're looking for options to manage the cost-effective deployment of many workloads. Second, you want to introduce business policies that govern how your development teams create and use AKS compute resources.

In this module, you'll explore strategies to optimize compute costs when developing cloud-native applications by using Azure Kubernetes Service (AKS). You'll configure a user node pool and see how to scale the node count to zero. You'll then configure AKS spot node pools by using the cluster autoscaler to access unused Azure compute capacity at a discount. Finally, you'll enable Azure Policy on AKS to manage resource quotas to govern the deployment of AKS compute resources.

## Learning objectives

- Optimize costs on AKS by using zero-scaled node pools
- Optimize costs on AKS by using autoscaled spot node pools
- Manage costs with Azure Policy on AKS

## Prerequisites

- Access to an Azure subscription
- Basic knowledge of executing commands by using the Azure CLI
- Knowledge of Kubernetes and its concepts
- Basic knowledge of creating Kubernetes YAML manifest files
- Basic knowledge of executing commands by using kubectl