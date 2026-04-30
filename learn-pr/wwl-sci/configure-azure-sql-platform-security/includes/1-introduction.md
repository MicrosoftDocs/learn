Contoso Financial Services is deploying a cloud-native banking platform that uses Azure SQL Database for transaction processing and SQL Managed Instance for a credit risk assessment system. AI fraud detection service queries live transaction data using automated access. As the cloud security engineer, you need to secure both database services to meet financial regulatory requirements and protect sensitive customer data.

The current configuration has four critical security gaps. Both databases allow SQL authentication with shared passwords, including credentials used by the AI service. The SQL servers have public endpoints accessible from the internet with only basic firewall protection. Transparent data encryption uses service-managed keys, but regulators require customer-managed keys for financial personal data. Query results expose full account numbers and credit card data to all database users regardless of their role.

:::image type="content" source="../media/contoso-scenario-architecture.png" alt-text="Architecture diagram of Contoso Financial Services Azure SQL deployment with four security gaps: SQL passwords, public endpoints, service-managed Transparent Data Encryption (TDE) keys, and unmasked personal data." lightbox="../media/contoso-scenario-architecture.png":::

In this module, you configure Microsoft Entra to provide authentication and replace SQL credentials with managed identities for AI workloads. You deploy private endpoints to eliminate public internet access and isolate databases within Azure virtual networks. You enable transparent data encryption with customer-managed keys stored in Azure Key Vault and evaluate Always Encrypted for more protection. You apply dynamic data masking and row-level security to restrict access to sensitive data based on user roles.

By the end of this module, you can:

- Configure Microsoft Entra ID authentication and disable SQL authentication on Azure SQL
- Implement network isolation for Azure SQL using private endpoints and firewall rules
- Enable transparent data encryption and configure customer-managed keys for regulated workloads
- Apply dynamic data masking and row-level security to restrict access to sensitive data
