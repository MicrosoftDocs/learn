Insider threat is usually characterized as potential for providing back-door connections and cloud service provider (CSP) privileged user access to customer's systems and data. Customers expect assurances around any potential customer data access by Microsoft personal, and Azure has strict controls in place to prevent any unauthorized access.

## Data for customer support and troubleshooting

Azure is a 24 x 7 globally operated service. However, support and troubleshooting rarely require access to customer data. Customers who want added control for support and troubleshooting can use Customer Lockbox for Azure to approve or deny access to their data.

Microsoft [Azure support](https://azure.microsoft.com/support/options/) is available in markets where Azure is offered. It's staffed globally to accommodate 24 x 7 access to support engineers, using email and phone for technical support. Customers can [create and manage support requests](https://docs.microsoft.com/azure/azure-supportability/how-to-create-azure-support-request) in the Azure portal. As needed, frontline support engineers can escalate customer requests to Azure DevOps personnel responsible for Azure service development and operations. These Azure DevOps engineers are also staffed globally. The same production access controls and processes are imposed on all Microsoft engineers, including Microsoft full-time employees and subprocessors/vendors.

Customer data is encrypted at rest by default when it's stored in Azure, and customers can control their own encryption keys in Azure Key Vault. Access to customer data isn't needed to resolve most of customer support requests. Microsoft engineers rely heavily on logs to provide customer support. Azure has controls in place to restrict access to customer data for support and troubleshooting scenarios if that access becomes necessary.

## Reduce insider data access

No default access rights and Just-in-Time (JIT) access provisions greatly reduce the risks associated with traditional on-premises administrator elevated access rights that usually continue throughout the time of employment. Microsoft makes it much more difficult for malicious insiders to tamper with customer applications and data. The same access control restrictions and processes are imposed on all Microsoft engineers, including full-time employees and subprocessors/vendors. The following controls are in place to restrict insider access to customer data:

* Internal Microsoft controls that prevent access to production systems unless it's specifically authorized through **Just-in-Time (JIT)** privileged access management system.
* Enforcement of **Customer Lockbox** that puts customers in charge of approving insider access in support and troubleshooting scenarios. For the majority of support scenarios, access to customer data isn't required.
* **Data encryption** with the option for customer-managed encryption keys. Encrypted data is accessible only by entities who are in possession of the key.
* **Customer monitoring** of external access to their provisioned Azure resources, which includes [security alerts](https://docs.microsoft.com/azure/security-center/security-center-alerts-overview).

## Access control requirements

Microsoft takes strong measures to protect customer data from inappropriate access or use by unauthorized persons. Microsoft engineers (including full-time employees and subprocessors/vendors) [don't have default access](https://www.microsoft.com/trustcenter/privacy/data-management/data-access) to customer data in the cloud. Instead, they are granted access, under management oversight, only when necessary. Using the [restricted access workflow](https://www.youtube.com/watch?v=lwjPGtGGe84&feature=youtu.be&t=25m), access to customer data is carefully controlled, logged, and revoked when it's no longer needed. For example, access to customer data might be required to resolve customer-initiated troubleshooting requests. The access control requirements are [established by the following policy](https://docs.microsoft.com/azure/security/fundamentals/protection-customer-data):

* No access to customer data, by default.
* No user or administrator accounts on customer virtual machines (VMs).
* Grant the least privilege that is required to complete task, audit, and log access requests.

Microsoft engineers can be granted access to customer data using temporary credentials via **Just-in-Time (JIT)** access. There must be an incident logged in the Azure Incident Management system that describes the reason for access, approval record, what data was accessed, and so on. This approach ensures that there's appropriate oversight for all access to customer data and that all JIT actions (consent and access) are logged for audit.

The Azure [SOC 2 Type 2 attestation report](https://aka.ms/azuresoc2auditreport), produced by an independent third-party auditing firm, provides evidence that procedures have been created for granting temporary access for Azure personnel to customer data and applications upon appropriate approval for customer support or incident handling purposes.

JIT access works with multi-factor authentication that requires Microsoft engineers to use a smartcard to confirm their identity. All access to production systems is performed using Secure Admin Workstations (SAWs) that are consistent with published guidance on [securing privileged access](https://docs.microsoft.com/security/compass/overview). Use of SAWs for access to production systems is required by Microsoft policy and compliance with this policy is closely monitored. These workstations use a fixed image with all software fully managed. Only select activities are allowed and users can't accidentally circumvent the SAW design since they don't have admin privileges on these machines. Access is permitted only with a smartcard and access to each SAW is limited to specific set of users.

## Customer Lockbox

[Customer Lockbox](https://docs.microsoft.com/azure/security/fundamentals/customer-lockbox-overview) for Azure is a service that allows customers to control how a Microsoft engineer accesses their data. As part of the support workflow, a Microsoft engineer might require elevated access to customer data. Customer Lockbox puts the customer in charge of that decision by allowing the customer to Approve/Deny such elevated requests. Customer Lockbox is an extension of the JIT workflow and comes with full audit logging enabled. Customer Lockbox capability isn't required for support cases that don't involve access to customer data. For the majority of support scenarios, access to customer data isn't needed and the workflow shouldn't require Customer Lockbox. Microsoft engineers rely heavily on logs to maintain Azure services and provide customer support.

Customer Lockbox is automatically available to all customers who have an Azure support plan with a minimum level of Developer. With an eligible support plan, a customer doesn't need to take action to enable Customer Lockbox for [supported services and scenarios in general availability](https://docs.microsoft.com/azure/security/fundamentals/customer-lockbox-overview#supported-services-and-scenarios-in-general-availability). Other Azure services are currently in [public preview for Customer Lockbox](https://docs.microsoft.com/azure/security/fundamentals/customer-lockbox-overview#supported-services-and-scenarios-in-preview) and customers can enable Customer Lockbox for preview services by signing up through an online form. A Microsoft engineer will initiate Customer Lockbox request if it's needed to progress a customer-initiated support ticket. Customer Lockbox is available to customers from all Azure public regions.

## Guest VM crash dumps

On each Azure node, there's a Hypervisor that runs directly over the hardware. It divides the node into a number of Guest Virtual Machines (VMs), as shown in Figure 3 and described in Microsoft [online documentation](https://docs.microsoft.com/azure/security/fundamentals/isolation-choices#compute-isolation). Each node also has one special Root VM, which runs the Host OS.

:::row:::
:::column span="2":::
When a Guest VM (customer VM) crashes, customer data may be contained inside a memory dump file on the Guest VM. By default, Microsoft engineers don't have access to Guest VMs and can't review crash dumps on Guest VMs without customer's approval. The same process involving explicit customer authorization is used to control access to Guest VM crash dumps if the customer requests that their VM crash be investigated. As described previously, access is gated by the JIT privileged access management system and Customer Lockbox so that all actions are logged and audited. The primary forcing function for deleting the memory dumps from Guest VMs is the routine process of VM reimaging that usually occurs at least every two months.
:::column-end:::
:::column span="2":::
:::image type="complex" source="../media/PENDING.png" alt-text="Isolation of Hypervisor, Root VM, and Guest VMs":::
Pending
:::image-end:::
:::column-end:::
:::row-end:::

## Data deletion, retention, and destruction

Customers are [always in control of their customer data](https://www.microsoft.com/trust-center/privacy/data-management?rtc=1) in Azure. They can access, extract, and delete their customer data stored in Azure at will. When a customer terminates their Azure subscription, Microsoft takes the necessary steps to ensure that the customer continues to own their customer data. A common customer concern upon data deletion or subscription termination is whether another customer or Azure administrator can access their deleted data. For more information on how data deletion, retention, and destruction are implemented in Azure, see the online documentation:

* [Data deletion](https://docs.microsoft.com/azure/azure-government/azure-secure-isolation-guidance#data-deletion).
* [Data retention](https://docs.microsoft.com/azure/azure-government/azure-secure-isolation-guidance#data-retention).
* [Data destruction](https://docs.microsoft.com/azure/azure-government/azure-secure-isolation-guidance#data-destruction).

Next, let's look at the approach and key principles that cover the way Microsoft handles government request for data.