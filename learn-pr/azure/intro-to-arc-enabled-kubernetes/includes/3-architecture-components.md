Azure Arc leverages locally installed agents to establish a trusted channel with Azure Resource Manager. Implementation details of the agent and the corresponding architecture depends in part on the type of resource you integrate with Azure. 

## Architecture of the Azure Arc enabled Kubernetes

For Kubernetes clusters and AKS clusters running on Azure Stack HCI, connection to Azure requires a deployment of several agents as containers within a designated cluster namespace. The agents are responsible for maintaining connectivity to Azure, collecting Azure Arc logs and metrics, and processing configuration requests. 

These agents run in the Kubernetes cluster that you deploy to the `azure-arc` namespace. The following table describes these agents.

|Agent|Description|
|---|---|
|`deployment.apps/config-agent`|Monitors the connected cluster for updates, compliance state, and source control configuration resources applied on the cluster.|
|`deployment.apps/controller-manager`|Orchestrates interactions between Azure Arc components.|
|`deployment.apps/metrics-agent`|Collects metrics from other Azure Arc agents to optimize the performance of these other agents.|
|`deployment.apps/cluster-metadata-operator`|Gathers cluster metadata, including cluster version, node count, and Azure Arc agent version.|
|`deployment.apps/resource-sync-agent`|Syncs cluster metadata to Azure.|
|`deployment.apps/clusteridentityoperator`|Maintains the certificate for the managed identities for Azure resources that other agents use for communication with Azure.|
|`deployment.apps/flux-logs-agent`|Collects logs from the flux operators that deploy as a part of source control configuration.|

### What are the key benefits of Azure Arc enabled Kubernetes?

In addition to the resource type-independent benefits described in the previous unit, Azure Arc enabled Kubernetes offers additional advantages, such as:

- Azure Arc enabled Kubernetes and AKS on Azure Stack HCI

  - Enforcement of run-time policies affecting the cluster and its pods by using Azure Policy for Kubernetes and centralized reporting of the corresponding policy compliance. This allows you, for example to enforce the use of HTTPS for ingress traffic targeting Kubernetes cluster or to ensure that containers listen only on specific ports that you designate.
  - Enhanced support for automated updates to cluster configuration by using GitOps. GitOps is the practice of automatic deployment of code residing in a Git repository. In this scenario, that code describes the desired state of Kubernetes configuration. You have the option to enforce specific GitOps-based configurations by using Azure Policy, which also provide centralized reporting of the corresponding policy compliance.

> [!NOTE]
> You will learn more about these features in the subsequent units of this module.

- Azure Arc enabled data services

  - Automatic upgrades and updates without any service downtime. Azure Arc enabled data services receive updates on a frequent basis including servicing patches and new features, which mirrors the update management model of their Azure counterparts. 
  - Support for automatic scaling. Azure Arc enabled data services can auto-scale dynamically to limits dependent on the capacity of your infrastructure hosting the Kubbernetes clusters.