We all hear news about data breaches. Securing data is as important today as it always has been. Azure's cloud databases provide essential features to keep your data secure. While these features are an important aspect to security, the responsibility falls to everyone involved in capturing and managing data to keep it safe.

Let's take a brief look at some of the features Azure's database infrastructure provides. Many of these are available "out of the box" and require minimal setup from the customer.

## IP firewall

A firewall is an initial line of defense. A firewall only allows certain trusted users or systems to access the database. Azure Cosmos DB, for example, supports policy driven IP-based access controls for inbound firewall support. Customer set specific IP addresses (or a range of addresses) that can access the data and the firewall will reject requests from any other address. Azure SQL Server databases also are protected in the same way.

For example, if you have a web application on Azure that uses the database (and only the web app uses the database), you can set the IP address for that web address as the only trusted address.

## Authorization

Azure Cosmos DB uses a hash-based request authorization model for ensuring database requests are legitimate. Each request is hashed using a secret key and the hash is sent with the request. On the database side, Cosmos DB generates a hash from the request and compares it with the request hash. If they match, the request is authorized. This ensures that only owners of the secret key can generate valid database requests.

## Active Directory integration

You can set Active Directory roles and permissions using Azure's access control (IAM) to restrict access to the Cosmos account, database, and container. This may be familiar to anyone who uses Active Directory to secure access to on-premises resources and this tooling is available to your cloud set up as well. There are many built-in roles that administrators can use but customers can set up custom roles as well.

## Other security tools

This unit covered just a few of the services available that help secure data stored in Azure database offerings. On Cosmos DB, the following other features are available as well.

- Users and permissions (non-Active Directory)
- Global replication
- Regional failover
- Local replication
- Automated online backups
- Restore deleted data
- Protect and isolate sensitive data
- Monitor for attacks
- Respond to attacks
- Geo-fencing
- Protected facilities
- HTTPS/SSL/TLS encryption
- Encryption at rest
- Patched servers
- Administrative accounts with strong passwords
- Security and data protection certifications
