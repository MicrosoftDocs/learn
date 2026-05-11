A recent penetration test revealed a critical gap in your organization's security posture. The test used stolen Microsoft Entra credentials, then they exfiltrated sensitive data from Azure Blob Storage and made unauthorized calls to your Azure OpenAI inference API—all from outside the corporate network. While Microsoft Entra authentication secured the user's identity, it didn't restrict which network the requests originated from. Your Azure SQL databases, Storage accounts, Key Vault instances, and Azure OpenAI endpoints accept requests from anywhere on the internet, as long as the caller presents valid credentials.

In this module, you assess the security risks of public platform as a service (PaaS) endpoint exposure and learn how Azure Private Link eliminates public internet access to your cloud resources. You configure private endpoints to secure Azure SQL, Storage, Key Vault, and Azure OpenAI services within your virtual network. You explore how Azure Private Link Service lets you expose your own internal services to other virtual networks. Finally, you enforce and audit private endpoint adoption using Azure Policy to ensure consistent protection across your environment.

Your first step is understanding exactly how attackers exploit public PaaS endpoints and measuring the scope of exposure in your subscription.

## Learning objectives

After completing this module, you'll be able to:

- Assess the attack surface created by public PaaS service endpoints in an Azure environment
- Configure private endpoints to route access to Azure PaaS and AI services over a private network
- Configure Azure Private Link service to expose internal services without creating a public endpoint
- Enforce private endpoint adoption at scale using Azure Policy and Defender for Cloud
