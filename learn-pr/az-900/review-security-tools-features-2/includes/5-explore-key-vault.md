As Tailwind Traders builds their workloads in the cloud, sensitive information such as passwords, encryption keys, and certificates need to be handled carefully. This information needs to be available for an application to function, but could allow an unauthorized person access to your application data.

[Azure Key Vault](https://azure.microsoft.com/services/key-vault?azure-portal=true) is a centralized cloud service for storing your applications' secrets in a single, central location. It provides secure access to sensitive information by providing access control and logging capabilities.

## What can Azure Key Vault do?

Azure Key Vault can help you:

+ **Manage secrets**

    You can use Key Vault to securely store and tightly control access to tokens, passwords, certificates, API keys, and other secrets.
+ **Manage encryption keys**

    You can use Key Vault as a key management solution. Key Vault makes it easier to create and control the encryption keys that are used to encrypt your data.
+ **Manage SSL/TLS certificates**

    Key Vault enables you to provision, manage, and deploy your public and private Secure Sockets Layer / Transport Layer Security (SSL/TLS) certificates for both your Azure resources and for your internal resources.
+ **Store secrets backed by hardware security modules (HSMs)**

    These secrets and keys can be protected either by software or by FIPS 140-2 Level 2 validated HSMs.

:::image type="content" source="../media/5-key-vault-certificates.png" alt-text="Azure security center dashboard showing policy compliance, resource security hygiene and threat protection.":::
<div style="background:yellow;">
TODO: replace image - too big?

(Tom) It is indeed. Plus, what are we showing specifically here? Something from the last bullet, or something more general?
</div>

## What are the benefits of Azure Key Vault?

The benefits of using Key Vault include:

+ **Centralized application secrets**

    Centralizing the storage for your application secrets enables you to control their distribution and reduces the chances that secrets are accidentally leaked.
+ **Securely stored secrets and keys**

    Azure uses industry-standard algorithms, key lengths, and HSMs. Access to Key Vault requires proper authentication and authorization.
+ **Access monitoring and access control**

    By using Key Vault, you can monitor and control access to your application secrets.
+ **Simplified administration of application secrets**

    Key Vault makes it easier to enroll and renew certificates from public Certificate Authorities (CAs). You can also scale up and replicate content within regions and use standard certificate management tools.
+ **Integration with other Azure services**

    You can integrate Key Vault with storage accounts, container registries, event hubs and many more Azure services. These services can then securely reference the secrets stored in the Key Vault.
