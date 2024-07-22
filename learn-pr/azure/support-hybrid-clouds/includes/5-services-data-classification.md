:::row:::
:::column span="2":::
For classified workloads, customers can use Azure services to secure target workloads while reducing identified risks. Azure, with [Azure Stack Hub](https://azure.microsoft.com/products/azure-stack/hub/) and [Azure Stack Edge](https://azure.microsoft.com/products/azure-stack/edge/), can support private and hybrid cloud deployment models, and it's suitable for many different government workloads involving both unclassified and classified data. The following data classification taxonomy is used in this module:

- **Confidential**.
- **Secret**.
- **Top secret**.

Similar data classification schemes exist in many countries/regions.

For top secret data, customers can deploy Azure Stack Hub, which can operate fully disconnected from Azure and the internet. [Tactical Azure Stack Hub](https://www.dell.com/en-us/dt/hyperconverged-infrastructure/microsoft-azure-stack/microsoft-azure-stack-hub.htm) is also available to address tactical edge deployments for limited or no connectivity, fully mobile requirements, harsh conditions requiring military specification solutions, and so on.
:::column-end:::
:::column span="2":::
:::image type="complex" source="../media/azure-support-classification-levels.png" alt-text="Azure support classification levels.":::
Infographic shows a series of concentric rings, which correspond to Azure support classification levels. The hub of the graphic is labeled "Top Secret—Private/hybrid cloud." The second ring from center is labeled "Secret," the third ring from center is labeled "Confidential," and the fourth ring from center is labeled "Unclassified." An arrow labeled "Microsoft Azure," spans the second, third, and fourth rings (labeled "Secret," "Confidential," and "Unclassified," respectively). The arrow has a Microsoft Azure icon above it.
:::image-end:::
:::column-end:::
:::row-end:::

## Confidential data

Customers might find these key enabling technologies and services helpful when deploying confidential data and workloads in Azure:

- All recommended technologies used for unclassified data, especially services such as [Azure Virtual Network](/azure/virtual-network/virtual-networks-overview), [Microsoft Defender for Cloud](/azure/defender-for-cloud/), and [Azure Monitor](/azure/azure-monitor/).
- Public IP addresses are disabled allowing only traffic through private connections, including [ExpressRoute](/azure/expressroute/) and [Virtual Private Network](/azure/vpn-gateway/) (VPN) gateway.
- Data encryption is recommended with customer-managed keys (CMK) in [Azure Key Vault](/azure/key-vault/) backed by multitenant hardware security modules (HSMs) that have Azure Key Vault Managed HSM (Hardware Security Module) FIPS 140-2 Level 2 validation.
- Only services that support [virtual network integration](/azure/virtual-network/virtual-network-for-azure-services) options are enabled. Azure Virtual Network enables customers to place Azure resources in a non-internet routable network, which can then be connected to a customer’s on-premises network using VPN technologies. Virtual network integration gives web apps access to resources in the virtual network.
- Customers can use [Azure Private Link](/azure/private-link/) to access Azure PaaS services over a private endpoint in their virtual network. The private link ensures that traffic between their virtual network and the service travels across the Microsoft global backbone network, which eliminates the need to expose the service to the public Internet.
- [Customer Lockbox](/azure/security/fundamentals/customer-lockbox-overview) for Azure enables customers to Approve/Deny elevated access requests for customer data in support scenarios. It’s an extension of the Just-in-Time (JIT) workflow that comes with full audit logging enabled.

Azure public multitenant cloud capabilities, allow customers to achieve the level of [isolation, security, and confidence](/azure/azure-government/azure-secure-isolation-guidance) required to store confidential data. Customers should use Microsoft Defender for Cloud and Azure Monitor to gain visibility into their Azure environments including the security posture of their subscriptions.

## Secret data

Key enabling technologies and services that customers might find helpful when deploying secret data and workloads in Azure are listed here:

- All recommended technologies used for confidential data.
- Use [Azure Key Vault Managed HSM (Hardware Security Module)](/azure/key-vault/managed-hsm/overview). It provides a fully managed, highly available, single-tenant HSM as a service that uses Federal Information Processing Standards (FIPS) 140-2 Level 3 validated HSMs. Each Managed HSM instance is bound to a separate security domain. The customer controls the HSM instance, which is isolated cryptographically from instances belonging to other customers.
- [Azure Dedicated Host](https://azure.microsoft.com/services/virtual-machines/dedicated-host/) provides physical servers that can host one or more Azure VMs and are dedicated to one Azure subscription. Customers can provision dedicated hosts within a region, availability zone, and fault domain. They can then place VMs directly into provisioned hosts using whatever configuration best meets their needs. Azure Dedicated Host provides hardware isolation at the physical server level, enabling customers to place their Azure VMs on an isolated and dedicated physical server that runs only their organization’s workloads to meet corporate compliance requirements.
- Accelerated Field-programmable gate array (FPGA) networking based on [Azure SmartNICs](https://www.microsoft.com/research/publication/azure-accelerated-networking-smartnics-public-cloud/) enables customers to offload host networking to dedicated hardware, enabling tunneling for VNets, security, and load balancing. Offloading network traffic to a dedicated chip guards against side-channel attacks on the main CPU.
- [Azure confidential computing](/azure/confidential-computing/) offers encryption of data while in use, ensuring that data is always under customer control. Data is protected inside a hardware-based trusted execution environment (TEE, also known as enclave) and there's no way to view data or operations from outside the enclave.
- [Just-in-time (JIT) virtual machine (VM) access](/azure/defender-for-cloud/just-in-time-access-usage) can be used to lock down inbound traffic to Azure VMs by creating network security group (NSG) rules. The customer selects ports on the VM to which inbound traffic is locked down. When a user requests access to a VM, Microsoft Defender for Cloud checks that the user has proper role-based access control (RBAC) permissions.

To accommodate secret data in the Azure public multitenant cloud, customers can deploy other technologies and services on top of what they use for confidential data. They can limit their provisioned services to ones that provide sufficient isolation. These services offer various isolation options at run time and support data encryption at rest by using customer-managed keys in single-tenant HSMs. The customer controls the HSMs that are isolated cryptographically from HSM instances belonging to other customers.

## Top secret data

The following list includes the key enabling products that customers might find helpful when deploying top secret data and workloads in Azure:

- All recommended technologies used for secret data.
- [Azure Stack Hub](/azure-stack/operator/azure-stack-overview) enables customers to run workloads using the same architecture and APIs as in Azure while having a physically isolated network for their highest classification data.
- [Azure Stack Edge](/azure/databox-online/azure-stack-edge-gpu-overview) allows the storage and processing of the highest classification data but also enables customers to upload resulting information or models directly to Azure. This approach creates a path for information sharing between domains that makes it easier and more secure.
- [Tactical Azure Stack Hub](https://www.dell.com/en-us/dt/hyperconverged-infrastructure/microsoft-azure-stack/microsoft-azure-stack-hub.htm) is a ruggedized and field-deployable version of Azure Stack Hub. Tactical Azure Stack Hub addresses tactical edge deployments for limited or no connectivity, fully mobile requirements, harsh conditions requiring military specification solutions, and so on.
- User-provided hardware security modules (HSMs) allow customers to store their encryption keys and other secrets in HSMs deployed on-premises and controlled solely by customers.

Accommodating top secret data most likely requires a disconnected environment, which is what Azure Stack Hub provides. Azure Stack Hub can be [operated disconnected](/azure-stack/operator/azure-stack-disconnected-deployment) from Azure or the internet. Even though *air-gapped* networks don't necessarily increase security, many governments are reluctant to store data with this classification in an internet-connected environment.

Now, let’s look at what you learned with a short knowledge check.
