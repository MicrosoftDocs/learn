Azure DNS is a hosting service for DNS domains that provides name resolution by using Microsoft Azure infrastructure. By hosting your domains in Azure, you can manage your DNS records by using the same credentials, APIs, tools, and billing as your other Azure services.

> [!NOTE]
> The standalone Microsoft Defender for DNS plan was deprecated in August 2023. DNS threat protection capabilities are now automatically included in **Microsoft Defender for Servers Plan 2**. There's no separate Defender for DNS plan to enable.

## DNS threat protection in Defender for Servers Plan 2

When Defender for Servers Plan 2 is enabled, Microsoft Defender for Cloud continuously monitors all DNS queries from your Azure resources and runs advanced security analytics to alert you about suspicious activity.

DNS threat protection covers the following scenarios:

- Data exfiltration from your Azure resources using DNS tunneling

- Malware communicating with command-and-control (C&C) servers

- Communication with malicious domains, such as phishing and crypto mining sites

- DNS attacks — communication with malicious DNS resolvers
