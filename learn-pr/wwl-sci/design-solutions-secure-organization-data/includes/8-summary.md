In this module, you learned how to design comprehensive security solutions for an organization's data assets. You explored key concepts and Microsoft technologies that help protect data across its lifecycle.

## Key takeaways

### Data discovery, classification, and threat prioritization

- Design classification taxonomies aligned with data sensitivity requirements using sensitivity labels and information types
- Implement Microsoft Purview for unified data governance across hybrid and multicloud estates
- Apply MCSB controls DP-1 (Discover, classify, and label sensitive data) and DP-2 (Monitor anomalies and threats)
- Prioritize threat mitigation based on data sensitivity and business impact

### Data protection and encryption

- Design encryption strategies for data at rest using TDE, CMK, and infrastructure encryption
- Implement encryption in transit with TLS 1.2+ and secure protocols
- Manage cryptographic keys using Azure Key Vault with proper access policies and rotation
- Configure double encryption (infrastructure encryption) for regulated workloads

### Security for Azure data services

- Apply defense-in-depth across Azure SQL, Azure Synapse Analytics, Azure Cosmos DB, and Azure Storage
- Use Microsoft Entra authentication and RBAC for identity-based access control
- Implement network isolation with private endpoints and managed virtual networks
- Configure data protection features like Always Encrypted, row-level security, and immutable storage

### Threat detection with Microsoft Defender

- Deploy Microsoft Defender for Storage for activity monitoring and malware scanning
- Enable Microsoft Defender for Databases across SQL and NoSQL services
- Configure vulnerability assessments and advanced threat protection
- Integrate with Microsoft Sentinel for correlation and automated response

## Framework alignment

Throughout this module, you applied security best practices from:

- **Microsoft Cloud Security Benchmark (MCSB)**: Data protection controls DP-1 through DP-8
- **Cloud Adoption Framework (CAF)**: Secure methodology for data protection
- **Well-Architected Framework (WAF)**: Security pillar design principles
- **Microsoft Cybersecurity Reference Architecture (MCRA)**: Technical architecture patterns

## Learn more

- [Data protection in MCSB](/security/benchmark/azure/mcsb-data-protection)
- [Microsoft Purview documentation](/purview/)
- [Azure Key Vault documentation](/azure/key-vault/)
- [Microsoft Defender for Cloud documentation](/azure/defender-for-cloud/)
- [Azure SQL security documentation](/azure/azure-sql/database/security-overview)
- [Azure Storage security documentation](/azure/storage/common/storage-security-guide)
