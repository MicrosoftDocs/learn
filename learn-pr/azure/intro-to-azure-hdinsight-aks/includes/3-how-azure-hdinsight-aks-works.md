Enterprise readiness for any software requires stringent security checks to prevent and address threats that may arise. HDInsight on AKS provides a multi-layered security model to protect you on multiple layers. The security architecture uses modern authorization methods using MSI. All the storage access is through MSI, and the database access is through username/password. The password is stored in Azure Key Vault, defined by the customer. This makes the setup robust and secure by default.

The below diagram illustrates a high-level technical architecture of security in HDInsight on AKS.

:::image type="content" source="../media/security-concept.png" alt-text="Screenshot showing the security flow of authenticating a cluster." border="true" lightbox="../media/security-concept.png":::

Security is to divided into four main groups based on the type of control. These groups are also called security pillars and are of the following types: 
- Perimeter security
- Authentication
- Authorization
- Encryption

## Perimeter security

Perimeter security in HDInsight on AKS is achieved through virtual networks. An enterprise admin can create a cluster inside a virtual network (VNET) and use network security groups (NSG) to restrict access to the virtual network.

## Authentication

HDInsight on AKS provides Microsoft Entra ID-based authentication for cluster login and uses managed identities (MSI) to secure cluster access to files in Azure Data Lake Storage Gen2. Managed identity is a feature of Microsoft Entra ID that provides Azure services with a set of automatically managed credentials. With this setup, enterprise employees can sign into the cluster nodes by using their domain credentials. A managed identity from Microsoft Entra ID allows your app to easily access other Microsoft Entra protected resources such as Azure Key Vault, Storage, SQL Server, and Database. The identity managed by the Azure platform and doesn't require you to provision or rotate any secrets. This solution is a key for securing access to your HDInsight on AKS cluster and other dependent resources. Managed identities make your app more secure by eliminating secrets from your app, such as credentials in the connection strings.

You create a user-assigned managed identity, which is a standalone Azure resource, as part of the cluster creation process, which manages the access to your dependent resources.

## Authorization

A best practice most enterprises follow is making sure that not every employee has full access to all enterprise resources. Likewise, the admin can define role-based access control policies for the cluster resources.

The resource owners can configure role-based access control (RBAC). Configuring RBAC policies allows you to associate permissions with a role in the organization. This layer of abstraction makes it easier to ensure people have only the permissions needed to perform their work responsibilities. Authorization managed by ARM roles for cluster management (control plane) and cluster data access (data plane) managed by cluster access management.

## Encryption

Protecting data is important for meeting organizational security and compliance requirements. Along with restricting access to data from unauthorized employees, you should encrypt it. The storage and the disks (OS disk and persistent data disk) used by the cluster nodes and containers are encrypted. Data in Azure Storage is encrypted and decrypted transparently using 256-bit AES encryption, one of the strongest block ciphers available, and is FIPS 140-2 compliant. Azure Storage encryption is enabled for all storage accounts, which makes data secure by default, you don't need to modify your code or applications to take advantage of Azure Storage encryption. Encryption of data in transit is handled with TLS 1.2.
