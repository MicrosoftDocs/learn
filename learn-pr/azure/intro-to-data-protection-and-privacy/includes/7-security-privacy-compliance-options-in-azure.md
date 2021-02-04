As you move more data to the cloud, you want to feel confident that you're not inviting security or compliance risks. You need a partner that can work with you to help protect your data as changes occur in your environment and business.

## Microsoft’s commitment to compliance

Microsoft undergoes regular audits and submits self-assessments to third-party auditors. This helps ensure Microsoft is meeting all security and compliance advancements and requirements. Microsoft proactively collaborates with industry leaders and government bodies around the world to anticipate future compliance requirements. As a result, Microsoft is often the first global cloud service provider to adopt new frameworks and standards.

## Microsoft tools and services for compliance

Global regulatory bodies perform frequent updates to their laws and rules, which challenges organizations. Their compliance personnel must work diligently to help meet evolving requirements. Microsoft helps its customers meet compliance obligations by providing an extensive resource repository that include tools, documentation, and guidance.

### Microsoft Trust Center

The Microsoft Trust Center has extensive information about how Microsoft implements and helps support security, privacy, compliance, and transparency in all of its cloud products and services. The Trust Center is a comprehensive set of all current certifications, attestations, and other compliance offerings.

### Service Trust Center

The Service Trust Portal has extra guidance and tools to help you meet your security, compliance, and privacy needs when using Azure and other Microsoft cloud services. Audit reports, Azure Security Blueprints, and trust documents can help you understand cloud features and verify technical compliance and control requirements.

### Azure Blueprints

The free Azure Blueprints service helps customers build secure Azure applications that comply with GDPR, Health Insurance Portability and Accountability Act, and other regulations. Azure Blueprints also helps simplify large-scale Azure deployments. It packages key environment artifacts in a single blueprint definition. These definitions can include:

- Azure Resource Manager templates

- Resource groups

- Role-based access controls

- Policies

Azure Blueprints also has templates that you can use to create, deploy, and update fully governed cloud environments that meet and comply with regulatory requirements and standards. It differs from Azure Resource Manager and Azure Policy because it's a package that has different artifact types. Artifacts include:

- Azure Resource Manager templates

- Resource groups

- Policy assignments

- Role assignments

Azure Blueprints packages these artifacts in one container, which you can deploy them in a repeatable configuration. You can use its built-in blueprints or create your custom ones.

> [!NOTE]
> You can create blueprints in the Azure portal or by using the REST API with tools such as PowerShell or the Azure portal. If you use the REST API, you can define blueprint parameters that help prevent conflicts if you reuse blueprints.

## Data protection in Azure

You can use Azure to encrypt data and manage keys. Azure uses four specific methods to help safeguard your customer data for applications, platform, system, and storage. These methods are data segregation, data encryption, data redundancy, and data destruction.

### Data segregation

Azure is a multitenant service that uses logical isolation to segregate data storage and processing. This helps ensure that a customer's data isn't combined with other customers' information.

### Data encryption

<!--ID/SME Please review for technical accuracy. --> You can help protect your data confidentiality and integrity by encrypting data in storage (at rest) and in transit. Some Azure services enable you to decide between Microsoft-managed or customer-managed encryption keys. Azure supports various encryption models, including client-side and server-side encryption. For data at rest, Azure offers several flexible encryption capabilities from which you can choose.

#### Azure Disk Encryption and Azure Key Vault

Azure Disk Encryption uses the industry-standard BitLocker feature of Windows and the DM-Crypt feature of Linux. These technologies provide volume encryption for operating-system and data disks. Transparent data encryption helps protect Azure SQL databases. Azure Key Vault helps you easily and cost-effectively streamline key management. It enables you to maintain control of data-encryption keys that cloud applications and services use. Encryption at rest with Azure Site Recovery supports Storage Service Encryption.

### Protocols

<!--ID/SME Please review for technical accuracy. Acrolinx really wanted this paragraph to have more simple, short sentences and less technical verbiage. I took my best shot.-->Azure uses industry-standard transport protocols for in-transit data. These protocols include TLS 1.2+ between devices and Microsoft datacenters, and within datacenters. You can enable encryption for traffic between your VMs and users. Use Server Message Block (SMB) 3.0 in VMs that are running Windows Server 2012 or newer to encrypt in-transit data. This encryption occurs over Azure virtual networks, helping secure data transfers. Administrators can enable SMB encryption for an entire server or specific shares. You can use Secure Shell (SSH) to connect to Linux VMs that are running in Azure. SSH is an encrypted connection protocol that allows you to sign in securely over an unsecured connection.

#### Azure VPN encryption

Azure VPN encryption creates a secure, encrypted tunnel that helps protect data's privacy when it's sent across a network. Site-to-site VPNs use IPsec for transport encryption. You can configure Azure VPN Gateway to use a custom IPsec/Internet Key Exchange policy with specific cryptographic algorithms and key strengths. Point-to-site VPNs use Secure Socket Tunneling Protocol to create a VPN tunnel. This tunnel allows individual client computers access to an Azure virtual network.

### Data redundancy

You can opt for in-country/region storage for compliance or latency considerations. Conversely, you can use out-of-country/region storage for security or disaster-recovery purposes. Data might replicate, for redundancy, within a selected geographic area. Data in your Azure Storage account always replicate to ensure durability and high availability. Replication options include:

- Locally redundant storage

- Zone-redundant storage

- Geo-redundant storage

- Read-access geo-redundant storage

#### Azure Defender for Storage

Azure Defender for Storage provides a security-intelligence layer that detects unusual and potentially harmful attempts to access or exploit storage accounts. This protection layer enables you to address threats without having to be a security expert or manage security-monitoring systems. Activity anomalies trigger security alerts that integrate with Azure Security Center. They're also sent through email to subscription administrators. The alerts contain details about suspicious activity and recommendations about how to investigate and remediate threats.

#### Azure Defender for SQL Database

Azure Defender for SQL Database is part of an advanced data-security offering. This unified package provides advanced Azure SQL security capabilities. It detects anomalous activities that indicate unusual and potentially harmful attempts to access or exploit databases. This new security layer also enables customers to detect and respond to potential threats by providing security alerts on anomalous activities.

### Data destruction

When you delete data or leave the Azure service, Microsoft follows industry-standard processes for overwriting storage resources before reuse. This includes following the National Institute of Standards and Technology Special Publication 800-88 guidelines for media sanitization.
