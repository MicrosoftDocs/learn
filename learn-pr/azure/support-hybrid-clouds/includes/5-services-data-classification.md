For classified workloads, customers can use Azure services to secure target workloads while reducing identified risks. Azure, with [Azure Stack Hub](https://azure.microsoft.com/products/azure-stack/hub/) and [Azure Stack Edge](https://azure.microsoft.com/products/azure-stack/edge/), can support private and hybrid cloud deployment models, and it's suitable for many different government workloads involving both unclassified and classified data. The following data classification taxonomy is used in this module:

* **Confidential**.
* **Secret**.
* **Top Secret**.

Similar data classification schemes exist in many countries.

:::row:::
:::column span="2":::
:::image type="complex" source="../media/PENDING.png" alt-text="Azure support for various data classifications.":::
PENDING
:::image-end:::
:::column-end:::
:::column span="2":::
For top secret data, customers can deploy Azure Stack Hub, which can operate fully disconnected from Azure and the internet. [Tactical Azure Stack Hub](https://www.delltechnologies.com/en-us/collaterals/unauth/data-sheets/products/converged-infrastructure/tactical_azs_spec_sheet.pdf) is also available to address tactical edge deployments for limited or no connectivity, fully mobile requirements, harsh conditions requiring military specification solutions, and so on. Figure 5 depicts key enabling services that customers can provision to accommodate a variety of workloads on Azure.
:::column-end:::
:::row-end:::

## Confidential data

Key enabling technologies and services that customers may find helpful when deploying confidential data and workloads in Azure are listed below:

* All recommended technologies used for unclassified data, especially services such as [Virtual Network](https://docs.microsoft.com/azure/virtual-network/virtual-networks-overview) (VNet), [Azure Security Center](https://docs.microsoft.com/azure/security-center/), and [Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/).
* Public IP addresses are disabled allowing only traffic through private connections, including [ExpressRoute](https://docs.microsoft.com/azure/expressroute/) and [Virtual Private Network](https://docs.microsoft.com/azure/vpn-gateway/) (VPN) gateway.
* Data encryption is recommended with customer-managed keys (CMK) in [Azure Key Vault](https://docs.microsoft.com/azure/key-vault/) backed by multi-tenant hardware security modules (HSMs) that have FIPS 140-2 Level 2 validation.
* Only services that support [VNet integration](https://docs.microsoft.com/azure/virtual-network/virtual-network-for-azure-services) options are enabled. Azure VNet enables customers to place Azure resources in a non-internet routable network, which can then be connected to customer’s on-premises network using VPN technologies. VNet integration gives web apps access to resources in the virtual network.
* Customers can use [Azure Private Link](https://docs.microsoft.com/azure/private-link/) to access Azure PaaS services over a private endpoint in their VNet, ensuring that traffic between their VNet and the service travels across the Microsoft global backbone network, which eliminates the need to expose the service to the public Internet.
* [Customer Lockbox](https://docs.microsoft.com/azure/security/fundamentals/customer-lockbox-overview) for Azure enables customers to Approve/Deny elevated access requests for customer data in support scenarios. It’s an extension of the Just-in-Time (JIT) workflow that comes with full audit logging enabled.

Using Azure public multi-tenant cloud capabilities, customers can achieve the level of [isolation, security, and confidence](https://docs.microsoft.com/azure/azure-government/azure-secure-isolation-guidance) required to store Confidential data. Customers should use Azure Security Center and Azure Monitor to gain visibility into their Azure environments including the security posture of their subscriptions.

## Secret data

Key enabling technologies and services that customers may find helpful when deploying secret data and workloads in Azure are listed below:

* All recommended technologies used for confidential data.
* Use Azure Key Vault [Managed HSM](https://docs.microsoft.com/azure/key-vault/managed-hsm/overview), which provides a fully managed, highly available, single-tenant HSM as a service that uses FIPS 140-2 Level 3 validated HSMs. Each Managed HSM instance is bound to a separate security domain controlled by the customer and isolated cryptographically from instances belonging to other customers. Cryptographic isolation relies on [Intel Software Guard Extensions](https://software.intel.com/sgx) (SGX) technology that provides encrypted code and data to help ensure customer control.
* [Azure Dedicated Host](https://azure.microsoft.com/services/virtual-machines/dedicated-host/) provides physical servers that can host one or more Azure VMs and are dedicated to one Azure subscription. Customers can provision dedicated hosts within a region, availability zone, and fault domain. They can then place VMs directly into provisioned hosts using whatever configuration best meets their needs. Dedicated Host provides hardware isolation at the physical server level, enabling customers to place their Azure VMs on an isolated and dedicated physical server that runs only their organization’s workloads to meet corporate compliance requirements.
* Accelerated FPGA networking based on [Azure SmartNICs](https://www.microsoft.com/research/publication/azure-accelerated-networking-smartnics-public-cloud/) enables customers to offload host networking to dedicated hardware, enabling tunneling for VNets, security, and load balancing. Offloading network traffic to a dedicated chip guards against side-channel attacks on the main CPU.
* [Azure confidential computing](https://docs.microsoft.com/azure/confidential-computing/) offers encryption of data while in use, ensuring that data is always under customer control. Data is protected inside a hardware-based trusted execution environment (TEE, also known as enclave) and there's no way to view data or operations from outside the enclave.
* [Just-in-time (JIT) virtual machine (VM) access](https://docs.microsoft.com/azure/security-center/security-center-just-in-time) can be used to lock down inbound traffic to Azure VMs by creating network security group (NSG) rules. Customer selects ports on the VM to which inbound traffic will be locked down and when a user requests access to a VM, Azure Security Center checks that the user has proper role-based access control (RBAC) permissions.

To accommodate secret data in the Azure public multi-tenant cloud, customers can deploy additional technologies and services on top of those used for confidential data and limit provisioned services to those that provide sufficient isolation. These services offer various isolation options at run time. They also support data encryption at rest using customer-managed keys in single-tenant HSMs controlled by the customer and isolated cryptographically from HSM instances belonging to other customers.

## Top secret data

Key enabling products that customers may find helpful when deploying top secret data and workloads in Azure are listed below:

* All recommended technologies used for secret data.
* [Azure Stack Hub](https://docs.microsoft.com/azure-stack/operator/azure-stack-overview) (formerly Azure Stack) enables customers to run workloads using the same architecture and APIs as in Azure while having a physically isolated network for their highest classification data.
* [Azure Stack Edge](https://docs.microsoft.com/azure/databox-online/azure-stack-edge-overview) (formerly Azure Data Box Edge) allows the storage and processing of highest classification data but also enables customers to upload resulting information or models directly to Azure. This approach creates a path for information sharing between domains that makes it easier and more secure.
* In addition to Azure Stack Hub, which is intended for on-premises deployment (that is, in a datacenter), a ruggedized and field-deployable version called [Tactical Azure Stack Hub](https://www.delltechnologies.com/en-us/collaterals/unauth/data-sheets/products/converged-infrastructure/tactical_azs_spec_sheet.pdf) is also available to address tactical edge deployments for limited or no connectivity, fully mobile requirements, harsh conditions requiring military specification solutions, and so on.
* User-provided hardware security modules (HSMs) allow customers to store their encryption keys and other secrets in HSMs deployed on-premises and controlled solely by customers.

Accommodating top secret data will likely require a disconnected environment, which is what Azure Stack Hub provides. Azure Stack Hub can be [operated disconnected](https://docs.microsoft.com/azure-stack/operator/azure-stack-disconnected-deployment) from Azure or the internet. Even though “air-gapped” networks don't necessarily increase security, many governments may be reluctant to store data with this classification in an internet-connected environment.

Now, let’s look at what you’ve learned with a short knowledge check.
