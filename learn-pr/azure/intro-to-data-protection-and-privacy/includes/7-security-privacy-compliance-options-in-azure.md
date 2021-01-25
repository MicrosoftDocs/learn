As you move more data to the cloud, it's important to feel confident that you're not opening yourself up to security or compliance risks. You need a partner that can meet you where you are today and provide what you need as both your environment and business change.

## Microsoft’s commitment to compliance

Microsoft undergoes regular audits and submits self-assessments to third-party auditors to help ensure that it meets all the security and compliance advancements and requirements. Microsoft proactively collaborates with industry leaders and government bodies around the world to anticipate future compliance requirements. As a result, Microsoft is often the first global cloud service provider to adopt new frameworks and standards.

## Microsoft tools and services for compliance

Frequent updates to the laws and rules from the many regulatory bodies around the world create a challenge for organizations. Compliance personnel need assistance to help meet evolving requirements. Microsoft helps customers meet compliance obligations by providing an extensive repository of resources that include tools, documentation, and guidance.

### Microsoft Trust Center

The Microsoft Trust Center is your resource for learning how we implement and support security, privacy, compliance, and transparency in all Microsoft cloud products and services. The Trust Center features a comprehensive set of all current certifications, attestations, and other compliance offerings.

### Service Trust Center

The Service Trust Portal contains additional guidance and tools to help meet your security, compliance, and privacy needs when using Azure and other Microsoft cloud services. These audit reports, Azure Security Blueprints, and trust documents help you understand cloud features, and to verify technical compliance and control requirements.

### Azure Blueprints

Azure Blueprints is a free service that helps customers build Azure applications that are secure and comply with many regulations, including the GDPR and the Health Insurance Portability and Accountability Act, both internally and externally. Azure Blueprints also helps simplify large-scale Azure deployments by packaging key environment artifacts, such as Azure Resource Manager templates, resource groups, role-based access controls, and policies, in a single blueprint definition. This service provides you with templates to create, deploy, and update fully governed cloud environments to consistent standards and comply with regulatory requirements.

It differs from Azure Resource Manager and Azure Policy in that Azure Blueprints is a package that contains different types of artifacts. These artifacts include Azure Resource Manager templates, resource groups, policy assignments, and role assignments, all in one container, so you can quickly and easily deploy all these components in a repeatable configuration. You can use the built-in blueprints or create your own custom blueprints.

> [!NOTE]
> You can create blueprints in the Azure portal or by using the REST API with tools such as PowerShell or the Azure portal. If you use the REST API, you can define blueprint parameters to prevent conflicts when reusing certain blueprints.

## Data protection in Azure

You can use Azure to encrypt data and manage keys. Azure uses four specific methods to help safeguard your customer data for applications, platform, system, and storage. These methods are data segregation, data encryption, data redundancy, and data destruction.

### Data segregation

As a multitenant service, Azure uses logical isolation to segregate storage and processing for each customer to help ensure that your customer data is not combined with anyone else’s.

### Data encryption

Data in Azure is always encrypted. To align with the best practices for protecting the confidentiality and integrity of your data, you can encrypt data in storage (at rest) and in transit. For some Azure services, you can decide between Microsoft-managed or customer-managed keys for encryption. Azure supports various encryption models, including both client-side and server-side encryption. For data at rest, Azure offers a wide range of encryption capabilities, giving you the flexibility to choose the solution that best meets your needs.

#### Azure Disk Encryption and Azure Key Vault

Azure Disk Encryption uses the industry-standard BitLocker feature of Windows and the DM-Crypt feature of Linux to provide volume encryption for the operating system and data disks. Transparent data encryption helps protect Azure SQL databases. Azure Key Vault helps you easily and cost-effectively streamline key management and maintain control of the keys that cloud applications and services use to encrypt data. Encryption at rest with Azure Site Recovery supports Storage Service Encryption.

### Protocols

For data in transit, Azure uses industry-standard transport protocols such as TLS 1.2+ between devices and Microsoft datacenters, and within datacenters themselves. You can enable encryption for traffic between your own VMs and end users. You can use Server Message Block (SMB) 3.0 in VMs that are running Windows Server 2012 or later to encrypt data in transit over Azure virtual networks and help secure data transfers. Administrators can enable SMB encryption for the entire server or just specific shares. You can use Secure Shell (SSH) to connect to Linux VMs running in Azure. SSH is an encrypted connection protocol that allows secure sign-ins over unsecured connections.

#### Azure VPN encryption

Azure VPN encryption creates a secure, encrypted tunnel to protect the privacy of data sent across the network. Site-to-site VPNs use IPsec for transport encryption. You can configure Azure VPN Gateway to use a custom IPsec/Internet Key Exchange policy with specific cryptographic algorithms and key strengths. Point-to-site VPNs use Secure Socket Tunneling Protocol to create the VPN tunnel that allows individual client computers access to an Azure virtual network.

### Data redundancy

You can opt for in-country/region storage for compliance or latency considerations or out-of-country/region storage for security or disaster recovery purposes. Data might be replicated within a selected geographic area for redundancy. Data in your Azure Storage account is always replicated to ensure durability and high availability. You can choose from the following replication options:

- Locally redundant storage

- Zone-redundant storage

- Geo-redundant storage

- Read-access geo-redundant storage

#### Azure Defender for Storage

Azure Defender for Storage provides an additional layer of security intelligence that detects unusual and potentially harmful attempts to access or exploit storage accounts. This layer of protection enables you to address threats without the need to be a security expert or manage security monitoring systems. Security alerts are triggered when anomalies in activity occur. These security alerts are integrated with Azure Security Center and are also sent through email to subscription administrators. The alerts contain details of suspicious activity and recommendations on how to investigate and remediate threats.

#### Azure Defender for SQL Database

Azure Defender for SQL Database is part of the advanced data security offering, which is a unified package for advanced Azure SQL security capabilities. It detects anomalous activities indicating unusual and potentially harmful attempts to access or exploit databases. This provides a new layer of security, which enables customers to detect and respond to potential threats as they occur, by providing security alerts on anomalous activities.

### Data destruction

When you delete data or leave the Azure service, Microsoft follows industry-standard processes for overwriting storage resources before reuse, including following the National Institute of Standards and Technology Special Publication 800-88 guidelines for media sanitization.
