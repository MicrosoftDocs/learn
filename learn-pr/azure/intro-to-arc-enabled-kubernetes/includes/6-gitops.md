A primary benefit of Azure Arc is to facilitate implementation of DevOps principles, which apply established development practices to operations. DevOps increases agility without jeopardizing the stability of the IT environment.

Azure Arc-enabled Kubernetes supports GitOps, a DevOps practice that streamlines application releases by reducing manual deployment effort.

In this unit, you learn about GitOps and how to configure it for Azure Arc-enabled Kubernetes clusters.

## GitOps for Arc-enabled Kubernetes

GitOps makes it easier to standardize Kubernetes configurations across your organization, including Arc-enabled Kubernetes. A repository or other file source hosts configuration files that represent the expected state of a resource. For example, a baseline configuration could include the delegation model, monitoring and logging settings, and characteristics of cluster-wide services.

An agent running on the Kubernetes cluster monitors the state of the repository. When there's a configuration change, the agent pulls the updated files to the cluster and applies the new configuration, ensuring that the cluster remains in the desired state.

Azure Arc-enabled Kubernetes clusters rely on Flux, a popular open-source GitOps deployment operator that automates configuration deployments to the cluster. Flux supports common file sources like Git repositories, Helm repositories, and Buckets, and supports YAML, Helm, and Kustomize configuration template types.

The following diagram shows a GitOps flow that uses Flux to deploy cluster configurations and application updates.

:::image type="content" source="../media/6-arc-enabled-kubernetes-cicd-flow.png" alt-text="Diagram of the GitOps flow showing an application update." lightbox="../media/6-arc-enabled-kubernetes-cicd-flow.png":::

## Configure GitOps

GitOps associates your Arc-enabled Kubernetes cluster with one or more file sources, such as a Git repository. Each repository can contain configurations of any valid Kubernetes resources, such as namespaces or deployments in the form of manifest files.

The following diagram shows the process of applying GitOps-based configurations to multiple Azure Arc-enabled clusters.

:::image type="content" source="../media/6-arc-enabled-k8s-gitops.png" alt-text="Diagram showing the process of applying GitOps-based configuration to multiple Azure Arc-enabled clusters."  lightbox="../media/6-arc-enabled-k8s-gitops.png":::

GitOps is enabled in a Kubernetes cluster as a `Microsoft.KubernetesConfiguration/extensions/microsoft.flux` cluster extension resource. To create `fluxConfigurations`, the `microsoft.flux` extension must be installed in the cluster. The extension installs automatically when you create the first `Microsoft.KubernetesConfiguration/fluxConfigurations` instance in a cluster. You can also install the extension manually before you create your configurations.

Each association between an Azure Arc-enabled Kubernetes cluster configuration and its corresponding GitOps repository resides in Azure as part of the Azure Arc-enabled Kubernetes cluster Azure resource. You can configure the association by using Azure management interfaces like the Azure portal or Azure CLI.

Use the following high-level steps to implement GitOps with an Azure Arc-enabled Kubernetes cluster.

1. Use the `k8s-configuration` Azure CLI extension to apply a Flux configuration and enable GitOps in your Arc-enabled Kubernetes cluster.
1. Validate the configuration to confirm successful creation. The configuration resource updates with compliance status, messages, and debugging information.

Once you apply the configuration, you can use the Azure portal to view compliance details. You can also use the Azure portal to create, update, and delete GitOps configurations.

### Use Azure Policy to automate configuration

You can use Azure Policy to automate the configuration process, so you can apply it consistently at scale. Before you assign a policy to configure the clusters, you must make sure that the Flux extension is created on the clusters. You can do this by first assigning the **Configure installation of Flux extension on Kubernetes cluster** policy definition, which ensures that the extension is installed.

Creating the Azure Policy assignment in the Azure portal consists of the following high-level steps: 

1. In the Azure portal, view all policy definitions by searching for and selecting **Policy**, then selecting **Definitions** in the left menu of the **Policy** page.
1. Search for **Configure Kubernetes clusters with specified GitOps configuration**, and select one of the built-in policy definitions.
1. Select **Assign**, and create a policy assignment by specifying the settings for scope, parameters, and remediation.   
1. Select **Review + create**, and then select **Create**.

The policy assignment automatically enables GitOps for each Azure Arc-enabled Kubernetes cluster that is created in the scope of the assignment. For existing clusters, you need to manually run the remediation task.

You'll learn more about Azure Policy in the next unit.