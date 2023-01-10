Azure Arc uses locally installed agents to establish a trusted channel with Azure Resource Manager. In this unit, you'll learn about the architecture of Azure Arc-enabled Kubernetes and its benefits.

## Architecture of Azure Arc-enabled Kubernetes

For Kubernetes clusters running anywhere and Azure Kubernetes Services (AKS) clusters running on Azure Stack HCI, connection to Azure requires a deployment of several agents as pods within a dedicated cluster namespace. The agents are responsible for synchronizing state to Azure, collecting Azure Arc logs and metrics, and processing configuration requests.

The Kubernetes agents run in the `azure-arc` namespace in the Kubernetes cluster. These agents are responsible for:

- Maintaining an authenticated connection to Azure and synchronizing cluster metadata with the corresponding Azure resource.
- Gathering cluster metadata, including cluster version, node count, and Azure Arc agent version.
- Monitoring for agent updates, compliance state, and source control configuration resources applied on the cluster.
- Orchestrating interactions between Azure Arc components.

### What are the key benefits of Azure Arc-enabled Kubernetes?

In addition to the general benefits of Azure Arc described in the previous unit, Azure Arc-enabled Kubernetes offers additional advantages, such as:

- Enhanced support for automated updates to cluster configuration by using GitOps. GitOps enables automatic deployment of configurations residing in a Git repository. In this scenario, that code describes the desired state of Kubernetes configurations. You have the option to enforce specific GitOps-based configurations by using Azure Policy, which also provides centralized compliance reporting.
- Enforcement of run-time policies affecting the cluster and its pods by using Azure Policy for Kubernetes and centralized policy compliance reporting. For example, you can enforce the use of HTTPS for ingress traffic targeting your Azure Arc-enabled Kubernetes clusters, or ensure that containers listen only on specific ports that you designate.
- Azure Monitor Container Insights. This capability provides a rich monitoring experience for containers running anywhere, including Azure Arc-enabled Kubernetes and AKS on Azure Stack HCI.

> [!NOTE]
> You'll learn more about these features in the subsequent units of this module.

Choose the best response for each of the following questions. Then select "Check your answers".
