As Contoso moves more data to the cloud, they want to be confident that they're not incurring security or compliance risks. They need a partner to help them protect their data as changes occur in their environment and business. Microsoft can provide tools, services, and plans to help Contoso meet their data privacy compliance and data protection goals.

Microsoft undergoes regular audits and submits self-assessments to third-party auditors for its cloud services such as Microsoft Azure, Microsoft 365, and Microsoft Dynamics 365. This process helps Microsoft ensure that it meets all security and compliance requirements applicable to its role as cloud service provider.

Microsoft also proactively collaborates with industry leaders and government bodies around the world to anticipate future compliance requirements that might affect Microsoft or its customers. Microsoft is often the first global cloud service provider to adopt new frameworks and standards.

## Microsoft compliance resources

Global regulatory bodies frequently update their laws and rules, and it can be difficult for organizations to determine how the changes apply to them. Compliance personnel must work diligently to help meet evolving requirements. Microsoft helps its customers stay up-to-date with compliance obligations by providing tools, guidance, and extensive documentation.

### Microsoft Trust Center

The [Microsoft Trust Center](https://www.microsoft.com/trust-center?azure-portal=true) offers detailed information about Microsoft's security, privacy, compliance, and transparency commitments for its cloud products and services. The Trust Center includes information about all current certifications, attestations, and other compliance offerings for Microsoft cloud services.

### Service Trust Portal

The [Service Trust Portal](https://servicetrust.microsoft.com?azure-portal=true) has extensive information about common industry standards and regulations like the GDPR. Audit reports, Azure Security Blueprints, and trust documents help you understand cloud features and compare technical compliance and control requirements against requirements. Extra guidance and tools help Azure and other Microsoft cloud service customers meet security, compliance, and privacy needs.

## Data protection in Azure

Azure uses data segregation, data encryption, data redundancy, and data destruction to help safeguard customer data in applications, platforms, systems, and storage.

### Data segregation

Azure is a multitenant service that uses logical isolation to segregate each customer's data from other customers' data. This segregation helps ensure that a customer's data isn't combined with other customers' data and isn't accessible by other customers.

### Data encryption

Azure offers a wide range of encryption capabilities and options for data encryption at rest and in transit. Azure supports various encryption models, including client-side and server-side encryption, and supports Microsoft-managed and customer-managed encryption keys. For data at rest, Azure offers several flexible encryption options.

- **Azure Disk Encryption** uses the industry-standard BitLocker feature for Windows or the DM-Crypt feature for Linux to provide volume encryption for operating system (OS) and data disks.
- **Transparent data encryption (TDE)** helps protect Azure SQL databases.
- **Azure Key Vault** helps you easily and cost-effectively streamline encryption key management by maintaining control of data encryption keys that cloud applications and services use.

### Communication protocols

Azure uses industry-standard transport protocols for in-transit data, including Transport-Layer Security (TLS) 1.2+ within Microsoft datacenters and between devices and datacenters. You can also enable encryption for traffic between virtual machines (VMs) and users.

For Windows Server 2012 or later VMs, you can help secure data transfers by using Server Message Block (SMB) 3.0 to encrypt data in transit over Azure virtual networks. Network administrators can enable SMB encryption for an entire server or specific shares. To connect to Linux VMs in Azure, you can use secure shell (SSH), an encrypted connection protocol that lets you sign in securely over an unsecured connection.

**Azure VPN encryption** creates a secure, encrypted tunnel that helps protect data sent across a network. Site-to-site VPNs use IPsec for transport encryption. You can configure Azure VPN Gateway to use a custom IPsec/Internet Key Exchange policy with specific cryptographic algorithms and key strengths. Point-to-site VPNs use Secure Socket Tunneling Protocol (SSTP) to create a VPN tunnel that allows individual client computers access to an Azure virtual network.

### Data redundancy

You can opt for in-country/region storage of your at-rest data to accommodate compliance or latency considerations. You can also use out-of-country/region storage for security or disaster-recovery purposes. For redundancy, you can replicate data multiple times within a selected geographic area. Data in an Azure Storage account is always replicated within the primary region to ensure durability and high availability. Primary and secondary region replication options include:

- Locally redundant storage
- Zone-redundant storage
- Geo-redundant storage
- Geo-zone-redundant storage
- Read-access geo-redundant storage and read-access geo-zone-redundant storage

### Data storage security

Azure has several services to help monitor data storage security, including Microsoft Defender for Storage and Microsoft Defender for SQL Database.

- **Microsoft Defender for Storage** provides a security-intelligence layer that detects unusual and potentially harmful attempts to access or exploit storage accounts. This protection layer helps you address threats without having to be a security expert or manage security monitoring systems. Microsoft Defender for Storage detects activity anomalies and triggers security alerts that integrate with Microsoft Defender for Cloud and are emailed to subscription administrators. The alerts contain details about the suspicious activity and recommendations about how to investigate and remediate threats.

- **Microsoft Defender for SQL** is part of a unified data-security package that provides advanced Azure SQL security capabilities. Microsoft Defender for SQL detects and provides alerts on anomalous activities that could indicate unusual and potentially harmful attempts to access or exploit databases. These alerts enable customers to detect and respond to potential threats.

### Data destruction

When you delete data or leave Azure, Microsoft follows industry-standard processes for overwriting storage resources before reuse. Microsoft also follows the National Institute of Standards and Technology Special Publication 800-88 guidelines when destroying storage media.
