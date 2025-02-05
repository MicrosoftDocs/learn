The Microsoft cybersecurity group and the Center for Internet Security ([CIS](https://www.cisecurity.org/)) have developed best practices to help establish security baselines for the Azure platform.

:::image type="content" source="../media/cis-benchmark.png" border="false" alt-text="A diagram of the workflow for securing Azure workloads with the Azure CIS benchmark.":::

Microsoft initially partnered with CIS to develop an off-the-shelf [hardened Azure virtual machine (VM)](https://www.cisecurity.org/cis-hardened-image-list). An initiative then began to create a CIS benchmark—a document that details CIS best practices—for Azure security services and tools to facilitate security and compliance for customer applications running on Azure services.

> [!TIP]
> The [CIS Microsoft Azure Foundations Security Benchmark v. 3.0.0](https://www.cisecurity.org/benchmark/azure/) provides prescriptive guidance for establishing a secure baseline configuration for Azure. This guide was tested against the listed Azure services as of September 2024. The scope of this benchmark is to establish the foundational level of security for anyone who adopts Azure.

## Create a platform security baseline

Various security standards can help cloud-service customers achieve workload security when they use cloud services. The following recommended technology groupings help create secure cloud-enabled workloads. These recommendations aren't an exhaustive list of all possible security configurations and architectures. These security baseline recommendations are a starting point.

CIS has two implementation levels and several categories of recommendations:

- **Level 1**: Recommended minimum security settings
  - These settings should be configured on all systems.
  - These settings should cause little or no interruption of services or reduced functionality.

- **Level 2**: Recommendations for highly secure environments
  - These settings might result in reduced functionality.

The following table provides the categories and number of recommendations made for each category in [CIS Microsoft Azure Foundations Security Benchmark v. 3.0.0](https://www.cisecurity.org/benchmark/azure/):

| Technology group | Description | # of recommendations |
|------------------|-------------|----------------------|
| **Identity & Access Management (IAM)** | Recommendations related to IAM policies | 30 |
| **Microsoft Defender for Cloud** | Recommendations related to the configuration and use of Microsoft Defender for Cloud | 35 |
| **Storage accounts** | Recommendations for setting storage account policies | 17 |
| **Azure SQL Database** | Recommendations for helping to secure Azure SQL databases | 22 |
| **Logging and monitoring** | Recommendations for setting logging and monitoring policies for your Azure subscriptions | 21 |
| **Networking** | Recommendations for helping to securely configure Azure networking settings and policies | 7 |
| **VMs** | Recommendations for setting security policies for Azure compute services, and specifically VMs | 11 |
| **Other** | Recommendations regarding general security and operational controls, including recommendations related to Azure Key Vault and resource locks | 13 |
| **Total recommended** | | 156 |

Let's explore each category in more detail.
