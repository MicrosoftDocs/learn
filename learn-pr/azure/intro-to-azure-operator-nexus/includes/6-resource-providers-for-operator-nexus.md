Azure Resource Manager provides a way to manage resources in Azure. Resource providers are the services that supply the resources you can deploy and manage through Azure Resource Manager. An Azure resource provider is a collection of REST APIs that provide functionality for a specific Azure service.

The Azure Resource Manager relies on the Azure Resource Providers (RP) to create the resources requested and managed by the RP. Before using a resource provider, your Azure subscription must be registered for the resource provider. Registration configures your subscription to work with the resource provider.

- Ensure Azure Subscription for Operator Nexus resources has been permitted access to the necessary Azure Resource Providers:
  - Microsoft.NetworkCloud
  - Microsoft.ManagedNetworkFabric
  - Microsoft.HybridContainerService
  - Microsoft.HybridNetwork
  - Microsoft.Storage
  - Microsoft.Keyvault
  - Microsoft.Network
  - Microsoft.ExtendedLocation
  - Microsoft.HybridCompute
  - Microsoft.HybridConnectivity
  - Microsoft.Insights
  - Microsoft.Kubernetes
  - Microsoft.KubernetesConfiguration
  - Microsoft.OperationalInsights
  - Microsoft.OperationsManagement
  - Microsoft.ResourceConnector
  - Microsoft.Resources

## Sample Resource Providers

The **Network Cloud Resource Provider (RP)** is the primary Operator-facing component of Operator Nexus architecture. It provides the API interface to lifecycle on-premises environments and the higher-level resources like Kubernetes clusters, virtual machines, etc. Users can interact via ARM templates, the Portal and SDKs. The Network Cloud RP API interacts with the Network Cloud operators running within the operator's on-premises environment to perform the actual lifecycle operation. A minimum set of administrative RPs allows Microsoft to perform basic management of the Operator Nexus platform resources and components.

The **Managed Network fabric** resource models the Physical Network fabric with all the resources (such as NPBs, TS, TORs, CEs & Management Switches) required for the connectivity to and from the operator network into an Operator Nexus Cluster (or instance). A network fabric is a collection of all network devices associated with a single Operator Nexus Cluster and the interconnections between network devices, compute (servers) and storage instances within that cluster.

The Network Fabric Controller (NFC) performs the configuration, bootstrapping and management required to bring-up the Network fabric and all resources required to enable networks for tenant workloads.

The **Nexus Kubernetes Service (NKS)** brings Azure-managed Kubernetes services to on-premises environments. It provides users the ability to create Kubernetes clusters and lifecycle them through an API. NKS integrates with Operator Nexus networking that supports SRIOV and DPDK. It also integrates with Operator Nexus storage backends such as Pure. These NAKS subclusters are used to deploy CNF workloads.

**Network Resources**: The network resources tie together the x86 VF features and the fabric network that was deployed by Nexus Network Fabric. They are the resources that are leveraged by the NKS workloads and Operator Nexus VMs to represent network attachments.  Their provisioning states represent whether we've completed all Undercloud setup required for these networks to be usable by both NAKS and VM attachments. (for example, [NetworkAttachmentDefinitions] created).

Networks have a many-to-one relationship with the [NetworkFabric RoutingDomain]. There are five network resource types represented in Operator Nexus.

- **Cloud Services Network Resource**
  - A Cloud Services Network is created by a Tenant user to house additional egress information that will be used by associated Virtual Machines or NAKS instances. Upon creation, the additional services that are provided by the platform will be allocated and represented in the status of this resource.
  - The Cloud Services Network will always assume a /16 Prefix: 169.0.0.0/16.
  - At least one cloud services network must be created but may be reused across many Virtual Machines and/or NAKS instances.
- **Layer-2 Network Resource**
  - A Layer-2 Network represents a network that utilizes a single isolation-domain, and only sets up Layer-2 resources (for example, no IPAM support). An example might be a L2 isolation-domain to support East-West traffic to and from a UPF proxy.
- **Layer-3 Network Resource**
  - A Layer-3 Network represents the L3 isolation-domain that is leveraged by NAKS workloads and Operator Nexus VMs to represent network attachments. Examples might include having an L3 isolation-domain to support North-South traffic for external connectivity.
- **Trunked Network Resource**
  - A Trunked Network represents trunking of VLANs across multiple L3IsolationDomain and L2IsolationDomains and doesn't support IPAM.

Azure Resource providers list: [Resource providers by Azure services - Azure Resource Manager](https://learn.microsoft.com/azure/azure-resource-manager/management/azure-services-resource-providers)
