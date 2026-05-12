Permanently open management ports in network security groups represent one of the most common attack vectors against cloud infrastructure. Even with strong authentication mechanisms and Azure Bastion deployed for browser-based access, a Network Security Group (NSG) rule that allows RDP port 3389 or SSH port 22 from any source remains a discoverable entry point. Attackers can target these ports with credential stuffing, brute force attacks, or exploit campaigns. Just-in-time VM access closes this vulnerability by replacing persistent ALLOW rules with on-demand, time-limited, IP-scoped rules that grant access only when needed.

| VM State | Management Port Status | Attack Surface |
|----------|------------------------|----------------|
| Before JIT | Permanently open via NSG ALLOW rule | Constant exposure to scanning and attack attempts |
| After JIT enabled | Blocked by default (DENY or no rule) | Port invisible to scanners; zero standing access |
| During JIT session | Temporarily open for specific IP and duration | Minimal exposure window; restricted source |

## How just-in-time access works

Just-in-time access modifies NSG rules dynamically to create temporary access windows. When you enable JIT on a virtual machine, Defender for Cloud immediately modifies the associated network security group to block the configured management ports. The port remains blocked until a user with appropriate permissions submits an access request. 

When an access request is approved, Defender for Cloud inserts a temporary ALLOW rule into the NSG with three critical constraints: the rule permits traffic only from the requester's source IP address (or a specified IP range), only on the requested port, and only for the approved time window (maximum of 24 hours, typically much shorter). After the time window expires, Defender for Cloud automatically removes the temporary ALLOW rule, returning the port to a blocked state.

This lifecycle operates transparently to the user—the only visible change is that connection attempts succeed during the approved time window and fail before or after. With Azure Firewall, JIT modifies the DNAT (Destination Network Address Translation) table instead of NSG rules, but the access control model remains identical.

## Requirements for just-in-time access

JIT VM access requires specific infrastructure and licensing components to function correctly. Defender for Servers Plan 2 must be enabled on the subscription—Plan 1 doesn't include JIT capabilities. The virtual machine must be deployed through Azure Resource Manager; Classic deployment model VMs aren't supported and can't be migrated to JIT without redeployment.

The VM must have a network security group associated either directly with the VM's network interface or with the subnet where the VM resides. Alternatively, the VM can be protected by Azure Firewall deployed on the same virtual network—however, that firewall must be configured with Rules (Classic). VMs protected by Azure Firewall using Firewall Policies (managed through Azure Firewall Manager), VMs without an NSG or firewall, aren't supported for JIT access.

## Virtual machine eligibility states

Defender for Cloud categorizes virtual machines into three states visible in the just-in-time VM access interface. **Configured** VMs have JIT enabled and show request history and active policies. **Not configured** VMs meet all technical requirements but don't have JIT protection enabled—these machines represent the immediate remediation opportunity for Contoso Manufacturing's audit finding. **Unsupported** VMs can't use JIT due to Classic deployment, missing NSG or firewall association, or JIT being disabled in the security policy.

The Not configured state is the primary focus for security operations teams during JIT deployment. These eligible but unprotected VMs have permanently open management ports and should be prioritized for JIT enablement. The Configured state represents the target end state where management ports are blocked by default and accessible only through approved JIT requests.

## Supported environments

JIT VM access supports Azure virtual machines deployed through Azure Resource Manager across all Azure regions where Defender for Cloud is available. JIT also supports AWS EC2 instances connected through Defender for Cloud's multicloud capabilities, though this integration is currently in preview.

Contoso Manufacturing's factory floor VMs are deployed using Azure Resource Manager templates with network security groups attached at the subnet level. This configuration makes them eligible for JIT protection. The organization has a few legacy Classic VMs that require migration to the Resource Manager deployment model before JIT can be applied—these VMs remain in the Unsupported state until redeployment.

Now that you understand JIT eligibility requirements and the access control model, you're ready to enable JIT on eligible virtual machines and configure port-specific access policies.
