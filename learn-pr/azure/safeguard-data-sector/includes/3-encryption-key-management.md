Data encryption in the cloud is an important tool to reduce risk, and it's expected by government customers worldwide. End-to-end data encryption using advanced ciphers is a basic part of guaranteeing customer-data confidentiality and integrity in the cloud. Azure helps customers protect their data through its entire lifecycle: at rest, in transit, or even in use. It also offers comprehensive encryption-key management to help customers control their keys in the cloud.

## Data encryption at rest

Azure provides many options for [data encryption at rest](/azure/security/fundamentals/encryption-atrest) to help customers safeguard their data and meet their compliance needs. These options include Microsoft-managed encryption keys and customer-managed encryption keys. The security process relies on multiple encryption keys and services, such as Azure Key Vault and Azure Active Directory, to ensure secure key access and centralized key management.

Detailed information about various [data encryption models](/azure/security/fundamentals/encryption-models) and specifics on key management for a wide range of Azure platform services is available in the [online documentation](/azure/security/fundamentals/encryption-atrest).

## Data encryption in transit

Customers can choose from several options for [encrypting data in transit](/azure/security/fundamentals/encryption-overview#encryption-of-data-in-transit), including:

* Transport Layer Security (TLS) to help protect data when it's traveling between customers and Azure services.
* Azure Storage transactions can be forced to take place over HTTPS.
* In-transit encryption for VMs can use the Remote Desktop Protocol (RDP) to enable TLS protection for remote sessions to Windows and Linux VMs in Azure. Alternatively, you can use the Secure Shell (SSH) for encrypted connections to Linux VMs running in Azure.
* VPN encryption allows customers to use Azure VPN Gateway to send encrypted traffic between their Virtual Network (VNet) and their on-premises infrastructure across the public internet.
* ExpressRoute allows customers to create private connections between their on-premises infrastructure and Azure with several data encryption options.

Data is protected as it moves between client systems and cloud services, regardless of the method clients use to connect. Customers should review the Azure [best practices](/azure/security/fundamentals/data-encryption-best-practices#protect-data-in-transit) for protecting data in transit. For key Azure services (for example, Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics), data encryption in transit is [enforced by default](/azure/azure-sql/database/security-overview#information-protection-and-encryption).

## Azure confidential computing

:::row:::
:::column span="2":::
[Azure confidential computing](https://azure.microsoft.com/solutions/confidential-compute/) is a set of data-security capabilities that offers encryption of data while in use. This means that data can be processed in the cloud with the confidence that it's always under customer control. Confidential computing makes sure that when data is in the clear, which is needed for efficient data processing in memory, the data is protected inside a trusted execution environment (TEE, also known as an enclave).

TEE means that there's no way to view data or the operations from outside the enclave and that only the application designer has access to TEE data. Access is denied to everyone else, including Azure administrators. TEE also helps ensure that only authorized code may access data. If the code is changed or tampered with, the operations are denied, and the environment is disabled. Azure provides a hardware-based TEE using [Intel Software Guard Extensions](https://software.intel.com/content/www/us/en/develop/topics/software-guard-extensions.html) (SGX) technology.
:::column-end:::
:::column span="2":::
:::image type="complex" source="../media/tee-protects-against.png" alt-text="Infographic showing trusted execution environment protection.":::
Infographic with title "TEE protects against:". Underneath the title are two icons indicating the two groups that TEE protects against, one labeled "Malicious insiders" and the other labeled "External attackers." Underneath the icons on the left side of the infographic is a stack of five tiers of boxes. The top row has two boxes side by side, each labeled "App.". The next four boxes underneath are labeled, in descending order, "Operating System," "Hypervisor," "CPU," and "Host." To the right of the stack of boxes is another box with two stacked boxes inside of it, one labeled "Code" and one labeled "Data." A lock icon is superimposed over the right-hand side of the "Code" and "Data" boxes. On the right-hand side of the top right "App" box is a rectangular outline encompassing the right-hand end of that "App" box. A similar rectangular outline encompasses the right-hand end of the "CPU" box. These two rectangular outlines are a joined together by line connecting them. From the middle of that connecting line is a line segment that connects to the box containing the "Code" and "Data" boxes.
:::image-end:::
:::column-end:::
:::row-end:::

Next, we'll look at the controls that prevent data access by Microsoft engineers for service maintenance, customer support, or other scenarios.
