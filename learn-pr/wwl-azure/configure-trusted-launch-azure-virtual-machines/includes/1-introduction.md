Contoso Manufacturing operates dozens of Azure virtual machines that control production systems on the factory floor. These VMs were deployed before Trusted Launch became the default security configuration for Generation 2 (Gen2) Azure VMs. A recent security audit revealed a critical gap: no boot integrity controls are in place, which means rootkit or boot-kit malware could compromise the operating system before any endpoint protection software loads. Several of the factory VMs are still Generation 1 (Gen1), which further limits security options.

In this module, you learn how Trusted Launch protects Azure VMs from boot-level threats using three integrated security components: Secure Boot, virtual Trusted Platform Module (vTPM), and integrity monitoring. You explore how to enable Trusted Launch on new and existing virtual machines. Then you learn to upgrade Gen1 VMs to Gen2 with Trusted Launch enabled, and enforce Trusted Launch adoption across your VM estate using Azure Policy.

## Learning objectives

In this module, you:

- Identify how Trusted Launch protects against boot-level threats using Secure Boot, vTPM, and integrity monitoring
- Enable Trusted Launch and configure its security components on new and existing Azure VMs
- Upgrade existing Gen1 VMs to Gen2 with Trusted Launch enabled
- Enforce Trusted Launch adoption using built-in Azure Policy

## Prerequisites

- Familiarity with Azure virtual machines and basic VM management tasks
- Understanding of Azure Policy concepts and policy assignment
- Access to an Azure subscription with permissions to create and modify virtual machines
