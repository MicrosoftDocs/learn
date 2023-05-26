In this unit, you learn about the architecture and benefits of Azure Arc-enabled Kubernetes.

## Azure Arc-enabled Kubernetes architecture

Azure Arc uses locally installed agents to establish a trusted channel with Azure. For Kubernetes clusters running anywhere, and Azure Kubernetes Services (AKS) clusters running on Azure Stack HCI, connection to Azure requires deploying several agents as pods within a dedicated cluster namespace.

The agents run in the `azure-arc` namespace in the Kubernetes cluster, and are responsible for synchronizing state to Azure, collecting Azure Arc logs and metrics, and processing configuration requests.

The Azure Arc agents do the following tasks:

- Maintain an authenticated connection to Azure and synchronize cluster metadata with the corresponding Azure resource.
- Gather cluster metadata, including cluster version, node count, and Azure Arc agent version.
- Monitor for agent updates, compliance state, and source control configuration resources applied on the cluster.
- Orchestrate interactions between Azure Arc components.

## Azure Arc-enabled Kubernetes benefits

In addition to the general Azure Arc benefits the previous unit described, Azure Arc-enabled Kubernetes offers the following capabilities:

- Enhanced support for automated updates to cluster configuration by using GitOps.

  GitOps enables automatic deployment of configurations that reside in a Git repository. Those configurations describe the desired state of Kubernetes. You can enforce specific GitOps-based configurations by using Azure Policy, which also provides centralized compliance reporting.

- Enforcement of runtime policies that affect the cluster and its pods by using Azure Policy for Kubernetes and centralized policy compliance reporting.

  For example, you can enforce the use of HTTPS for ingress traffic that targets your Azure Arc-enabled Kubernetes clusters, or ensure that containers listen only on specific ports.
  
- Azure Monitor container insights.

  This capability provides a rich monitoring experience for containers running anywhere, including Azure Arc-enabled Kubernetes and AKS on Azure Stack HCI.

You learn more about these features in the remaining units of this module.

