Azure Database for PostgreSQL uses multiple layers of security to protect data. These layers include:

- Data encryption
- Network security
- Access management

## Data encryption

Azure Database for PostgreSQL encrypts data in transit and at rest. This topic is discussed in Unit 5.

## Network security

Azure Database for PostgreSQL flexible server provides two networking options:

- **Private access**. You create your server in an Azure virtual network with private network communication and using private IP addresses. Security rules in network security groups enable you to filter the type of network traffic that can flow in and out of virtual network subnets and network interfaces.
- **Public access**. The server can be accessed through a public endpoint with a publicly resolvable DNS (Domain Name System) address. A firewall blocks all access by default. You can create IP firewall rules to grant access to servers based on the originating IP address of each request.

> [!NOTE]
> When you create an Azure Database for PostgreSQL flexible server you select either Private access or Public access. Once your server has been created, you cannot change your network option.

Both options control access at the server level, not at the database or table level. Use PostgreSQL roles to grant or deny access to database, table, and other objects.

You also manage access to the server by creating firewall rules to allow connections only from known IP address ranges.

## Access management

When you create an Azure Database for PostgreSQL server, you also create an admin account. This administrator account can be used to create more [PostgreSQL roles](https://www.postgresql.org/docs/current/user-manag.html). A role is a database user or group of users. Access to an Azure Database for PostgreSQL server is authenticated with a username, password, and the permissions granted or denied to the role.

### SCRAM authentication

Most access to an Azure Database for PostgreSQL server relies on passwords. However, it's possible to use SCRAM authentication, a secure password authentication protocol that can authenticate the client without revealing the user's cleartext password to the server. Salted Challenge Response Authentication Mechanism (SCRAM) is designed to make man-in-the-middle attacks more difficult. To enable SCRAM authentication:

1. In the Azure portal, navigate to your Azure Database for PostgreSQL flexible server, and under **Settings**, select **Server parameters**.
1. In the search bar, enter **password_encryption**. The two parameters listed both default to MD5. If you want to use SCRAM, change both parameters to SCRAM-SHA-256:
    1. **password_encryption**
    1. **azure.accepted_password_auth_method**

    You must then **Save** changes.
