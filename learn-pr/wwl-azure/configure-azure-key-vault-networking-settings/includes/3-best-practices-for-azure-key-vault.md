Azure Key Vault safeguards encryption keys and secrets like certificates, connection strings, and passwords.

## Use separate key vaults

Our recommendation is to use a vault per application per environment (development, pre-production, and production), per region. Using separate key vaults helps you not share secrets across environments and regions. It will also reduce the threat in a breach.

## Why we recommend separate key vaults<br>

Key vaults define security boundaries for stored secrets. Grouping secrets into the same vault increases the blast radius of a security event because attacks might be able to access secrets across concerns. To mitigate access across concerns, consider what secrets a specific application should have access to, and then separate your key vaults based on this delineation. Separating key vaults by application is the most common boundary. Security boundaries, however, can be more granular for large applications, for example, per group of related services.

## Control access to your vault<br>

Encryption keys and secrets like certificates, connection strings, and passwords are sensitive and business critical. You need to secure access to your key vaults by allowing only authorized applications and users. Azure Key Vault security features provide an overview of the Key Vault access model. It explains authentication and authorization. It also describes how to secure access to your key vaults.

Suggestions for controlling access to your vault are as follows:<br>

 -  Lock down access to your subscription, resource group, and key vaults using role-based access control.<br>
 -  Create access policies for every vault.
 -  Use the principle of least privilege access to grant access.
 -  Turn on firewall and virtual network service endpoints.

## Turn on data protection for your vault

Turn on purge protection to guard against malicious or accidental deletion of the secrets and key vault even after soft-delete is turned on.

## Turn on logging<br>

Turn on logging for your vault. Also, set up alerts.

## Backup<br>

Purge protection prevents malicious and accidental deletion of vault objects for up to 90 days. In scenarios, when purge protection isn't a possible option, we recommend backup vault objects, which can't be recreated from other sources like encryption keys generated within the vault.

## Multitenant solutions and Key Vault<br>

A multitenant solution is built on an architecture where components are used to serve multiple customers or tenants. Multitenant solutions are often used to support software as a service (SaaS) solutions.
