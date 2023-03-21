Microsoft Defender for DNS provides an additional layer of protection for resources that use Azure DNS's [Azure-provided name resolution](https://learn.microsoft.com/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances#azure-provided-name-resolution) capability.

From within Azure DNS, Defender for DNS monitors the queries from these resources and detects suspicious activities without the need for any additional agents on your resources.

[](https://learn.microsoft.com/azure/defender-for-cloud/defender-for-dns-introduction#availability)

## What are the benefits of Microsoft Defender for DNS?

Microsoft Defender for DNS detects suspicious and anomalous activities such as:

-   **Data exfiltration** from your Azure resources using DNS tunneling
-   **Malware** communicating with command and control servers
-   **DNS attacks** - communication with malicious DNS resolvers
-   **Communication with domains used for malicious activities** such as phishing and crypto mining

A full list of the alerts provided by Microsoft Defender for DNS is on the [alerts reference page](https://learn.microsoft.com/azure/defender-for-cloud/alerts-reference#alerts-dns).