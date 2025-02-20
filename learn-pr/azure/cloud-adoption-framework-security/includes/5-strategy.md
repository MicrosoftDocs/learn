To speed up implementing the security your organization needs for the cloud, use the Azure Security Benchmark and the landing zones in the Microsoft Cloud Adoption Framework for Azure.

The Azure Security Benchmark represents the recommended security practices from Microsoft. The Azure Security Benchmark is integrated into the landing zones to simplify implementing these best practices.

## Security benchmarks

Security benchmarks are configuration baselines and best practices for securely configuring a system. Security benchmarks can help you quickly secure cloud deployments. Benchmark recommendations from your cloud service provider give you a starting point for selecting specific security configuration settings in your environment. Use the settings to quickly reduce risk to your organization.

The Azure Security Benchmark is frequently used to address common challenges for customers or service partners who:

- Are new to Azure and looking for security best practices to ensure a secure deployment of Azure services and application workloads.
- Want to improve the security posture of existing Azure deployments to prioritize top risks and mitigations.
- Need to evaluate the security features and capabilities of Azure services before they onboard and approve an Azure service into the cloud-service catalog.
- Must meet compliance requirements in highly regulated industries like government, finance, and healthcare. These customers need to ensure their service configurations of Azure meet strict security specifications. These specifications are defined in frameworks like the:

  - Center for Internet Security (CIS)
  - National Institute of Standards and Technology (NIST)
  - Payment Card Industry (PCI)
  
  The Azure Security Benchmark provides an efficient approach with the controls already pre-mapped to these industry benchmarks.

The Azure Security Benchmark includes high-impact security recommendations to help you secure services you use in Azure. Think of the recommendations as *general* or *organizational* as they apply to most Azure services.

The Azure Security Benchmark recommendations are then customized for each Azure service. The security baselines are the service-specific applications of the benchmark controls. They contain service-level configuration guidance and details.

The Azure Security Benchmark documentation specifies security controls and service recommendations:

- [**Security controls**](/security/benchmark/azure/overview): The Azure Security Benchmark recommendations are categorized by security controls. Security controls represent high-level, vendor-agnostic security requirements, like network security and data protection. Each security control has a set of security recommendations and instructions that help you implement those recommendations.
- **Security baselines**: When available, benchmark recommendations for Azure services include the Azure Security Benchmark recommendations that are tailored specifically for that service.

## Implement the Azure Security Benchmark

Implement the Azure Security Benchmark in three steps:

- **Plan your implementation**: Review the [documentation](/security/benchmark/azure/overview) for the enterprise controls and service-specific baselines. Plan your control framework and how it maps to guidance like [CIS controls](https://www.cisecurity.org/), [NIST](https://csrc.nist.gov/Projects/risk-management/), and the [PCI Data Security Standard framework](https://www.pcisecuritystandards.org/).
- **Monitor your compliance**: Use the Microsoft Defender for Cloud [regulatory compliance dashboard](/azure/security-center/security-center-compliance-dashboard) to monitor compliance with the Azure Security Benchmark status and other control sets.
- **Establish guardrails**: Automate secure configurations and enforce compliance with the Azure Security Benchmark and other requirements in your organization with Azure Policy.
