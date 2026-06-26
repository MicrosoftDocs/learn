In this module, you deployed Azure Machine Configuration to audit and enforce operating system security settings across Contoso Manufacturing's server estate. You configured the prerequisite infrastructure—the Azure Machine Configuration extension and system-assigned managed identities—assigned built-in Windows and Linux security baseline policies in audit mode, and authored custom configurations for organization-specific requirements.

## Key decisions and deployment principles

Always start policy assignments in audit mode before promoting to enforce mode. This review period identifies configuration conflicts that could disrupt running applications and allows you to document legitimate exceptions. Promoting directly to enforce mode risks unintended service outages when automated remediation changes settings required by factory software.

Both the Azure Machine Configuration extension and a system-assigned managed identity are mandatory prerequisites for compliance evaluation. Without these components, the policy can't assess OS settings. Deploy prerequisites using the built-in initiative before assigning baseline policies, and create remediation tasks to cover existing VMs.

Built-in security baselines provide immediate coverage of Microsoft Cloud Security Benchmark controls. These baselines address industry-standard hardening requirements across password policies, audit configuration, service states, and security options. Custom configurations extend this foundation to organization-specific needs—proprietary software requirements, legacy system compatibility settings, or internal security standards not covered by Microsoft baselines.

The same policy mechanism covers both Azure VMs and Azure Arc-enabled servers. A single assignment at management group scope applies platform-appropriate configurations to Windows Server VMs in Azure and Arc-enrolled Linux servers on the factory floor.

## Learning path completion

With this module, you completed the implementation of layered security controls across Contoso Manufacturing's server estate. You started with Azure Disk Encryption to protect data at rest, and added boot integrity monitoring through trusted launch. Next you implemented just-in-time access to guard remote connections, enabled runtime threat detection with Microsoft Defender for Servers, and concluded with OS configuration enforcement through Machine Configuration. Each layer addresses a specific attack surface—together they provide defense in depth across the entire compute platform.

Factory servers that were vulnerable to configuration drift, weak OS settings, and unaudited system changes are now continuously evaluated against both industry baselines and Contoso-specific requirements. The security team gains compliance visibility through the Azure Policy dashboard, and automated remediation—deployed carefully after audit-first review—prevents configuration drift.

## Learn more

- [Azure Machine Configuration overview](/azure/governance/machine-configuration/overview)
- [Author a custom machine configuration](/azure/governance/machine-configuration/overview/01-overview-concepts)
- [Built-in machine configuration policies](/azure/governance/policy/samples/built-in-policies#guest-configuration)
- [OS configuration assessment in Defender for Servers](/azure/defender-for-cloud/operating-system-misconfiguration)
