For classified workloads, customers can use Azure services to secure target workloads while reducing identified risks. Azure, with Azure Stack Hub and Azure Stack Edge, can support private and hybrid cloud deployment models, and it’s suitable for many different government workloads involving both unclassified and classified data. The following data classification taxonomy is used in this unit: **confidential**, **secret**, and **top secret**. Similar data classification schemes exist in many countries.

## Deploy top secret data and workloads

Key enabling products that customers may find helpful when deploying top secret data and workloads in Azure are listed below:

* All recommended technologies used for secret data.
* [Azure Stack Hub](https://docs.microsoft.com/azure-stack/operator/azure-stack-overview) enables customers to run workloads using the same architecture and APIs as in Azure while having a physically isolated network for their highest classification data.
* [Azure Stack Edge](https://docs.microsoft.com/azure/databox-online/azure-stack-edge-overview) allows the storage and processing of highest classification data but also enables customers to upload resulting information or models directly to Azure. This approach creates a path for information sharing between domains that makes it easier and more secure.
* Tactical Azure Stack Hub addresses tactical edge deployments for limited or no connectivity, fully mobile requirements, harsh conditions requiring military specification solutions, and so on.
* User-provided Hardware Security Modules (HSMs) allow customers to store their encryption keys and other secrets in HSMs deployed on-premises and controlled solely by customers.

Accommodating Top Secret data will likely require a disconnected environment, which is what Azure Stack Hub provides. Azure Stack Hub can be operated completely disconnected from Azure or the internet. Even though “air-gapped” networks do not necessarily increase security, many governments may be reluctant to store data with this classification in an Internet connected environment. Azure offers an unmatched variety of public, private, and hybrid cloud deployment models to address each customer’s concerns regarding the control of their data.

## Deploy secret data and workloads

Key enabling technologies and services that customers may find helpful when deploying secret data and workloads in Azure are listed below:

* Use Azure Key Vault Managed HSM, which provides a fully managed, highly available, single-tenant HSM as a service that uses FIPS 140-2 Level 3 validated HSMs. Each Managed HSM instance is bound to a separate security domain controlled by the customer and isolated cryptographically from instances belonging to other customers.  Cryptographic isolation relies on Intel Software Guard Extensions (SGX) technology that provides encrypted code and data to help ensure customer control.
* [Azure Dedicated Host](https://azure.microsoft.com/services/virtual-machines/dedicated-host/) provides physical servers that can host one or more Azure VMs and are dedicated to one Azure subscription. Customers can provision dedicated hosts within a region, availability zone, and fault domain. They can then place VMs directly into provisioned hosts using whatever configuration best meets their needs. Dedicated Host provides hardware isolation at the physical server level, allowing customers to place their Azure VMs on an isolated and dedicated physical server that runs only their organization’s workloads to meet corporate compliance requirements.
* Accelerated FPGA networking based on Azure SmartNICs allows customers to offload host networking to dedicated hardware, enabling tunneling for VNets, security, and load balancing. Offloading network traffic to a dedicated chip prevents side-channel attacks on the main CPU. 
* [Azure confidential computing](https://docs.microsoft.com/azure/confidential-computing/) offers encryption of data while it’s in use, ensuring that data is always under customer control. Data is protected inside a Trusted Execution Environment (TEE), and there is no way to view data or operations from outside the enclave. 
* [Just-in-time (JIT) virtual machine (VM) access](https://docs.microsoft.com/azure/security-center/security-center-just-in-time) can be used to lock down inbound traffic to Azure VMs by creating Network Security Group (NSG) rules. The customer selects ports on the VM to which inbound traffic will be locked down. When a user requests access to a VM, Azure Security Center checks that the user has proper Role-Based Access Control (RBAC) permissions.

To accommodate secret data in the Azure public multi-tenant cloud, customers can deploy additional technologies and services on top of those used for confidential data and limit provisioned services to those that provide sufficient isolation. These services offer isolation options at run time and support data encryption at rest using customer-managed keys in dedicated single tenant HSMs that are solely under customer control.

## Deploy confidential data and workloads

Key enabling technologies and services that customers may find helpful when deploying confidential data and workloads in Azure are listed below:

* All recommended technologies used for unclassified data, especially services such as Virtual Network, Azure Security Center, and Azure Monitor.
* Public IP addresses are disabled allowing only traffic through private connections, including ExpressRoute and Virtual Private Networks (VPNs).
* Data encryption at rest and in transit is recommended with Customer-Managed Keys (CMK) stored in tamper-resistant Azure Key Vault Hardware Security Modules (HSMs), currently with FIPS 140-2 Level 2 overall validation.
* Only services that support VNet Integration options are enabled. Azure VNet allows customers to place Azure resources in a non-internet routable network, which can then be connected to customer on-premises network using VPN technologies. VNet Integration gives web apps access to resources in the virtual network.
* Customers can use Azure Private Link to access Azure PaaS services over a private endpoint in their VNet, ensuring that traffic between their VNet and the service travels across the Microsoft global backbone network, which eliminates the need to expose the service to the public Internet.
* [Customer Lockbox](https://docs.microsoft.com/azure/security/fundamentals/customer-lockbox-overview) for Azure allows customers to Approve/Deny elevated access requests for customer data in support scenarios. It’s an extension of the Just-in-Time (JIT) workflow that comes with full audit logging enabled.

Using Azure public multi-tenant cloud capabilities, customers can achieve the level of isolation, security, and confidence required to store confidential data. Customers should use Azure Security Center and Azure Monitor for visibility into their Azure environments, including security posture.

Now, let’s review what you’ve learned with a knowledge check.