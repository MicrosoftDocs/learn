One of the primary benefits of Azure Arc is facilitating implementation of DevOps principles to apply established development practices to operations. These principles can increase agility without jeopardizing the stability of IT environment. One way to promote DevOps principles is to implement GitOps, which streamlines releases of applications by reducing the manual effort involved in their deployment. Azure Arc-enabled Kubernetes clusters offer support for GitOps. In this unit, you'll learn about GitOps and how to configure it. 

## What is GitOps?

GitOps is a DevOps practice that relies on a Git repository to host files that contain the configuration representing the expected state of a resource. An agent running on the cluster monitors the state of the repository. When there's a change in the repository, the agent pulls the changed files to the cluster and applies the new configuration.

In the context of Azure Arc-enabled Kubernetes clusters, a Git repository hosts a configuration of a Kubernetes cluster, including its resources such as pods and deployments. A pod or a set of pods running on the cluster polls the status of the repository. Once it detects a change, it pulls and applies the new configuration to the cluster, ensuring that the cluster remains in the desired state.

Azure Arc-enabled Kubernetes clusters rely on Flux, a popular open-source GitOps deployment tool. Flux is an operator that configures pods to automate GitOps configuration deployments in the cluster. Flux provides support for common file sources (Git repositories, Helm repositories, Buckets) and template types (YAML, Helm, and Kustomize).

:::image type="content" source="../media/6-arc-enabled-kubernetes-cicd-flow.png" alt-text="Diagram of the GitOps flow showing an application update." lightbox="../media/6-arc-enabled-kubernetes-cicd-flow.png":::

GitOps makes it easier to standardize Kubernetes configurations across your organization. You can define a baseline configuration that you want to apply to every cluster and its components. This configuration could include, for example, the delegation model, monitoring and logging settings, and characteristics of cluster-wide services.

## How to configure GitOps

GitOps associates your Kubernetes cluster with one or more Git repositories. Each Git repository can contain configurations of any valid Kubernetes resources, such as namespaces or deployments in the form of manifest files.

:::image type="content" source="../media/6-arc-enabled-k8s-gitops.png" alt-text="Diagram showing the process of applying GitOps-based configuration to multiple Azure Arc-enabled clusters.":::

GitOps is enabled in a Kubernetes cluster as a `Microsoft.KubernetesConfiguration/extensions/microsoft.flux` cluster extension resource. The `microsoft.flux` extension must be installed in the cluster in order to create `fluxConfigurations`. This extension is installed automatically when you create the first `Microsoft.KubernetesConfiguration/fluxConfigurations` in a cluster. You can also install it manually before you create your configurations.

Each association between an Azure Arc-enabled Kubernetes cluster configuration and the corresponding GitOps repository resides in Azure, as part of the Azure Resource Manager resource representing the Azure Arc-enabled Kubernetes cluster. You can configure that association via traditional Azure management interfaces, such as the Azure portal or Azure CLI.

To use GitOps with an Azure Arc-enabled Kubernetes cluster, the following high-level steps are required:

1. Verify that you satisfy all the prerequisites. You'll need:

   - An existing Azure Arc-enabled Kubernetes cluster.
   - Read and write permissions on the `Microsoft.Kubernetes/connectedClusters` resource type.
   - The latest version of Azure Command Line Interface (CLI), along with the latest `k8s-configuration` and `k8s-extension` CLI extension packages.
   - Registration of the required service providers on the Azure subscription.
   - Outbound connectivity for the GitOps agents. For details regarding target URLs and ports, refer to the product documentation.

1. Use the `k8s-configuration` Azure CLI extension to apply a Flux configuration and enable GitOps in your Arc-enabled Kubernetes cluster.
1. Validate the configuration to confirm it was successfully created. The configuration resource will be updated with compliance status, messages, and debugging information.

Once you've applied your configuration, you can use the Azure portal to view compliance details. You can also use the Azure portal to create, update, and delete GitOps configurations.

Alternatively, you can use Azure Policy to automate this process, allowing you to apply it consistently at scale. To create an Azure Policy assignment in the Azure portal, follow these high-level steps:

1. In the Azure portal, displaying Azure policy definitions, search for "Configure Kubernetes clusters with specified GitOps configuration" and select one of the built-in policy definitions.
1. Create a policy assignment by specifying the following settings:

   - Set the scope to the management group, subscription, or resource group where the policy assignment will apply.
   - Optionally, specify exclusions to designate any subscopes of resources where the policy shouldn't apply.
   - Enable policy enforcement.
   - Set values of the `sourceControlConfiguration` parameter, representing the association between Git repositories and configuration of the corresponding components of the Azure Arc-enabled Kubernetes cluster.
   - Create a remediation task and enable the **Create a managed identity** option. Make sure that the identity has the **Contributor** role.

The policy assignment typically takes effect within 20 minutes from the time you create it. It will automatically enable GitOps on each Azure Arc-enabled Kubernetes cluster that is within the scope of the assignment. For existing clusters, you'll need to manually run the remediation task.

> [!TIP]
> For sample manifest files illustrating configuration of Azure Arc-enabled Kubernetes clusters, refer to [the official, Microsoft-curated GitHub repository](https://github.com/Azure/arc-k8s-demo).

Choose the best response for each of the following questions. Then select "Check your answers".
