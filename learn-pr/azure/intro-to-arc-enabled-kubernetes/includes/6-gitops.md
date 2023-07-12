A primary benefit of Azure Arc is to facilitate implementation of DevOps principles, which apply established development practices to operations. DevOps increases agility without jeopardizing the stability of the IT environment. 

Azure Arc-enabled Kubernetes supports GitOps, a DevOps practice that streamlines application releases by reducing manual deployment effort. In this unit, you learn about GitOps and how to configure it for Azure Arc-enabled Kubernetes clusters.

## GitOps for Kubernetes

GitOps for Kubernetes uses a Git repository to host configuration files that represent the expected state of a resource. An agent running on the Kubernetes cluster monitors the state of the repository. When there's a change in the repository, the agent pulls the changed files to the cluster and applies the new configuration.

In the context of Azure Arc-enabled Kubernetes clusters, a Git repository hosts a Kubernetes cluster configuration, including its resources such as pods and deployments. A pod or set of pods running on the cluster polls the status of the repository. Once the pod detects a change, it pulls and applies the new configuration to the cluster, ensuring that the cluster remains in the desired state.

GitOps makes it easier to standardize Kubernetes configurations across your organization. You can define a baseline configuration to apply to every cluster and its components. For example, the baseline configuration could include the delegation model, monitoring and logging settings, and characteristics of cluster-wide services.

Azure Arc-enabled Kubernetes clusters rely on Flux, a popular open-source GitOps deployment operator that automates GitOps configuration deployments to the cluster. Flux supports common file sources like Git repositories, Helm repositories, and Buckets, and supports YAML, Helm, and Kustomize configuration template types.

The following diagram shows a GitOps flow that uses Flux to deploy cluster configurations and application updates.

:::image type="content" source="../media/6-arc-enabled-kubernetes-cicd-flow.png" alt-text="Diagram of the GitOps flow showing an application update." lightbox="../media/6-arc-enabled-kubernetes-cicd-flow.png":::

## Configure GitOps

GitOps associates your Kubernetes cluster with one or more Git repositories. Each Git repository can contain configurations of any valid Kubernetes resources, such as namespaces or deployments in the form of manifest files.

The following diagram shows the process of applying GitOps-based configurations to multiple Azure Arc-enabled clusters:

:::image type="content" source="../media/6-arc-enabled-k8s-gitops.png" alt-text="Diagram showing the process of applying GitOps-based configuration to multiple Azure Arc-enabled clusters." border="false":::

GitOps is enabled in a Kubernetes cluster as a `Microsoft.KubernetesConfiguration/extensions/microsoft.flux` cluster extension resource. To create `fluxConfigurations`, the `microsoft.flux` extension must be installed in the cluster. The extension installs automatically when you create the first `Microsoft.KubernetesConfiguration/fluxConfigurations` instance in a cluster. You can also install the extension manually before you create your configurations.

Each association between an Azure Arc-enabled Kubernetes cluster configuration and its corresponding GitOps repository resides in Azure as part of the Azure Arc-enabled Kubernetes cluster Azure resource. You can configure the association by using Azure management interfaces like the Azure portal or Azure CLI.

Use the following high-level steps to implement GitOps with an Azure Arc-enabled Kubernetes cluster.

### Prerequisites

- An existing Azure Arc-enabled Kubernetes cluster.
- Read and write permissions on the `Microsoft.Kubernetes/connectedClusters` resource type.
- The latest version of Azure CLI, with the latest `k8s-configuration` and `k8s-extension` extension packages.
- Registration of the required service providers on the Azure subscription.
- Outbound connectivity for the GitOps agents. For details regarding target URLs and ports, refer to your product documentation.

### Configuration steps

1. Use the `k8s-configuration` Azure CLI extension to apply a Flux configuration and enable GitOps in your Arc-enabled Kubernetes cluster.
1. Validate the configuration to confirm successful creation. The configuration resource updates with compliance status, messages, and debugging information.

Once you apply the configuration, you can use the Azure portal to view compliance details. You can also use the Azure portal to create, update, and delete GitOps configurations.

### Use Azure Policy to automate configuration

You can also use Azure Policy to automate the configuration process, so you can apply it consistently at scale. To create the Azure Policy assignment in the Azure portal, follow these steps:

1. In the Azure portal, view all policy definitions by searching for and selecting **Policy**, then selecting **Definitions** in the left menu of the **Policy** page.
1. Search for **Configure Kubernetes clusters with specified GitOps configuration**, and select one of the built-in policy definitions.
1. Select **Assign**, and create a policy assignment by specifying the following settings:

   - Set the **Scope** to the management group, subscription, or resource group where the policy assignment applies.
   - Optionally, specify **Exclusions** to designate any resource subscopes where the policy shouldn't apply.
   - Set **Policy enforcement** to **Enabled**.
   - On the **Parameters** tab, set values for the *sourceControlConfiguration* parameters that set the association between Git repositories and corresponding components of the Azure Arc-enabled Kubernetes cluster.
   - On the **Remediation** tab, select **Create a remediation task** and **Create a Managed Identity**. The identity must have the **Contributor** Azure role-based access control (Azure RBAC) role.
   
1. Select **Review + create**, and then select **Create**.

The policy assignment typically takes effect within 20 minutes. The policy automatically enables GitOps for each Azure Arc-enabled Kubernetes cluster in the scope of the assignment. For existing clusters, you need to manually run the remediation task.

> [!TIP]
> For sample manifest files that illustrate configuration of Azure Arc-enabled Kubernetes clusters, see the [Official cluster configuration sample for Azure Arc enabled Kubernetes](https://github.com/Azure/arc-k8s-demo).

