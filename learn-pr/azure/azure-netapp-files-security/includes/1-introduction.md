The [Microsoft cloud security benchmark](/security/benchmark/azure/mcsb-network-security) provides recommendations on how you can secure your cloud solutions on Azure. The content is grouped by the security controls defined by the Microsoft cloud security benchmark and the related guidance applicable to Azure NetApp Files.

This security baseline applies guidance from the [Microsoft cloud security benchmark version 1.0](/security/benchmark/azure/overview) to Azure NetApp Files.

You can monitor this security baseline and its recommendations using [Microsoft Defender for Cloud](/azure/defender-for-cloud/). Azure Policy definitions are listed in the regulatory compliance section of the [Microsoft Defender for Cloud portal page](/azure/defender-for-cloud/update-regulatory-compliance-packages).

## Encryption in Azure NetApp Files

This module covers the two basic approaches used for data encryption in Azure NetApp Files:

* **Encryption at-rest:** Data is encrypted in place using FIPS 140-2 compliant standards.
* **Encryption in-transit:** Data is encrypted in transit (over the wire) between client and server.
