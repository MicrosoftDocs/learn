As you move more data to the cloud, you want to feel confident that you're not inviting security or compliance risks. You need a partner that can work with you to help you protect your data as changes occur in your environment and business.

## Microsoft’s commitment to compliance

Microsoft undergoes regular audits and submits self-assessments to third-party auditors in connection with its cloud services such as Microsoft Azure, Microsoft 365 and Microsoft Dynamics 365. This process helps Microsoft ensure that it is meeting all security and compliance requirements applicable to Microsoft in its role as cloud service provider. In addition to regular audits, Microsoft proactively collaborates with industry leaders and government bodies around the world to anticipate future compliance requirements that may affect Microsoft or its customers. As a result, Microsoft is often the first global cloud service provider to adopt new frameworks and standards.

## Microsoft tools and services for compliance

Global regulatory bodies perform frequent updates to their laws and rules, and it is often difficult for organizations to keep up with the changes and how they apply to them. Their compliance personnel must work diligently to help meet evolving requirements. Microsoft helps its customers meet their own compliance obligations by providing an extensive resource repository that includes tools, documentation, and guidance.

### Microsoft Trust Center

The Microsoft Trust Center offers detailed information about Microsoft’s security, privacy, compliance, and transparency commitments for its cloud products and services. The Trust Center includes information about all current certifications, attestations, and other compliance offerings for the Microsoft cloud services.

### Service Trust Center

The Service Trust Portal has extra guidance and tools accessible for current Microsoft cloud services customers to help you meet your security, compliance, and privacy needs when using Azure and other Microsoft cloud services. Audit reports, Azure Security Blueprints, and trust documents can help you understand cloud features and compare technical compliance and control requirements against common industry standards and regulations.

## Data protection in Azure

You can use certain Azure services to encrypt data and manage encryption keys. Azure utilizes four specific methods to help safeguard your customer data for applications, platform, system, and storage. These methods are data segregation, data encryption, data redundancy, and data destruction.

### Data segregation

Azure is a multitenant service that uses logical isolation to segregate each customer’s data from the data of other customers. Such segregation helps ensure that a customer's data isn't combined with other customers' data and is not accessible by other customers.

### Data encryption

Azure offers a wide range of encryption capabilities and options for data encryption in storage (at rest) and data protection in transit. Azure supports various encryption models, including client-side and server-side encryption, and supports Microsoft-managed and customer-managed encryption keys. For data at rest, Azure offers several flexible encryption capabilities from which you can choose.

#### Azure Disk Encryption and Azure Key Vault

Azure Disk Encryption uses the industry-standard BitLocker feature of Windows and the DM-Crypt feature of Linux. These technologies provide volume encryption for operating-system and data disks. Transparent data encryption helps protect Azure SQL databases. Azure Key Vault helps you easily and cost-effectively streamline encryption key management. It enables you to maintain control of data encryption keys used by cloud applications and services.

### Protocols

Azure uses industry-standard transport protocols for in-transit data. These protocols include TLS 1.2+ between devices and Microsoft datacenters, and within datacenters. In addition, you can enable encryption for traffic between your VMs and users. For example, you can use Server Message Block (SMB) 3.0 in VMs that are running Windows Server 2012 or later to encrypt data in transit over Azure virtual networks, helping secure data transfers. Administrators can enable SMB encryption for an entire server or specific shares. You can use Secure Shell (SSH), an encrypted connection protocol that allows you to sign in securely over an unsecured connection, to connect to Linux VMs that are running in Azure.

#### Azure VPN encryption

Azure VPN encryption creates a secure, encrypted tunnel that helps protect data when it is sent across a network. Site-to-site VPNs use IPsec for transport encryption. You can configure Azure VPN Gateway to use a custom IPsec/Internet Key Exchange policy with specific cryptographic algorithms and key strengths. Point-to-site VPNs use Secure Socket Tunneling Protocol (SSTP) to create a VPN tunnel. This tunnel allows individual client computers access to an Azure virtual network.

### Data redundancy

You can opt for in-country/region storage of your at-rest data to accommodate compliance or latency considerations. Conversely, you can use out-of-country/region storage for security or disaster-recovery purposes. Data may be replicated, for redundancy, multiple times within a selected geographic area. Data in your Azure Storage account is always replicated within the primary region to ensure durability and high availability. Primary and secondary region replication options include:

- Locally redundant storage

- Zone-redundant storage

- Geo-redundant storage

- Geo-zone-redundant storage

- Read-access geo-redundant storage and read-access geo-zone-redundant storage

Azure has a number of services that you can use to help monitor data storage, including Azure Defender for Storage and Azure Defender for SQL Database.

#### Azure Defender for Storage

Azure Defender for Storage provides a security-intelligence layer that detects unusual and potentially harmful attempts to access or exploit storage accounts. This protection layer enables you to address threats without having to be a security expert or manage security-monitoring systems. Activity anomalies detected by Azure Defender for Storage trigger security alerts that integrate with Azure Security Center. These alerts are also sent through email to subscription administrators. The alerts contain details about suspicious activity and recommendations about how to investigate and remediate threats.

#### Azure Defender for SQL

Azure Defender for SQL is part of an advanced data-security offering. This unified package provides advanced Azure SQL security capabilities. It detects and provides alerts on anomalous activities that could indicate unusual and potentially harmful attempts to access or exploit databases., enabling customers to detect and respond to potential threats.

### Data destruction

When you delete data or leave the Azure service, Microsoft follows industry-standard processes for overwriting storage resources before reuse. In addition, Microsoft follows the National Institute of Standards and Technology Special Publication 800-88 guidelines when destroying storage media.
