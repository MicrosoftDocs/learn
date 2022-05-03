One of the primary benefits of Azure Arc is facilitating implementation of DevOps principles that apply established development practices to operations. This results in improved agility, without jeopardizing the stability of IT environment. One way to promote DevOps principles is to implement GitOps, which streamline releases of applications by reducing the manual effort involved in their deployment. Azure Arc-enabled Kubernetes clusters offer support for GitOps. In this unit, you'll learn about GitOps and how to configure it. 

## What is GitOps?

GitOps is a DevOps practice that relies on a Git repository to host files that contain the configuration representing the expected state of a resource. An agent running on the cluster monitors the state of the repository. When there is a change in the repository, the agent pulls the changed files to the cluster and applies the new configuration.

In the context of Azure Arc-enabled Kubernetes clusters, a Git repository hosts a configuration of a Kubernetes cluster, including its resources such as pods and deployments. A pod or a set of pods running on the cluster polls the status of the repository. Once it detects a change, it pulls and applies the new configuration to the cluster.

Azure Arc-enabled Kubernetes clusters rely on Flux, an open-source GitOps deployment tool. The Flux extension is installed in the cluster, and is then used to configure the pods responsible for tracking changes to the Git repository you designate and applying them to the local cluster. In addition, the containerized Flux operator also periodically reviews the existing cluster configuration to ensure that it matches the one residing in the Git repository. If there is a configuration drift, the Flux agent remediates it by reapplying the desired configuration.

:::image type="content" source="../media/6-arc-enabled-kubernetes-cicd-flow.png" alt-text="Diagram of the GitOps flow showing an application update.":::

GitOps simplifies standardizing Kubernetes configuration across your organization. You can define a baseline configuration that you want to apply to every cluster and its components, including, for example, the delegation model, monitoring and logging settings, as well as characteristics of cluster-wide services.

## How to configure GitOps

GitOps associates your Kubernetes cluster with one or more Git repositories, where each of them can describe different aspects of cluster configuration. Each Git repository can contain configuration of any valid Kubernetes resources, such as namespaces or deployments in the form of manifest files. It is possible to use Helm charts, which facilitates deployment of applications.

> [!NOTE]
> When using Helm charts, the Flux operator interacts with the containerized Helm operator to deploy packaged applications.

:::image type="content" source="../media/6-arc-enabled-k8s-gitops.png" alt-text="Diagram showing the process of applying GitOps-based configuration to multiple Azure Arc enabled clusters.":::

After the microsoft.flux cluster extension is installed, you can create one or more fluxConfigurations resources that sync your Git repository sources to the cluster and reconcile the cluster to the desired state. With GitOps, you can use your Git repository as the source of truth for cluster configuration and application deployment.

Each association between an Azure Arc-enabled Kubernetes cluster configuration and the corresponding GitOps repository resides in Azure, as part of the Azure Resource Manager resource representing the Azure Arc-enabled Kubernetes clusters. You can configure that association via traditional Azure management interfaces, such as the Azure portal or Azure CLI.

To use GitOps with Azure Arc-enabled Kubernetes cluster, the following high-level steps are required:

1. Verify that you satisfy all the prerequisites. You'll need:

   - An existing Azure-Arc enabled Kubernetes cluster.
   - Read and write permissions on the `Microsoft.Kubernetes/connectedClusters` resource type.
   - Azure Command Line Interface (CLI) version 2.15 or newer installed on your management computer, along with the latest `k8s-configuration` and `k8s-extension` CLI extension packages.
   - Registration of the required service providers on the Azure subscription.
   - Outbound connectivity for the GitOps agents. For details regarding target URLs and ports, refer to Microsoft Docs.

1. Use the `k8s-configuration` Azure CLI extension to apply a Flux configuration and enable GitOps in your Arc-enabled Kubernetes cluster.
1. Validate the configuration to confirm it was successfully created. The configuration resource will be updated with compliance status, messages, and debugging information.

Once you have applied your configuration, you can use the Azure portal to view compliance details. You can also create, update, and delete GitOps configurations in the Azure portal.

Alternatively, you can use Azure Policy to automate this process, allowing you to apply it consistently at scale. To create an Azure Policy assignment in the Azure portal, follow these high-level steps:

1. In the Azure portal, displaying Azure policy definitions, search for "Configure Kubernetes clusters with specified GitOps configuration" and select one of the built-in policy definitions.
1. Create a policy assignment by specifying the following settings:

   - Set the scope to the management group, subscription, or resource group where the policy assignment will apply.
   - Optionally, specify an exclusion to designate a subscope of resources where the policy should not apply.
   - Enable policy enforcement.
   - Set values of the **sourceControlConfiguration** parameter, representing the association between Git repositories and configuration of the corresponding components of the Azure Arc-enabled Kubernetes cluster.
   - Create a remediation task and enable the **Create a managed identity** option. Verify that the identity will have Contributor permissions. 

The policy assignment will automatically enable GitOps on each Azure Arc-enabled Kubernetes cluster that is within the scope of the assignment. For existing clusters, you need to manually run the remediation task. The policy assignment typically takes effect within 20 minutes from the time you create it.

> [!TIP]
> For sample manifest files illustrating configuration of Azure Arc-enabled Kubernetes clusters, refer to [the official, Microsoft-curated GitHub repository](https://github.com/Azure/arc-k8s-demo).

Choose the best response for each of the following questions. Then select "Check your answers".
