Enabling just-in-time (JIT) access configures network restrictions and access-policy limits for eligible VMs. It doesn't automatically remove existing allow rules. Coordinate enablement with a review of the effective network rules and the administrative paths that must remain available.

Choose the entry point that fits your workflow.

| Enablement method | Best for | Starting point |
| --- | --- | --- |
| Defender for Cloud | Initial configuration across multiple VMs | Workload protections > Just-in-time VM access > Not configured |
| Individual VM | Single-VM configuration | VM > Configuration > Just-in-time access |
| Programmatic configuration | Automation and infrastructure as code | PowerShell `Set-AzJitNetworkAccessPolicy` for NSG-only policies, or deployment resources or REST API for the full configuration |

## Enable JIT from Defender for Cloud

Contoso's security team uses the centralized interface to configure the factory VMs after reviewing their existing network rules. To configure the selected VMs:

1. In Defender for Cloud, open **Workload protections**, then **Just-in-time VM access**.
1. On **Not configured**, select the VMs and select **Enable JIT on VMs**. This opens the configuration page.
1. Review the recommended ports. Edit or add the ports needed for the workload, and set each port's protocol, allowed sources, and maximum request time.
1. Confirm each port edit with **OK**, then select **Save** to apply the configuration.
1. Confirm that the intended VMs appear under **Configured**, then validate their effective network access.

The starting configuration differs between the centralized editor and the individual VM shortcut.

| Entry point | Documented starting behavior |
| --- | --- |
| Defender for Cloud JIT page | Recommends SSH 22, RDP 3389, and WinRM 5985 and 5986. Review and configure the required ports before saving. |
| Windows VM > Configuration | Enables RDP 3389 with a three-hour maximum request and Any source. |
| Linux VM > Configuration | Enables SSH 22 with a three-hour maximum request and Any source. |

Don't assume the centralized editor filters the recommended list to the ports required by the guest OS. Contoso explicitly selects TCP for its TCP management connections and removes unnecessary port entries.

## Enable JIT from an individual virtual machine

For a single VM, open the VM in the Azure portal, select **Configuration**, and locate **Just-in-time access**.

Select **Enable just-in-time** to apply the individual VM defaults. To change the source restriction, duration, protocol, or protected ports, open the VM's JIT configuration in Defender for Cloud, edit it, and save.

## Customize the JIT policy

Allowed source IPs define where permitted traffic to the protected port can originate. They don't restrict where a person or application can sign in to Azure to submit the JIT request. Azure RBAC authorizes the requester, and the JIT policy constrains the requested network access.

> [!NOTE]
> The `203.0.113.0/24` and `198.51.100.0/24` addresses in this module are documentation examples. Replace them with approved addresses for your environment. Don't use them as real corporate or VPN addresses.

To customize a policy:

1. In Defender for Cloud, open **Just-in-time VM access** > **Configured**.
1. Right-click the VM and select **Edit**.
1. Select a port and set **Allowed source IPs** to an approved address or range, such as `203.0.113.0/24`, instead of leaving **Any** where a narrower restriction is required.
1. Set the protocol and maximum request time. Select **Add** if an additional port is required, then configure its settings. For example, a database administration workflow might require TCP 5432 from the database team's approved subnet.
1. Confirm port edits with **OK**. When you finish adding, removing, or editing entries, select **Save**. Reopen the configuration to confirm the intended values and check the resulting effective network rules.

Removing a port changes its JIT-managed configuration. Don't assume the resulting network rules leave it either open or blocked. If the requirement is to keep the port inaccessible, establish and verify the replacement network restriction as part of the controlled change before removing JIT protection. Save the change and inspect the resulting effective rules again.

Source restrictions narrow which network addresses can use a grant. Maximum request time controls the duration of a network-access window, not the lifetime of an established session. Contoso chooses one-hour limits for production and three-hour limits for development and testing. These are organizational choices, not universal defaults.

## Enable JIT programmatically

