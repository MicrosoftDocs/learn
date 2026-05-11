Contoso Manufacturing deployed Azure Bastion to provide secure, browser-based access to factory floor virtual machines, eliminating the need for direct RDP and SSH connections. Despite this deployment, an internal security audit revealed a critical gap: network security group (NSG) rules still permanently allow inbound traffic on RDP port 3389 and SSH port 22 from broad source IP ranges. These open management ports create a persistent attack surface that malicious actors can discover and target. The audit finding requires immediate remediation: eliminate all permanently open management ports across the VM estate.

Microsoft Defender for Cloud's just-in-time (JIT) VM access provides the solution. JIT replaces permanent ALLOW rules with on-demand, time-limited, IP-scoped access—management ports remain blocked until a verified user requests access for a specific purpose and duration. Here, you learn how to close Contoso Manufacturing's security gap using JIT VM access.

In this module, you:

- Examine how just-in-time VM access reduces the attack surface on management ports
- Enable JIT and configure per-port access policies on Azure VMs
- Request and approve JIT access and audit access activity
- Enforce JIT adoption across a VM estate using Azure Policy

## Prerequisites

- Defender for Servers Plan 2 enabled on the subscription
- Intermediate-level familiarity with Azure virtual machines and network security groups
