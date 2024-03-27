:::row:::
:::column span="2":::
For classified workloads, customers can use Azure services to secure target workloads while reducing identified risks. Azure, with Azure Stack Hub and Azure Stack Edge, can support private and hybrid cloud deployment models, and it’s suitable for many different government workloads involving both unclassified and classified data. The following data classification taxonomy is used in this unit: **confidential**, **secret**, and **top secret**. Unclassified data lies outside of this taxonomy, as it doesn’t require further protection. Similar data classification schemes exist in many countries/regions.
:::column-end:::
:::column span="2":::
:::image type="complex" source="../media/azure-support-classification-levels.png" alt-text="Azure support for various data classifications.":::
The infographic shows a series of concentric rings, which correspond to Azure support classification levels. The hub of the graphic is labeled “Top Secret—Private/hybrid cloud”. The second ring from center is labeled “Secret”, the third ring from center is labeled “Confidential”, and the fourth ring from center is labeled “Unclassified”. An arrow labeled “Microsoft Azure” spans the second, third, and fourth rings (labeled “Secret”, “Confidential”, and “Unclassified”, respectively). On top of the arrow is a Microsoft Azure icon.
:::image-end:::
:::column-end:::
:::row-end:::

## Deploy confidential data and workloads

The following list identifies key enabling technologies and services that customers may find helpful when deploying **confidential** data and workloads in Azure:

* All recommended technologies used for unclassified data, especially services such as [Virtual Network](/azure/virtual-network/virtual-networks-overview), [Microsoft Defender for Cloud](/azure/security-center/), and [Azure Monitor](/azure/azure-monitor/).
* Public IP addresses are disabled, allowing only traffic through private connections, including [ExpressRoute](/azure/expressroute) and [Virtual Private Network](/azure/vpn-gateway/) (VPN) gateway.
* Data encryption at rest and in transit is recommended with customer-managed keys (CMK) in [Azure Key Vault](/azure/key-vault/) backed by multi-tenant hardware security modules (HSMs) that have FIPS 140-2 Level 2 validation.
* Only services that support [VNet Integration](/azure/virtual-network/virtual-network-for-azure-services) options are enabled. Azure VNet allows customers to place Azure resources in a non-internet routable network, which can then be connected to customer on-premises network using VPN technologies. VNet Integration gives web apps access to resources in the virtual network.
* Customers can use [Azure Private Link](/azure/private-link/) to access Azure PaaS services over a private endpoint in their VNet. This link ensures that traffic between their VNet and the service travels across the Microsoft global backbone network, which eliminates the need to expose the service to the public internet.
* [Customer Lockbox](/azure/security/fundamentals/customer-lockbox-overview) for Azure allows customers to approve/deny elevated access requests for customer data in support scenarios. It's an extension of the Just-in-Time (JIT) workflow that comes with full audit logging enabled.

Azure public multi-tenant cloud capabilities, allow customers to achieve the level of isolation, security, and confidence required to store confidential data. Customers should use Microsoft Defender for Cloud and Azure Monitor for visibility into their Azure environments, including security posture.

## Deploy secret data and workloads

The following list identifies key enabling technologies and services that customers may find helpful when deploying **secret** data and workloads in Azure:

* All recommended technologies used for confidential data.
* Use Azure Key Vault [Managed HSM](/azure/key-vault/managed-hsm/overview), which provides a fully managed, highly available, single-tenant HSM as a service that uses FIPS 140-2 Level 3 validated HSMs. Each Managed HSM instance is bound to a separate security domain, controlled by the customer, and isolated cryptographically from instances belonging to other customers.
* [Azure Dedicated Host](https://azure.microsoft.com/services/virtual-machines/dedicated-host/) provides physical servers that can host one or more Azure VMs and are dedicated to one Azure subscription. Customers can provision dedicated hosts within a region, availability zone, and fault domain. They can then place VMs directly into the dedicated hosts using whatever configuration best meets their needs. Dedicated Host provides hardware isolation at the physical server level, allowing customers to place their Azure VMs on an isolated and dedicated physical server that runs only their organization's workloads to meet corporate compliance requirements.
* Accelerated FPGA networking based on [Azure SmartNICs](https://www.microsoft.com/research/publication/azure-accelerated-networking-smartnics-public-cloud/) allows customers to offload host networking to dedicated hardware, enabling tunneling for VNets, security, and load balancing. Offloading network traffic to a dedicated chip prevents side-channel attacks on the main CPU.
* [Azure confidential computing](/azure/confidential-computing/) offers encryption of data while it's in use, ensuring that data is always under customer control. Data is protected inside a hardware-based trusted execution environment (TEE, also known as enclave), and there's no way to view data or operations from outside the enclave.
* [Just-in-time (JIT) virtual machine (VM) access](/azure/security-center/security-center-just-in-time) can be used to lock down inbound traffic to Azure VMs by creating network security group (NSG) rules. The customer selects ports on the VM that are locked down to inbound traffic. When a user requests access to a VM, Microsoft Defender for Cloud checks that the user has proper role-based access control (RBAC) permissions.

To accommodate secret data in the Azure public multi-tenant cloud, customers can deploy more technologies and services on top of the ones used for confidential data. They can also limit their services to ones that provide sufficient isolation. These services offer isolation options at run time and support data encryption at rest. They use customer-managed keys in dedicated single tenant HSMs that are solely under customer control.

## Deploy top secret data and workloads

The following list identifies key enabling products that customers may find helpful when deploying **top secret** data and workloads in Azure:

* Use all recommended technologies for secret data.
* [Azure Stack Hub](/azure-stack/operator/azure-stack-overview) enables customers to run workloads using the same architecture and APIs as in Azure while having a physically isolated network for their highest classification data.
* [Azure Stack Edge](/azure/databox-online/azure-stack-edge-gpu-overview) allows the storage and processing of the highest classification data but also enables customers to upload resulting information or models directly to Azure. This approach creates a path for information sharing between domains that makes it easier and more secure.
* [Tactical Azure Stack Hub](https://www.delltechnologies.com/en-us/collaterals/unauth/data-sheets/products/converged-infrastructure/dell-emc-integrated-system-for-azure-stack-hub-tactical-spec-sheet.pdf) addresses tactical edge deployments for limited or no connectivity, fully mobile requirements, harsh conditions requiring military specification solutions, and so on.
* User-provided hardware security modules (HSMs) allow customers to store their encryption keys and other secrets in HSMs deployed on-premises and controlled solely by customers.

Accommodating top secret data typically requires a disconnected environment, which is what Azure Stack Hub provides.  Azure Stack Hub can be [operated disconnected](/azure-stack/operator/azure-stack-disconnected-deployment) from Azure or the internet. Even though "air-gapped" networks don't necessarily increase security, many governments may be reluctant to store data with this classification in an internet connected environment. Azure offers an unmatched variety of public, private, and hybrid cloud deployment models to address each customer's concerns regarding the control of their data.

Now, let's review what you've learned with a knowledge check.
