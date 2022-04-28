Organizations can speed up implementing the security they need for cloud with the Azure Security Benchmarks and the Landing Zones in the Microsoft Cloud Adoption Framework. The Benchmarks represent Microsoft's recommended security best practices and are integrated into the Landing Zones to simplify the implementation of these best practices.

## Security benchmarks

Security benchmarks are configuration baselines and best practices for securely configuring a system. Security benchmarks can help you quickly secure cloud deployments. Benchmark recommendations from your cloud service provider give you a starting point for selecting specific security configuration settings in your environment and allow you to quickly reduce risk to your organization.

The Azure Security Benchmark is frequently used to address common challenges for customers or service partners who are:

- New to Azure and are looking for security best practices to ensure a secure deployment of Azure services and your own application workload.
- Looking to improve security posture of existing Azure deployments to prioritize top risks and mitigations.
- Evaluating the security features/capabilities of Azure services before onboarding/approving an Azure service(s) into the cloud service catalog.
- Having the need to meet compliance requirements in highly regulated industries like government, finance and healthcare. These customers need to ensure their service configurations of Azure meet the security specification defined in framework such as CIS, NIST, or PCI. Azure Security Benchmark provides an efficient approach with the controls already pre-mapped to these industry benchmarks.

The Azure Security Benchmark includes high-impact security recommendations to help you secure most of the services you use in Azure. You can think of these recommendations as general or organizational, as they are applicable to most Azure services. The Azure Security Benchmark recommendations are then customized for each Azure service.

The Azure Security Benchmark documentation specifies security controls and service recommendations.

- [Security controls](/security/benchmark/azure/overview): The Azure Security Benchmark recommendations are categorized by security controls. Security controls represent high-level vendor-agnostic security requirements, like network security and data protection. Each security control has a set of security recommendations and instructions that help you implement those recommendations.
- [Service recommendations](/security/benchmark/azure/security-baselines-overview): When available, benchmark recommendations for Azure services will include Azure Security Benchmark recommendations that are tailored specifically for that service.

## Implement the Azure Security Benchmark

Implementing the Azure Security Benchmark can be done in three steps:

- **Plan** your Azure Security Benchmark implementation by reviewing the [documentation](/security/benchmark/azure/overview) for the enterprise controls and service-specific baselines to plan your control framework and how it maps to guidance like [Center for Internet Security (CIS) Controls](https://www.cisecurity.org/), [National Institute of Standards and Technology (NIST)](https://csrc.nist.gov/Projects/risk-management/), and the [Payment Card Industry Data Security Standard (PCI-DSS) framework](https://www.pcisecuritystandards.org/).
- **Monitor** your compliance with Azure Security Benchmark status (and other control sets) using the Microsoft Defender for Cloud [regulatory compliance dashboard](/azure/security-center/security-center-compliance-dashboard).
- **Establish** guardrails to automate secure configurations and enforce compliance with Azure Security Benchmark (and other requirements in your organization) with Azure Blueprints and Azure Policy.
