Now that you know the basics of Azure Kubernetes Service, let's see what information you need to set up a simple AKS cluster. This information should help you decide how much additional configuration AKS may require when integrating with existing development and deployment processes.

## Creating an AKS cluster

At its core, an AKS cluster is a cloud hosted Kubernetes cluster. Unlike a custom Kubernetes installation, AKS streamlines the installation process and takes care of most of the underlying cluster management tasks.

You have two options when you create an AKS cluster. You either use the Azure portal or Azure CLI. Both options require you to configure basic information about the cluster. For example:

- The Kubernetes cluster name
- The version of Kubernetes to install
- A DNS prefix to make the master node publicly accessible
- The initial node pool size

The initial node pool size defaults to two nodes, however it's recommended that at least three nodes are used for a production environment.

> [!NOTE]
> The master node in your cluster is free. You only pay for node VMs, storage and networking resources consumed in your cluster.

Unless specified, the Azure service creation workflow creates a Kubernetes cluster using default configuration for scaling, authentication, networking and monitoring. Creating an AKS cluster typically takes a few minutes. Once complete, you can change any of the default AKS cluster properties. Access and management of your cluster is done through the Azure portal or from the command line.

## How workloads are developed and deployed to AKS

![Image showing combined services used to accelerate development and deployment.](../media/3-development-accelerate.png)

AKS supports the Docker image format that means that you can use any development environment to create a workload, package the workload as a container and deploy the container as a Kubernetes pod.

Here you use the standard Kubernetes command-line tools or the Azure CLI to manage your deployments. The support for the standard Kubernetes tools ensures that you don't need to change your current workflow to support an existing Kubernetes migration to AKS.

AKS also supports all the popular development and management tools such as Helm, Draft, Kubernetes extension for Visual Studio Code and Visual Studio Kubernetes Tools.

## Bridge to Kubernetes

Bridge to Kubernetes allows you to run and debug code on your development computer, while still connected to your Kubernetes cluster with the rest of your application or services. 

Using Bridge to Kubernetes lets you:

- Avoid having to build and deploy code to your cluster by instead creating a direct connection from your development computer to your cluster, allowing you to quickly test and develop your service in the context of the full application without creating any Docker or Kubernetes configuration. 
- Redirect traffic between your connected Kubernetes cluster and your development computer, which allows code on your development computer and services running in your Kubernetes cluster to communicate as if they are in the same Kubernetes cluster. 
- Provide a way to replicate environment variables and mounted volumes available to pods in your Kubernetes cluster in your development computer, which allows allows you to quickly work on your code without having to replicate those dependencies manually.

## Deployment Center

Deployment center simplifies setting up a DevOps pipeline for your application. You can use this configured DevOps pipeline to set up a continuous integration (CI) and continuous delivery (CD) pipeline to your AKS Kubernetes cluster.

With Azure DevOps Projects you can:

- Automatically create Azure resources, such as an AKS cluster
- Create an Azure Application Insights resource for monitoring an AKS cluster
- Enable Azure Monitor for containers to monitor performance for the container workloads on an AKS cluster

You can add richer DevOps capabilities by extending the default configured DevOps pipeline. For example, you can add approvals before deploying, provision additional Azure resources, run scripts or upgrade workloads.

## Azure Service Integration

AKS allows us to integrate any Azure service offering and use it as part of an AKS cluster solution.

For example, remember that Kubernetes doesn't provide middleware and storage systems. Suppose you need to add a processing queue to the fleet management data processing service. You can easily integrate Storage queues using Azure Storage to extend the capacity of the data processing service.