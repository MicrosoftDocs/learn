As Tailwind Traders builds its workloads in the cloud, it needs to carefully handle sensitive information such as passwords, encryption keys, and certificates. This information needs to be available for an application to function, but it might allow an unauthorized person access to application data.

[Azure Key Vault](https://azure.microsoft.com/services/key-vault?azure-portal=true) is a centralized cloud service for storing an application's secrets in a single, central location. It provides secure access to sensitive information by providing access control and logging capabilities.

## What can Azure Key Vault do?

Azure Key Vault can help you:

+ **Manage secrets**

    You can use Key Vault to securely store and tightly control access to tokens, passwords, certificates, API keys, and other secrets.
+ **Manage encryption keys**

    You can use Key Vault as a key management solution. Key Vault makes it easier to create and control the encryption keys that are used to encrypt your data.
+ **Manage SSL/TLS certificates**

    Key Vault enables you to provision, manage, and deploy your public and private Secure Sockets Layer / Transport Layer Security (SSL/TLS) certificates for both your Azure resources and your internal resources.
+ **Store secrets backed by hardware security modules (HSMs)**

    These secrets and keys can be protected either by software or by FIPS 140-2 Level 2 validated HSMs.

Here's an example that shows a certificate used for testing in Key Vault.

:::image type="content" source="../media/4-key-vault-certificates.png" alt-text="A screenshot of the Azure portal showing a test certificate in Azure Key Vault.":::

You'll add a secret to Key Vault later in this module.

## What are the benefits of Azure Key Vault?

The benefits of using Key Vault include:

+ **Centralized application secrets**

    Centralizing the storage for your application secrets enables you to control their distribution and reduces the chances that secrets are accidentally leaked.
+ **Securely stored secrets and keys**

    Azure uses industry-standard algorithms, key lengths, and HSMs. Access to Key Vault requires proper authentication and authorization.
+ **Access monitoring and access control**

    By using Key Vault, you can monitor and control access to your application secrets.
+ **Simplified administration of application secrets**

    Key Vault makes it easier to enroll and renew certificates from public certificate authorities (CAs). You can also scale up and replicate content within regions and use standard certificate management tools.
+ **Integration with other Azure services**

    You can integrate Key Vault with storage accounts, container registries, event hubs, and many more Azure services. These services can then securely reference the secrets stored in Key Vault.
