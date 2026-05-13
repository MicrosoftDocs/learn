Enabling just-in-time access on eligible virtual machines moves them from the Not configured state to the Configured state, immediately closing the attack surface on management ports. Defender for Cloud provides multiple enablement paths designed for different operational workflows—bulk enablement from the centralized Just-in-Time (JIT) interface for large-scale deployment, or individual VM enablement for targeted protection.

| Enablement Method | Best For | Starting Point |
|-------------------|----------|----------------|
| Defender for Cloud bulk enables | Initial deployment across multiple VMs | Workload protections → Just-in-time VM access → Not configured tab |
| Individual VM enables | Single VM or per-VM workflow | VM → Configuration → Just-in-time access |
| Programmatic enable | Automation and infrastructure-as-code | PowerShell `Set-AzJitNetworkAccessPolicy` or REST API |

## Enable JIT from Defender for Cloud

The centralized JIT interface in Defender for Cloud provides the most efficient path for protecting multiple virtual machines simultaneously. Navigate to Defender for Cloud, select **Workload protections**, then select **Just-in-time VM access**. The interface displays three tabs: Configured, Not configured, and Unsupported. Select the **Not configured** tab to view all eligible VMs that currently lack JIT protection.

Select the virtual machines you want to protect using the checkboxes in the left column. For Contoso Manufacturing's initial deployment, the security team selects all factory floor VMs in the primary production resource group. After selecting VMs, select **Enable JIT on VMs** from the command bar. Defender for Cloud immediately applies the default JIT policy and modifies the associated network security groups to block management ports.

The default policy configuration includes commonly targeted management ports with conservative access parameters:

- **RDP (3389)**: Maximum request time 3 hours, allowed source IPs: Any, protocol: TCP
- **SSH (22)**: Maximum request time 3 hours, allowed source IPs: Any, protocol: TCP  
- **WinRM (5985)**: Maximum request time 3 hours, allowed source IPs: Any, protocol: TCP
- **WinRM over HTTPS (5986)**: Maximum request time 3 hours, allowed source IPs: Any, protocol: TCP

Linux VMs receive JIT protection on port 22, while Windows VMs are protected on ports 3389, 5985, and 5986. This automatic port selection aligns with the most common remote management protocols. When admins enable JIT from the individual VM Configuration page rather than the Defender for Cloud interface, only port 3389 appears as the Windows default. Other ports like the WinRM ports (5985, 5986) are included only when enabling through the Defender for Cloud bulk path or programmatically.

## Enable JIT from an individual virtual machine

For operators who manage VMs individually rather than through centralized security operations, the VM Configuration page provides direct JIT enablement. Navigate to the virtual machine in the Azure portal, select **Configuration** from the left navigation menu, then locate the **Just-in-time access** section.

Select **Enable just-in-time**. Defender for Cloud applies the default policy with the same port configurations described. This approach works well for newly deployed VMs or when JIT enablement is part of a VM-specific security review process.

## Customize the JIT policy

The default JIT policy provides broad protection but allows access from any source IP address, which can’t align with organizational security requirements. Contoso Manufacturing's security standards require restricting JIT access to connections originating from the corporate office IP range (203.0.113.0/24) and the VPN concentrator IP range (198.51.100.0/24).

To customize a JIT policy, navigate to Defender for Cloud → **Just-in-time VM access** → **Configured** tab. Right-click the virtual machine you want to modify and select **Edit**. The policy editor displays the current port configurations with options to add, remove, or modify rules.

To restrict source IP addresses, select the port row and modify the **Allowed source IPs** field. Replace **Any** with a CIDR notation range such as `203.0.113.0/24` or a comma-separated list of ranges: `203.0.113.0/24,198.51.100.0/24`. This change ensures that JIT access requests succeed only when the requester's source IP falls within the approved corporate network ranges.

To add a custom port, select **Add** and specify the port number, protocol (TCP, UDP, or Any), allowed source IPs, and maximum request time. For example, Contoso Manufacturing adds port 5432 (PostgreSQL) for database administration access with a one-hour maximum window and source IP restricted to the database team's subnet.

To remove a port from JIT protection, uncheck the port in the policy editor or delete the rule entirely. Removing a port from the JIT policy doesn't restore the previous NSG rule—the port remains blocked unless you manually create an NSG ALLOW rule.

The maximum request time parameter controls the longest duration a user can request for a single JIT session. Setting this value to 1 hour instead of the default 3 hours reduces the exposure window for each access grant. Contoso Manufacturing uses 1-hour windows for production VMs and 3-hour windows for development and testing environments where longer sessions support troubleshooting workflows.

## Enable JIT programmatically

Automation pipelines and infrastructure-as-code workflows can enable and configure JIT policies using PowerShell or REST API. The PowerShell approach uses the `Set-AzJitNetworkAccessPolicy` cmdlet:

```powershell
$JitPolicy = (@{
    id="/subscriptions/SUBSCRIPTION_ID/resourceGroups/RESOURCE_GROUP/providers/Microsoft.Compute/virtualMachines/VM_NAME";
    ports=(@{
        number=22;
        protocol="*";
        allowedSourceAddressPrefixes=@("203.0.113.0/24");
        maxRequestAccessDuration="PT1H"
    })
})

$JitPolicyArr=@($JitPolicy)
Set-AzJitNetworkAccessPolicy -ResourceGroupName "RESOURCE_GROUP" -Location "eastus" -Kind "Basic" -Name "JIT_POLICY_NAME" -VirtualMachine $JitPolicyArr
```

This script creates a JIT policy protecting SSH port 22 with a one-hour maximum window and source IP restricted to the Contoso Manufacturing office range. The `maxRequestAccessDuration` parameter uses ISO 8601 duration format (PT1H = 1 hour).

## What happens after JIT is enabled

Immediately after JIT enablement, Defender for Cloud modifies the network security group associated with the virtual machine. Any existing NSG rules that allow inbound traffic on the JIT-protected ports are overridden or replaced with DENY rules. The management ports become inaccessible from all sources, including previously permitted IP ranges.

Users who attempt to connect to the VM using RDP or SSH after JIT enablement receive connection timeout or connection refused errors until they submit a JIT access request. This immediate blocking behavior closes the attack surface instantly, which is why Contoso Manufacturing's security team coordinates JIT deployment with operations teams to ensure administrators understand the new access request workflow.

> [!NOTE]
> The combined length of the JIT policy name and virtual machine name can't exceed 56 characters. If you encounter provisioning errors during JIT enablement, verify that resource names fall within this constraint and shorten names if necessary.

Now that you understand how to enable JIT and customize port policies, you're ready to submit access requests and audit JIT activity across your VM estate.
