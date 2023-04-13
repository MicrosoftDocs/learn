

> [!NOTE]
> Microsoft cloud security benchmark is the successor of Azure Security Benchmark (ASB), which was rebranded in October 2022. It is currently in public preview.

New services and features are released daily in Azure, developers are rapidly publishing new cloud applications built on these services, and attackers are always seeking new ways to exploit misconfigured resources.

The Microsoft cloud security benchmark and security baselines for Azure, which are closely related, help organizations secure their cloud solutions on Azure.

### Microsoft cloud security benchmark

Microsoft has found that using security benchmarks can help organizations quickly secure their cloud deployments and reduce risk to their organization.

The Microsoft cloud security benchmark (MCSB) provides prescriptive best practices and recommendations to help improve the security of workloads, data, and services on Azure and your multicloud environment.  

The best way to understand the Microsoft cloud security benchmark is to view it on GitHub [Microsoft_cloud_security_benchmark_v1_preview](https://github.com/MicrosoftDocs/SecurityBenchmarks/blob/master/Azure%20Security%20Benchmark/Microsoft_cloud_security_benchmark_v1_preview.xlsx). Spoiler alert, it's an excel spreadsheet. Some of the key pieces of information in MCSB V1 are:
-  ID - Each line item in the MCSB has an identifier that maps to a specific recommendation.
- Control domain - A control is a high-level description of a feature or activity that needs to be addressed and isn't specific to a technology or implementation. MCSB control domains include network security, data protection, identity management, privileged access, incident response, endpoint security to name just a few.
- Mapping to industry frameworks - The recommendations included in the MCSB map to existing industry frameworks, such as the Center for Internet Security (CIS), the National Institute of Standards and Technology (NIST), and the Payment Card Industry Data Security Standards (PCI DSS) frameworks. This makes security and compliance easier for customer applications running on Azure services.
- Recommendation - For each control domain area there can be many distinct recommendations. Each recommendation captures specific functionality associated with the control domain area and is itself a control. For example, the "Network Security" control domain in MCSB v1 has 10 distinct recommendations identified as NS-1 through NS-10. Each of these recommendations describes a specific control under network security.  The recommendation identified as NS-1 is to establish network segmentation boundaries.
- Security principle - Each recommendation lists a "Security Principle" that explains the "what" for the control at the technology-agnostic level.  For the recommendation to establish network segmentation boundaries, one of the points included in the security principle is that any workload that could incur higher risk for the organization should be in isolated virtual networks.
- Azure Guidance - Azure Guidance is focused on the "how", elaborating on the relevant technical features and ways to implement the controls in Azure.  Continuing with the example of NS-1, the Azure guidance includes information regarding creating a virtual network (VNet), using network security groups (NSG), and using an application security group (ASG).
- AWS Guidance - The AWS guidance is  focused on the "how" specific to AWS, explaining the AWS technical features and implementation basics.

The MCSB also includes links to information on implementation that relate to the Azure and AWS guidance, information about security functions at the customer organization who may be accountable, responsible, or consulted for the respective control, and more.  The image below is an excerpt from the Microsoft cloud security benchmark version 1 (MCSB v1) and is shown as an example of the type of the content that is included in the MCSB. The image is not intended to show the complete text for any of the line items.

:::image type="content" source="../media/microsoft-cloud-security-benchmark-v1-inline.png" lightbox="../media/microsoft-cloud-security-benchmark-v1-expanded.png" alt-text="A subset of information from the Microsoft cloud security benchmark v1.":::

Microsoft Defender for Cloud continuously assesses an organization's hybrid cloud environment to analyze the risk factors according to the controls and best practices in the Microsoft cloud security benchmark. Some of the controls used in the MCSB include network security, identity and access control, data protection, data recovery, incident response, and more.  

:::image type="content" source="../media/defender-cloud-compliance-inline.png" lightbox="../media/defender-cloud-compliance-expanded.png" alt-text="Screenshot of Microsoft Defender for Cloud regulatory compliance against Microsoft cloud security benchmark v1.":::

### Security baselines for Azure

Security baselines are standardized documents for Azure product offerings, describing the available security capabilities and the optimal security configurations to help you strengthen security through improved tooling, tracking, and security features. Service baselines are currently only available for Azure.

Microsoft cloud security benchmark v1 baselines apply guidance from the Microsoft cloud security benchmark to the specific Azure service for which it's defined.  For example, the security baseline for Azure Key Vault applies guidance from the Microsoft cloud security benchmark version 1.0 to Azure Key Vault. Some security baselines may apply guidance from previous benchmarks, such as Azure security benchmark v3.

Content in the security baseline is grouped by the control domains defined by the Microsoft cloud security benchmark that are applicable to the service.  A security baseline includes the following information for each applicable MCSB recommendation (control):

- **Control ID**: The Microsoft cloud security benchmark ID that corresponds to the control (recommendation) in the Microsoft cloud security benchmark.
- **Feature**: Security feature(s) that can help you meet that control requirement.
- **Feature Description**: A high-level description of the feature and how it fits into the product offering.
- **Supported**: A true/false value indicating if this feature is supported to secure this product offering.
- **Enabled by Default**: A true/false value indicating if this feature is enabled in a default deployment by Microsoft.
- **Configuration Responsibility**: Who is responsible for implementing the configuration guidance (where possible scenarios are Customer responsibility, Microsoft responsibility or Shared responsibility).
- **Configuration Guidance**: Actionable guidance to implement the configurations.
- **Microsoft Defender for Cloud monitoring Note**: Microsoft Defender for Cloud policy / monitoring information. (Note: If a feature is not monitored by Microsoft Defender for Cloud for the service, this section is omitted.)
- **Reference**: A reference link to dive deeper into how to implement the configuration guidance.

The image below, which is an excerpt from the Azure Key Vault security baseline, highlights the type of information provided in a security baseline.

:::image type="content" source="../media/security-baseline-inline.png" lightbox="../media/security-baseline-expanded.png" alt-text="The image below shows the type of information provided in a security baseline.":::
