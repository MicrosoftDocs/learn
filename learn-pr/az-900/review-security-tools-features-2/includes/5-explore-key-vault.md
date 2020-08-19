As Tailwind Traders builds and manages workload in the clouds, there are many application components that need to be handled carefully. Things like passwords, encryption keys and certificates need to be available for an application to function, but could allow an unauthorized person access to your application data, if obtained by the wrong hands.

![Key vault icon.](../media/icon-key-vault.png)
[Azure Key Vault](https://azure.microsoft.com/services/key-vault?azure-portal=true) is a centralized cloud service for storing your applications' secrets in a single, central location and by providing secure access to them, with permissions control and access logging capabilities.


**What can Azure Key Vault do?**

+ **Secrets management**. You can use Key Vault to securely store and tightly control access to tokens, passwords, certificates, *Application Programming Interface* (API) keys, and other secrets.
+ **Key management**. You also can use Key Vault as a key management solution. Key Vault makes it easier to create and control the encryption keys used to encrypt your data.
+ **Certificate management**. Key Vault lets you provision, manage, and deploy your public and private *Secure Sockets Layer/ Transport Layer Security* (SSL/ TLS) certificates for your Azure, and internally connected, resources more easily.
+ **Store secrets backed by hardware security modules** (HSMs). The secrets and keys can be protected either by software, or by FIPS 140-2 Level 2 validated HSMs.

:::image type="content" source="../media/key-vault-certificates.png" alt-text="Azure security center dashboard showing policy compliance, resource security hygiene and threat protection.":::
<div style="background:yellow;">
TODO: replace image - too big?
</div>


**What are the benefits of Azure Key Vault?**

<div style="background:yellow;">
TODO: re-write benefits with TWT scenario?
</div>
The benefits of using Key Vault include:

+ **Centralized application secrets**. Centralizing the storage for your application secrets allows you to control their distribution and reduces the chances that secrets may be accidentally leaked.
+ **Securely stored secrets and keys**. Azure uses industry-standard algorithms, key lengths, and HSMs, and access to  your Key Vault requires proper authentication and authorization.
+ **Monitor access and use**. Using Key Vault, you can monitor and control access to your application secrets.
+ **Simplified administration of application secrets**. Key Vault makes it easier to enroll and renew certificates from public Certificate Authorities (CAs). You can also scale up and replicate content within regions and use standard certificate management tools.
+ **Integrate with other Azure services**. You can integrate Key Vault with storage accounts, container registries, event hubs and many more Azure services. These services can then securely reference the secrets stored in the Key Vault.

To learn more about Azure Key Vault, take a look at -- [Configure and Manage Secrets in Azure Key Vault](https://docs.microsoft.com/learn/modules/configure-and-manage-azure-key-vault?azure-portal=true).


<div style="background:yellow;">
TODO: This unit is sandboxed - could we used this instead of our walkthrough in 6? https://docs.microsoft.com/learn/modules/configure-and-manage-azure-key-vault/4-store-secrets-in-akv
</div>




