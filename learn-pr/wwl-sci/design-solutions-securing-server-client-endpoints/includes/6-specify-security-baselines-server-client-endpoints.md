Security baselines provide a tested, Microsoft-recommended starting point for hardening server and client configurations. As a security architect, you specify which baselines your organization applies, how to handle customizations, and how to monitor compliance.

## Understanding security baselines

A security baseline is a group of preconfigured settings that implement Microsoft's recommended security posture. These settings address contemporary threats while avoiding operational issues. The baseline principles follow a streamlined approach:

- Baselines assume well-managed environments where standard users don't have administrative rights
- Settings are enforced only when they mitigate current threats without causing worse operational problems
- Defaults are enforced only when they're otherwise likely to be set insecurely

Microsoft publishes baselines for Windows Server, Windows client, Microsoft 365 Apps, and Microsoft Edge. These baselines align with the Microsoft Cloud Security Benchmark (MCSB) and map to common compliance frameworks.

## Specify server baseline requirements

For Windows Server environments, specify baselines from the Security Compliance Toolkit (SCT). The SCT provides Group Policy Objects (GPOs) that you deploy through Active Directory or apply locally.

**Current server baselines**

| Operating system | Baseline version | Use case |
| --- | --- | --- |
| Windows Server 2025 | January 2025 | New deployments, domain controllers |
| Windows Server 2022 | September 2021 | Production workloads, member servers |
| Windows Server 2019 | November 2018 | Legacy application hosts |
| Windows Server 2016 | October 2016 | Systems requiring older OS |

When specifying server baseline requirements:

- **Require the baseline matching the OS version**: Specify that each server must have the corresponding baseline applied. New deployments should use the latest supported OS and baseline.
- **Define the deployment method**: For domain-joined servers, require GPO deployment. For workgroup servers or Azure Arc-connected machines, specify how baselines are applied (local policy, Azure Policy, or configuration management tools).
- **Address domain controller specifics**: Domain controllers have additional requirements. Specify that the baseline's dedicated DC settings must be applied to all domain controllers.

## Specify client baseline requirements

For Windows 10 and Windows 11 devices managed through Intune, specify MDM security baselines. These baselines implement the same security configurations as the SCT baselines but use modern device management.

**Current client baselines in Intune**

| Baseline type | Current version | Purpose |
| --- | --- | --- |
| Windows MDM Security Baseline | Version 24H2 | Core Windows hardening |
| Microsoft Defender for Endpoint | Version 24H1 | Threat protection settings |
| Microsoft Edge | Version 128 | Browser security |
| Windows 365 | Version 24H1 | Cloud PC environments |

Your specification should address:

- **Baseline selection**: Require the Windows MDM Security Baseline for all managed Windows devices. Add the Defender for Endpoint baseline if devices are onboarded to Defender for Endpoint.
- **Version management**: Specify that baselines must be updated within 90 days of a new version release. Define who approves baseline updates and the testing process.
- **Profile assignment**: Require baseline profiles be assigned to device groups, not user groups, to ensure consistent application regardless of who signs in.

## Customization requirements

Default baseline settings work for most organizations, but you may need to customize certain settings. Your specification should define the customization process.

**When customization is acceptable**

- A baseline setting conflicts with a required line-of-business application
- The setting breaks a documented business function
- A regulatory requirement mandates a different configuration

**Customization process requirements**

1. Document the specific setting being changed and the business justification
2. Identify compensating controls that mitigate any reduced security
3. Obtain approval from security leadership
4. Review customizations annually or when baselines are updated

**Settings that shouldn't be weakened**

- Credential Guard and virtualization-based security (VBS)
- BitLocker encryption requirements
- Windows Defender Antivirus real-time protection
- Network protection and SmartScreen enforcement
- SMBv1 protocol disabled

## Compliance monitoring requirements

Specify how baseline compliance is monitored and what actions are taken for noncompliant devices.

**For Intune-managed clients**

- Require baseline compliance reports be reviewed weekly
- Define thresholds for acceptable noncompliance (recommend less than 5% of devices)
- Specify remediation timelines: configuration drift must be corrected within 72 hours
- Integrate baseline compliance data into conditional access policies where appropriate

**For server environments**

- Use the Policy Analyzer tool from SCT to compare current configurations against the baseline
- Require quarterly baseline compliance assessments
- Integrate with Microsoft Defender for Cloud's regulatory compliance dashboard for Azure VMs
- For Azure Arc-connected servers, use Azure Policy guest configuration to audit baseline settings

## Relationship to other security requirements

Security baselines implement many of the specific settings referenced in other security requirements. When specifying baselines, clarify how they relate to:

- **MCSB controls**: Baselines implement technical settings that support MCSB requirements. For example, the Windows baseline's firewall settings support network segmentation controls.
- **Defender for Servers**: The Intune Defender for Endpoint baseline complements Defender for Servers by configuring client-side protection settings.
- **Regulatory compliance**: Map baseline settings to specific regulatory requirements (PCI-DSS, HIPAA, SOC 2) to demonstrate technical control implementation.

## Documentation requirements

Your security baseline specification should include:

- **Required baselines**: List each baseline by name and minimum version
- **Deployment scope**: Define which systems require each baseline
- **Customization register**: Track all approved deviations from baseline defaults
- **Compliance thresholds**: Define acceptable variance and remediation timelines
- **Update schedule**: Specify how quickly new baseline versions must be adopted
- **Exception process**: Document how to request and approve baseline exceptions

This structured approach ensures consistent security hardening across your endpoint environment while maintaining the flexibility to address legitimate business requirements.
