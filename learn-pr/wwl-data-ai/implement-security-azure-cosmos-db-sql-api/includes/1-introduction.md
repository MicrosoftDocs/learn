Data security is a shared responsibility between you and your database provider. On the client side you should keep your servers patches up to date, use HTTPS/TLS encryption and make sure your administrative accounts have strong passwords. On the cloud side, Azure Cosmos DB fulfills a large set of security requirements to secure your data. Let's take a quick look at how Azure Cosmos DB secures your data. Later in this module, we will cover some of these requirements in more detail.

| **Security Requirements** | **Azure Cosmos DB's security approach** |
| :--- | :--- |
| Network security | Azure Cosmos DB supports policy driven IP-based access controls for inbound firewall support. Azure Cosmos DB alloys you to enable a combination of IPs and IP ranges. Only machines with the proper IPs or inside the IP ranges can access the Azure Cosmos DB resources, all other machines are blocked by Azure Cosmos DB. |
| Authorization | Azure Cosmos DB uses hash-based message authentication code (HMAC) for authorization. You can use either a primary key, or a resource token allowing fine-grained access to a resource such as a document. |
| Users and permissions | Using the primary key for the account, you can create user resources and permission resources per database.  The resource token is then used during authentication to provide or deny access to the resource. |
| Active Directory integration (Azure RBAC) | You can also provide or restrict access to the Cosmos account, database, container, and offers (throughput) using Access control (IAM) in the Azure portal. IAM provides role-based access control and integrates with Active Directory. You can use built in roles or custom roles for individuals and groups. |
| Global replication | In the context of security, global replication ensures data protection against regional failures. |
| Regional failovers | If you have replicated your data in more than one data center, Azure Cosmos DB automatically rolls over your operations should a regional data center go offline. |
| Local replication | Even within a single data center, Azure Cosmos DB automatically replicates data for high availability giving you the choice of consistency levels. |
| Restore deleted data | The automated online backups can be used to recover data you may have accidentally deleted up to ~30 days after the event. |
| Protect and isolate sensitive data | Documents and backups are now encrypted at rest. Personal data and other confidential data can be isolated to specific containers, and read-write or read-only access can be limited to specific users. |
| Monitor for attacks | By using audit logging and activity logs, you can monitor your account for normal and abnormal activity. |
| Respond to attacks | Once you have contacted Azure support to report a potential attack, a 5-step incident response process is kicked off to restore normal service security and operations as quickly as possible after an issue is detected and an investigation is started. |
| Geo-fencing | Azure Cosmos DB ensures data governance for sovereign regions (for example, Germany, China, US Gov). |
| Protected facilities | Data in Azure Cosmos DB is stored on SSDs in Azure's protected data centers. |
| HTTPS/SSL/TLS encryption | All connections to Azure Cosmos DB support HTTPS. Azure Cosmos DB also supports TLS 1.2. |
| Encryption at rest | All data stored into Azure Cosmos DB is encrypted at rest. |
| Patched servers | As a managed database, Azure Cosmos DB eliminates the need to manage and patch servers. That's done for you automatically. |
| Administrative accounts with strong passwords | Security via TLS and HMAC secret based authentication is baked in by default. |

After completing this module, you'll be able to:

- Implement network level access control
- Review data encryption options
- Use role-based access control (RBAC)
- Access Account Resources using Microsoft Entra ID
- Understand Always Encrypted
