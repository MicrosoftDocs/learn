Azure Arc uses locally installed agents to establish a trusted channel with Azure Resource Manager. Implementation details of the agent and the corresponding architecture depends in part on the type of resource you integrate with Azure. In this unit, you'll learn about the architecture of Azure Arc enabled Kubernetes and its benefits. 

## Architecture of the Azure Arc enabled Kubernetes

For Kubernetes clusters running anywhere and Azure Kubernetes Services (AKS) clusters running on Azure Stack HCI, connection to Azure requires a deployment of several agents as pods within a dedicated cluster namespace. The agents are responsible for synchronizing state to Azure, collecting Azure Arc logs and metrics, and processing configuration requests. 

These agents run in the `azure-arc` namespace in the Kubernetes cluster. The Kubernetes agents are responsible for:

- Maintaining authenticated connection to Azure and synchronizing cluster metadata with the corresponding Azure resource.
- Gathering cluster metadata, including cluster version, node count, and Azure Arc agent version.
- Monitoring for agent updates, compliance state, and source control configuration resources applied on the cluster.
- Orchestrating interactions between Azure Arc components.

### What are the key benefits of Azure Arc enabled Kubernetes?

In addition to the resource type-independent benefits described in the previous unit, Azure Arc enabled Kubernetes offers additional advantages, such as:

- Azure Arc enabled Kubernetes and AKS on Azure Stack HCI

  - Enhanced support for automated updates to cluster configuration by using GitOps. GitOps is the practice of automatic deployment of configuration residing in a Git repository. In this scenario, that code describes the desired state of Kubernetes configuration. You have the option to enforce specific GitOps-based configurations by using Azure Policy, which also provide centralized reporting of the corresponding policy compliance.
  - Enforcement of run-time policies affecting the cluster and its pods by using Azure Policy for Kubernetes and centralized reporting of the corresponding policy compliance. This allows you, for example to enforce the use of HTTPS for ingress traffic targeting Kubernetes cluster or to ensure that containers listen only on specific ports that you designate.
  - Azure Monitor for Containers. This capability is available for containers running anywhere, including Azure Arc enabled Kubernetes and AKS on Azure Stack HCI. You'll find more information regarding its characteristics later in this module.


> [!NOTE]
> You will learn more about these features in the subsequent units of this module.

- Azure Arc enabled data services

  - Upgrades and updates without any service downtime. Azure Arc enabled data services receive updates on a frequent basis including servicing patches and new features, which mirror the update management model of their Azure counterparts. 
  - Support for automatic scaling. Azure Arc enabled data services can autoscale dynamically to limits dependent on the capacity of your infrastructure hosting the Kubernetes clusters.

Choose the best response for each of the following questions. Then select "Check your answers".
