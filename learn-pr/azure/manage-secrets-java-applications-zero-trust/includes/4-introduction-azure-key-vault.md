Azure Key Vault is a Secrets store provided by
Azure. It's integrated with all major Azure services, making it easy to manage secrets with Azure
App Services, Azure Kubernetes Services, or Azure Spring Apps.

## Using Azure Key Vault to enhance data protection and compliance

Azure Key Vault can encrypt keys and secrets in hardware security modules (HSMs). With Key Vault, Microsoft doesn’t see or extract your keys. You can monitor and audit your key use with Azure logging for more analysis and threat detection.

## Azure Key Vault provides fine-grained control of who accesses your secrets

You keep control over your keys: you grant permission for your applications to use those keys as needed. Applications never have direct access to the keys. Developers manage keys used for development and testing, and seamlessly migrate to production the keys that are managed by security operations.

## Use Azure Key Vault to manage SSL/TLS certificates

Azure Key Vault simplifies and automates tasks related to SSL/TLS certificates. Key Vault enables you to enroll and automatically renew certificates from supported public Certificate Authorities.

## Azure Key Vault is integrated into major Azure Services, and comes with a complete SDK

All major Azure services are integrated with Azure Key Vault: as you'll experience in the next unit,
the Azure CLI can be used to grant an application access to secrets.

Those secrets are then available using the Azure Key Vault SDK, which is available for all major
languages, including Java.

If you're a Spring developer, the Azure Key Vault Spring Boot Starter will make your life even easier.
Using this starter, secrets will be automatically available in a Spring Boot application as
configuration properties.
