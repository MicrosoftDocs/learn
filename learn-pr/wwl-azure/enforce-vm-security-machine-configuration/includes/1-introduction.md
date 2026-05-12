Contoso Manufacturing closed critical security gaps across their server estate—encrypted disks protect data at rest, just-in-time access guards remote connections, and Defender for Servers detects runtime threats. One vulnerability remains unaddressed: operating system configuration drift. Factory servers and Arc-enrolled on-premises machines could have unnecessary services running, weak cryptographic settings, default accounts, or registry misconfigurations that enable lateral movement—none of which are currently audited or enforced.

Azure Machine Configuration provides policy-driven auditing and enforcement of OS-level security settings. In this module, you explore how to deploy and configure Machine Configuration to close Contoso's final security gap.

Here, you learn how to:

- Explore how Azure Machine Configuration audits and enforces OS-level settings using Azure Policy
- Deploy the Azure Machine Configuration extension and configure required prerequisites
- Assign built-in Windows and Linux security baseline policies in audit and enforce modes
- Author and publish a custom machine configuration for organization-specific requirements

## Prerequisites

- Familiarity with Azure Policy concepts, including initiatives, assignments, and compliance reporting
- Understanding of Azure virtual machines and Azure Arc-enabled servers
- Access to an Azure subscription with virtual machines or Arc-enrolled servers to configure