> [!IMPORTANT]
> The following PowerShell configuration example is for a JIT policy whose VM entries use NSGs without Azure Firewall integration. The typed VM model used by `Get-AzJitNetworkAccessPolicy` and `Set-AzJitNetworkAccessPolicy` doesn't include the `publicIpAddress` field that associates an Azure Firewall with a VM entry. A Get-to-Set round trip therefore isn't a complete representation of a Firewall-linked policy. If any entry in a shared policy uses that integration, use the Defender for Cloud portal or an appropriate deployment or REST workflow that supports the full configuration. Don't add an unsupported `publicIpAddress` property to the cmdlet's VM hashtable.

Automation can configure JIT with `Set-AzJitNetworkAccessPolicy`, a supported JIT deployment resource, or the REST API. Run the following example in Azure Cloud Shell with PowerShell, or in an authenticated local session with the required Az modules and permissions. Select the intended subscription and replace the subscription, resource-group, VM, location, and policy-name placeholders. Use the actual location of the intended JIT policy.

This example supplies one VM's configuration. Before updating an existing NSG-only policy, retrieve it with `Get-AzJitNetworkAccessPolicy` and review every VM and port entry. Preserve unaffected entries in the complete intended configuration rather than treating `Set-AzJitNetworkAccessPolicy` as an append-only operation. For a policy with Azure Firewall integration, review and preserve the Firewall association and all other intended configuration fields through the chosen portal, deployment, or REST workflow.

```powershell
$JitPolicy = @{
    id = "/subscriptions/SUBSCRIPTION_ID/resourceGroups/RESOURCE_GROUP/providers/Microsoft.Compute/virtualMachines/VM_NAME"
    ports = @(@{
        number = 22
        protocol = "TCP"
        allowedSourceAddressPrefixes = [string[]]@("203.0.113.0/24")
        maxRequestAccessDuration = "PT1H"
    })
}

$JitPolicyArr = @($JitPolicy)
Set-AzJitNetworkAccessPolicy `
    -ResourceGroupName "RESOURCE_GROUP" `
    -Location "POLICY_LOCATION" `
    -Kind "Basic" `
    -Name "JIT_POLICY_NAME" `
    -VirtualMachine $JitPolicyArr `
    -ErrorAction Stop
```

The configuration protects TCP port 22 with a one-hour maximum request and the example office source range. `maxRequestAccessDuration` uses ISO 8601 duration format, so `PT1H` represents one hour. The explicit `[string[]]` value binds to the cmdlet's typed source-prefix list. For a single prefix, a scalar `allowedSourceAddressPrefix` is also supported, but don't populate both the singular and plural properties.

> [!WARNING]
> Coordinate changes to shared policies and prevent simultaneous deployments from overwriting one another. Confirm the saved VM and port configuration and the resulting effective rules after an update. Don't delete a shared policy to remove only one VM.

The combined length of the JIT policy name and VM name can't exceed 56 characters. If provisioning fails, check these names as well as the reported error details.

## Validate the configured access paths

Coordinate effective-rule inspection and any NSG changes with a network administrator, or use the separately scoped permissions described in the preceding unit. JIT configuration permissions alone don't authorize these operations.

After saving the policy, verify the intended baseline before requesting access:

1. Record the VM, management ports, connection path, and permitted sources. Review the current JIT policy and network rules.
1. For a running VM, open each relevant NIC's **Effective security rules** and inspect the subnet and NIC NSGs. Review other applicable controls, including Azure Firewall and security admin rules, where present. Resolve broad or overriding allows without disrupting approved workload traffic.
1. With no active direct-access grant, attempt a new connection through the direct path from a source that should be denied. Confirm that the separate approved Bastion path still works if it's retained by design.

> [!IMPORTANT]
> **Configured** isn't proof that broad access has been removed. Check effective rules and test new connections before declaring the audit finding resolved. Coordinate changes to shared subnet NSGs so that unrelated workloads and the intended Bastion path continue to work.

Next, request a narrow access window and verify the behavior during and after that grant.
