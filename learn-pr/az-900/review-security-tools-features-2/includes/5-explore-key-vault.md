[Azure Key Vault](https://azure.microsoft.com/services/key-vault?azure-portal=true) is a centralized cloud service for storing your applications' secrets. Key Vault helps you control your applications' secrets by keeping them in a single, central location and by providing secure access, permissions control, and access logging capabilities.


![Key vault icon.](../media/icon-key-vault.png)

**Usage scenarios**

+ **Secrets management**. You can use Key Vault to securely store and tightly control access to tokens, passwords, certificates, *Application Programming Interface* (API) keys, and other secrets.
+ **Key management**. You also can use Key Vault as a key management solution. Key Vault makes it easier to create and control the encryption keys used to encrypt your data.
+ **Certificate management**. Key Vault lets you provision, manage, and deploy your public and private *Secure Sockets Layer/ Transport Layer Security* (SSL/ TLS) certificates for your Azure, and internally connected, resources more easily.
+ **Store secrets backed by hardware security modules** (HSMs). The secrets and keys can be protected either by software, or by FIPS 140-2 Level 2 validated HSMs.


**Key Vault benefits**

The benefits of using Key Vault include:

+ **Centralized application secrets**. Centralizing storage for application secrets allows you to control their distribution and reduces the chances that secrets may be accidentally leaked.
+ **Securely stored secrets and keys**. Azure uses industry-standard algorithms, key lengths, and HSMs, and access requires proper authentication and authorization.
+ **Monitor access and use**. Using Key Vault, you can monitor and control access to company secrets.
+ **Simplified administration of application secrets**. Key Vault makes it easier to enroll and renew certificates from public Certificate Authorities (CAs). You can also scale up and replicate content within regions and use standard certificate management tools.
+ **Integrate with other Azure services**. You can integrate Key Vault with storage accounts, container registries, event hubs and many more Azure services.

To go deeper on Azure Key Vault, take a look at -- [Configure and Manage Secrets in Azure Key Vault](https://docs.microsoft.com/learn/modules/configure-and-manage-azure-key-vault?azure-portal=true).
