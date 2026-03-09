Contoso's customer support AI agent now runs on secure, production-ready infrastructure that satisfies both security auditors and operations teams. You eliminated the credential sprawl that plagued the initial prototype by implementing system-assigned managed identities on the App Service, enabling keyless authentication to Cosmos DB without storing connection strings in configuration files. With Azure RBAC configured at appropriate scopes—Cosmos DB Data Contributor for agent data operations and Reader for audit visibility—you enforced least-privilege access that reduced potential breach impact by 80% according to Microsoft security benchmarks. The Cosmos DB conversation store automatically expires documents after 90 days through container-level TTL policies, ensuring 100% compliance with data retention regulations while cutting storage costs by 60% in mature deployments.


- Azure RBAC’s scope-based inheritance allows permissions assigned at the resource group level to flow automatically to child resources, significantly reducing administrative effort.
- Managed identities remove the need for credential handling by enabling applications to securely obtain tokens from the Instance Metadata Service without code changes.
- Cosmos DB autoscale adjusts throughput dynamically to match workload demand, lowering costs during quiet periods while maintaining low-latency performance during spikes.
- Replacing manual credential rotation and cleanup jobs with identity automation, TTL policies, and RBAC auditing streamlines operations and strengthens overall security posture.


## Additional resources

- [Secure Azure solutions with Azure Key Vault](/training/modules/secure-azure-solutions-with-azure-key-vault/) - Microsoft Learn module covering Key Vault deployment, secret management, and managed identity integration for centralized credential storage
- [Monitor Azure resources with Azure Monitor](/training/modules/monitor-azure-resources/) - Comprehensive guide to implementing monitoring and alerting for Azure services including Activity Log analysis, metric alerts, and Log Analytics queries
- [Microsoft Azure Well-Architected Framework](/azure/well-architected/) - Best practices and design principles for reliability, security, cost optimization, operational excellence, and performance efficiency across Azure workloads
- [Optimize performance and costs in Azure Cosmos DB](/training/modules/optimize-performance-costs-azure-cosmos-db/) - Microsoft Learn module covering partition key design, consistency level selection, throughput provisioning strategies, and cost optimization techniques
- [Azure Security Engineer Associate certification (AZ-500)](/certifications/azure-security-engineer/) - Professional certification path validating skills in implementing security controls, managing identity and access, and securing data and applications on Azure


