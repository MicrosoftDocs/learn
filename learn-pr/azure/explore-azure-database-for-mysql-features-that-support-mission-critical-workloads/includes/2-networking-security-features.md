Azure Database for MySQL - Flexible Server provides several features that are designed to protect and secure your data and operations. Let's look at each of these features.

## Networking

Azure Database for MySQL – Flexible Server provides robust firewall settings to protect database connectivity for public access as well as Azure Virtual Networks (VNets). There are three settings for the MySQL flexible server connection: public access, private access, and a private link. In all cases, connections must still authenticate with the server.

**Public access** provides a publicly resolvable DNS address accessible over the Internet by an allowed list of IP addresses address ranges. By default, no IP addresses are allowed. You can add IP addresses during or after creation. You can also allow access from any Azure IP address (including other customer subscriptions in other regions).

**Private access** uses a delegated subnet to host MySQL flexible servers and provides a DNS address resolvable from within its VNet or a peered VNet. This locks down database access to just your virtual networking infrastructure. You can set up Network Security Group (NSG) firewall rules to filter network traffic more precisely. You can use private access to securely connect to a MySQL flexible server from within the same VNet, from a different VNet using peering, or even from on-premises using an ExpressRoute or VPN connection.

**Private link** provides a private IP address endpoint within a VNet subnet to connect to the MySQL flexible server directly. Azure Private Link essentially brings Azure services inside your private VNet via an IP address like any other VNet resource. You can create several private endpoints, for example one per connecting application or Azure PaaS resource. Combined with NSG firewall rules, private links provide fine-grained control over which services can access the database.

## Microsoft Defender for Cloud

Microsoft Defender for Cloud monitors your database for unusual and potentially harmful activities. Defender for Cloud is provided as an addon plan to address potential threats without needing to build or manage security monitoring. Defender for Cloud has multi-cloud availability on Azure Database for MySQL - Flexible Server, in addition to MySQL on AWS Aurora and RDS. Defender for Cloud also supports PostgreSQL and MariaDB.

Defender for Cloud sends detection alerts to the Azure portal and over email. Alerts include:

- Details of the suspicious activity.

- The associated MITRE ATT&CK (Adversarial Tactics, Techniques, and Common Knowledge).

- Suggestions to investigate and mitigate the attack.

- More options to investigate with Microsoft Sentinel.

Defender for Cloud detects database threats such as:

- Brute force attacks: abnormally high login failures, and successful login after many failures.

- Unusual login patterns: if a user logs in for the first time in over two months.

- Unusual login locations: if a user logs in from an unusual Azure database, or other cloud provider, or an IP flagged as suspicious.

## Authentication

Azure Database for MySQL offers two modes of authentication: MySQL authentication (username/password) and Microsoft Entra ID authentication. You can enable both at the same time.

Microsoft Entra ID authentication enables identity-based authentication to the MySQL flexible server using identities provided by Microsoft Entra ID. This centralizes user management for the database and other Microsoft services.

By default, a MySQL flexible server is set to use MySQL authentication only (username/password). You can change this setting to use Microsoft Entra ID authentication only (no database users) or combine managed identities with MySQL authentication.

When you use Microsoft Entra ID authentication, there are two administrator accounts: the original MySQL administrator and the Microsoft Entra ID administrator. The Microsoft Entra ID administrator can be either a user or a user group. If the administrator is a group, then any member of the group can manage Microsoft Entra ID authentication. Administrator groups are easier to manage because it centralizes user management in Microsoft Entra ID rather than having to update MySQL users or permissions directly. You can only configure one Microsoft Entra ID administrator, whether it be a single user or a single user group.

The following diagram shows the two modes to manage authentication.

:::image type="content" source="../media/2-networking-security-features/azure-postgres-flexible-server-authentication-mechanisms.png" alt-text="Diagram showing how MySQL Admins and Microsoft Entra Admins for MySQL can create users and manage Azure Database for MySQL - Flexible Server." lightbox="../media/2-networking-security-features/azure-postgres-flexible-server-authentication-mechanisms.png":::

When users or applications attempt to connect to a MySQL flexible server using a Microsoft Entra identity, a token is issued to allow for login. The identity is associated with a database user via their unique Microsoft Entra user ID, rather than their name or other attributes.

## Data encryption

MySQL flexible servers encrypt data in transit. By default, servers require connecting with Transport Layer Security (TLS) 1.2 and deny unencrypted connections or connections using the deprecated TLS 1.0 and 1.1 protocols. You can disable encrypted connections (mightbe a legacy application doesn't support encryption), or allow versions before 1.2, or use TLS 1.3 which is the recommended setting for new application development.

By default, Azure Database for MySQL - Flexible Server encrypts data at rest (including backup and temporary files created while running queries) using a symmetric AES 256-bit data encryption key (DEK). With customer-managed keys (CMK), you can bring your own key (BYOK) to add another layer of encryption by encrypting the service's DEK.

BYOK gives you full control of data encryption and key lifecycle: creation, uploading, rotation, and deletion. Managing the key lifecycle lets you align key rotation with company policies and enables separation of security team, DBA, and system administrator responsibilities.

Enabling CMK requires linking a database to a user-assigned managed identity (UMI) and then specifying the key, which is stored in Azure Key Vault, to use. If you create a copy of the server, the copy will be encrypted, and you can also add managed identities and keys to existing replicas.

To support this scenario, your MySQL flexible server and Azure Key Vault must be in the same:

- Microsoft Entra ID tenant. If you move resources in Key Vault, then you'll need to reconfigure data encryption.

- Region.

If the MySQL flexible server loses access to the CMK in the key vault and a related error message is displayed, then within 10 minutes the MySQL flexible server will begin denying new connections and the server state will shift to Inaccessible.
