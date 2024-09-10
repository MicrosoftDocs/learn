You can easily deploy containerized applications to an Arc-enabled AKS Edge Essentials cluster using GitOps and Flux.

In the retail chain scenario, we need to optimize the customer experience by deploying a smart shelf application that tracks inventory and analyzes interactions. We need a solution for managing sensors, securing data, and enabling remote oversight.

Here, you learn how to use GitOps and Flux to deploy applications to an Arc-Enabled AKS Edge Essentials cluster.

## GitOps for Arc-enabled Kubernetes

A primary benefit of Azure Arc is to facilitate implementation of DevOps principles, which apply established development practices to operations. DevOps increases agility without jeopardizing the stability of the IT environment. Azure Arc-enabled Kubernetes supports GitOps, a DevOps practice that streamlines application releases by reducing manual deployment effort.

GitOps makes it easier to standardize Kubernetes configurations across your organization, including Arc-enabled Kubernetes. A repository or other file source hosts configuration files that represent the expected state of a resource.

An agent running on the Kubernetes cluster monitors the state of the repository. When there's a configuration change, the agent pulls the updated files to the cluster and applies the new configuration, ensuring that the cluster remains in the desired state.

Azure Arc-enabled Kubernetes clusters rely on Flux, a popular open-source GitOps deployment operator that automates configuration deployments to the cluster. Flux supports common file sources like Git repositories, Helm repositories, and Buckets, and supports YAML, Helm, and Kustomize configuration template types.

## GitOps configurations to push applications to AKS Edge Essentials

After AKS Edge Essentials is connected to Azure Arc and GitOps is enabled, you can deploy applications to your AKS Edge Essentials cluster using GitOps and Flux. For that you create a cluster-level configuration and a namespace-level configuration. On our example, you use the following Helm configurations:

- [Nginx Ingress Controller](https://github.com/microsoft/azure-arc-jumpstart-apps/blob/main/nginx/release/nginx-ingress.yaml)
- [Hello Arc Application](https://github.com/microsoft/azure-arc-jumpstart-apps/blob/main/hello-arc/releases/app/hello-arc.yaml)

## Commit changes to GitHub application repository for automatic updates

On our example, we configure Flux to automatically update the application when changes are committed to the GitHub repository *main* branch. For example, if we set the **sync interval** to **1 min** when creating the namespace-level configuration, Flux pulls down changes from GitHub every minute.