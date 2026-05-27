Contoso Manufacturing faced a critical security gap: factory floor VMs lacked boot integrity protection, which left them vulnerable to rootkits and boot-kits that could compromise systems before endpoint protection loads. Several VMs were still Generation 1, further limiting security options.

In this module, you learned how Trusted Launch addresses boot-level threats through three integrated security components. Secure Boot enforces signature validation for boot components, blocking unsigned malware from executing. The virtual Trusted Platform Module (vTPM) measures the entire boot chain and creates cryptographic evidence of boot integrity. Integrity monitoring connects vTPM measurements to Microsoft Defender for Cloud, generating security alerts when boot integrity fails.

You explored how to enable Trusted Launch in multiple scenarios: automatically on new Gen2 VMs, through security type upgrade on existing Gen2 VMs, and through migration for Gen1 VMs. You learned that enabling Trusted Launch on existing VMs requires stopping and deallocating the VM, and that Azure Backup configurations must use Enhanced policies to support Trusted Launch.

Finally, you examined how Azure Policy enforces Trusted Launch adoption at scale. The built-in eligibility policy identifies Gen2 VMs capable of running Trusted Launch. The configuration policy audits which VMs actually have Trusted Launch enabled. Together, these policies provide the governance framework to assess compliance, plan remediation, and prevent configuration drift through management group assignments.

For Contoso Manufacturing, implementing Trusted Launch across factory floor VMs establishes a hardware-backed root of trust at the boot layer. Boot integrity monitoring through Defender for Cloud ensures that any tampering attempt triggers immediate security team response. Gen1 VMs now have a clear migration path to modern security controls. Azure Policy assignment at management group scope ensures that all future factory systems automatically inherit Trusted Launch protection.

In this module, you:

- Identified how Trusted Launch protects against boot-level threats using Secure Boot, vTPM, and integrity monitoring
- Enabled Trusted Launch and configured its security components on new and existing Azure VMs
- Upgraded existing Gen1 VMs to Gen2 with Trusted Launch enabled
- Enforced Trusted Launch adoption using built-in Azure Policy

## Learn more

- [Trusted launch for Azure VMs](/azure/virtual-machines/trusted-launch)
- [Enable Trusted Launch on existing Gen2 VMs](/azure/virtual-machines/trusted-launch-existing-vm)
- [Upgrade Gen1 VMs to Trusted Launch](/azure/virtual-machines/trusted-launch-existing-vm-gen-1)
- [Boot integrity monitoring overview](/azure/virtual-machines/boot-integrity-monitoring-overview)
- [Trusted Launch built-in policies](/azure/virtual-machines/trusted-launch-portal)
