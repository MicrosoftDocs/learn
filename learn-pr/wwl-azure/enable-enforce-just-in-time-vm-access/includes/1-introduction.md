Contoso Manufacturing uses a dedicated Azure Bastion deployment with the Basic, Standard, or Premium SKU for normal browser-based administration of its factory floor virtual machines. An audit finds additional network security group (NSG) rules that allow broad direct access to Remote Desktop Protocol (RDP) port 3389 and Secure Shell (SSH) port 22. Contoso must remove this unnecessary exposure while preserving the approved private management path used by Bastion. Some approved maintenance tasks still require direct access, so Contoso uses just-in-time (JIT) VM access for those exceptions.

Microsoft Defender for Cloud's JIT VM access restricts selected management ports and opens a time-limited network-access window for an authorized request. Existing network rules can take precedence over JIT restrictions. Closing Contoso's audit finding therefore requires reviewing and removing or narrowing broad allow rules, configuring JIT, and verifying effective access.

The goal in this scenario is to eliminate broad direct management access, not every permanent private management rule. A persistent allow restricted to the approved Bastion path is still standing network access and must be documented as an exception. It doesn't meet a requirement for zero standing access on every management path.

In this module, you:

- Examine how just-in-time VM access reduces the attack surface on management ports
- Enable JIT and configure per-port access policies on Azure VMs
- Request authorized JIT access and audit access activity
- Monitor JIT adoption with Azure Policy and configure required JIT policies through an approved provisioning workflow

## Prerequisites

Before you begin, make sure you have the following:

- An Azure public-cloud subscription with Microsoft Defender for Servers Plan 2 enabled
- Intermediate-level familiarity with Azure virtual machines and network security groups
- Basic familiarity with Microsoft Defender for Cloud
- Azure role-based access control (RBAC) permissions to configure JIT or request access, depending on the operation you perform
- Access to administrators, or separately scoped permissions, for the network-rule changes, effective-rule inspection, Activity Log review and export, and Azure Policy assignment used in this module
- For the scenario's Bastion checks, access to an existing dedicated Azure Bastion deployment using the Basic, Standard, or Premium SKU and its approved target VMs
