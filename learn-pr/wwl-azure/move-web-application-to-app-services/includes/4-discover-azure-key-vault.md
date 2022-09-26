Azure Key Vault is a cloud service for safeguarding encryption keys and application secrets for your cloud applications. Encrypting data both at rest and in transit is a must-do practice and storing keys securely but in a way that they can be easily used can be a challenge. Azure's Key Vault manages this work for you.

## Key Scenarios

Key Vault supports clear separation of duties so that a security officer can manage encryption keys, secrets, and certificates in one place while allowing application owners to use the certs in their applications. An auditor can get a complete log of activities for every key vault.

Logs can be piped into Azure Log Analytics for a rich dashboard to monitor the activities, use queries to analyze usage data, set alerts etc.

Here are some typical scenarios for keys and secrets which Key Vault can manage:

1. A security officer creates a key vault, chooses recovery options, and sets up logging, backup and the like.
2. The security officer injects secrets, keys, certificates into a key vault.
3. The office sets appropriate permissions to applications and user to manage.
4. App owners deploy their applications that consume these keys, secrets, and certificates.
5. An auditor gets full access logs to monitor the use of keys, secrets, and certs.
6. A security officer or designated delegate updates/rolls secrets and notifies apps.
7. Apps use updated secrets.
8. At an app's end of life, a security officer retires the secrets (revokes permissions, disable the keys, and then deletes them.)

## Secure Sockets Layer

Use the HTTPS protocol for web apps is pretty much a necessity as may essential web tools won't consume sites that don't use it. To use HTTPS, you need to have a site certificate. When you migrate your site to the cloud, you can use Key Vault to store your SSL certificate, and it becomes available to any app or site that needs to use it.