Contoso Manufacturing eliminated the security audit finding by implementing just-in-time VM access across the factory floor VM estate. Permanently open management ports in network security groups—the original attack surface—are now replaced with on-demand, time-limited, IP-scoped ALLOW rules that grant access only during verified administrative sessions.

You accomplished the following objectives in this module:

- **Examined JIT access requirements**: JIT requires Defender for Servers Plan 2, Azure Resource Manager–deployed VMs, and an associated NSG or Azure Firewall. VMs in the Not configured state represent the remediation opportunity.
- **Enabled and configured JIT policies**: The default policy protects RDP (3389), SSH (22), and WinRM (5985/5986) with three-hour maximum windows and any source IP. Customizing the policy to restrict source IPs to corporate network ranges significantly reduces the exposure window.
- **Requested access and audited activity**: JIT access requests specify ports, source IP, and time window. Azure Activity Log captures all JIT events, providing a complete audit trail for compliance and security review.
- **Enforced JIT adoption with Azure Policy**: The built-in audit policy identifies VMs with open management ports and no JIT protection, enabling continuous compliance monitoring as new VMs are deployed.

## Key decisions

- **JIT replaces standing access with on-demand access**: Management ports remain blocked until a user requests access for a specific purpose and duration.
- **Default ports include 22, 3389, 5985, 5986**: Customize the policy to add application-specific ports or remove unnecessary ports.
- **Restrict source IPs for tighter control**: Replace "Any" with corporate IP ranges to limit access to trusted networks.
- **Azure Activity Log provides the audit trail**: All JIT requests, approvals, and policy changes are recorded for compliance reporting.
- **Azure Policy drives scale adoption**: The audit policy identifies noncompliant VMs, enabling continuous enforcement as the VM estate grows.

## Learn more

- [Just-in-time VM access overview](/azure/defender-for-cloud/just-in-time-access-overview)
- [Enable just-in-time access](/azure/defender-for-cloud/enable-just-in-time-access)
