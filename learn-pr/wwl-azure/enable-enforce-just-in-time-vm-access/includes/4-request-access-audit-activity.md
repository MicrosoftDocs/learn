To use the direct management path protected by just-in-time (JIT) access, submit a request that specifies the ports, connection source, and time window. Defender for Cloud checks your authorization and the configured policy before granting network access. The grant doesn't replace guest OS authentication, and existing effective network rules can still provide other access paths.

Review all three request parameters before submitting.

| Request parameter | Purpose | Example value |
| --- | --- | --- |
| Ports | Which configured management ports to open | 3389 for RDP or 22 for SSH |
| Source IP | Address or range permitted to connect | `203.0.113.45`, a documentation example to replace |
| Time window | Duration of the network-access grant | One hour, within the configured maximum |

## Request JIT access from Defender for Cloud

To request a network-access window for the selected VMs:

1. In Defender for Cloud, open **Workload protections** > **Just-in-time VM access** > **Configured**.
1. Select the VMs, then select **Request access**.
1. Select only the required ports, such as RDP 3389 for a Windows administration task or SSH 22 for a Linux task.
1. Set the connection source and time range. The requested duration must be within the policy's `maxRequestAccessDuration`.
1. Select **Open ports**, then review the grant and the returned connection details before connecting.

Choose the source address that the VM's access path will see. For direct internet access, this is commonly the public egress address of your workstation, office, proxy, or VPN. Use one address when that's sufficient rather than automatically opening an entire corporate range. A private routed connection can have a private source address. Verify the actual path instead of assuming that the browser's detected public IP is always correct.

For a VM reached through Azure Firewall, use the connection endpoint and DNAT mapped port returned by JIT. Don't assume that the endpoint is the VM's public IP or that the external mapped port is the guest's management port.

When the window expires, Defender for Cloud restores the network rules. Established sessions aren't interrupted. Test a new connection against the resulting rules when checking expiration.

## Request access from the VM's Connect page

The VM's **Connect** page provides another entry point for requesting direct access. To request access from this page:

1. Open the target VM and its **Connect** page.
1. For the direct connection path covered by this procedure, select **Request access** when JIT is enabled.
1. Review the requested port, source, and time range, and submit the request.
1. After the grant, use the connection details appropriate to the selected direct-access method, including the returned DNAT mapping if Azure Firewall provides the path.

### Keep the Bastion path separate

Contoso retains Bastion for normal administration and uses JIT for exceptional direct access. The Bastion connection experience is separate from the direct-access example. Don't assume that it presents the same JIT request fields or returns an RDP download.

> [!IMPORTANT]
> This scenario uses a dedicated Azure Bastion deployment. Bastion connects to the VM's private IP, and the target VM must allow the required RDP or SSH traffic from that deployment's AzureBastionSubnet address range. The browser user's public IP isn't the source of that connection. A persistent allow restricted to the approved Bastion path is still standing network access and must be documented as such.
>
> Bastion Developer uses shared infrastructure and doesn't require an AzureBastionSubnet. The subnet-scoped exception in this scenario isn't a configuration procedure for that SKU.

If your requirement is also to time-gate traffic from the dedicated Bastion deployment, design the restriction for its AzureBastionSubnet source range and validate the effective rules. A persistent allow for that range doesn't meet a zero-standing-access requirement.

## Validate the access window

Continue the baseline checks from the preceding unit:

1. Request one required port from a narrow permitted source for a short window.
1. Test the direct path with new connections from that source and from a second source that isn't authorized by any grant or intended persistent exception. Confirm that the first connection works and the second is denied. Don't classify intentionally permitted Bastion traffic as an unauthorized direct connection.
1. If the grant succeeds but connection fails, check the selected source, route, effective rules, guest firewall, service listener, and guest access rights. For Firewall-based access, use the endpoint and mapped port returned by JIT.
1. After expiration, make a fresh connection attempt over the direct path. Confirm it's denied if no other effective access path is intended. Don't use an already-established session as the expiration test.

> [!NOTE]
> A successful JIT request doesn't create a public IP address or a working network route, and it doesn't start the guest's RDP or SSH service. Use a connection path that actually exists in your environment.

## Request JIT access programmatically

Automation can request access with `Start-AzJitNetworkAccessPolicy`. Use the authenticated PowerShell environment described in the preceding unit. Replace the placeholders with the actual policy and VM identifiers in the selected subscription, and replace the documentation address with the approved connection source.

```powershell
$request = Start-AzJitNetworkAccessPolicy `
    -ResourceGroupName "RESOURCE_GROUP" `
    -Location "POLICY_LOCATION" `
    -Name "JIT_POLICY_NAME" `
    -VirtualMachine @(@{
        id="/subscriptions/SUBSCRIPTION_ID/resourceGroups/RESOURCE_GROUP/providers/Microsoft.Compute/virtualMachines/VM_NAME";
        ports=@(@{
            number=22;
            allowedSourceAddressPrefix=@("203.0.113.50");
            endTimeUtc=(Get-Date).AddHours(1).ToUniversalTime()
        })
    }) `
    -ErrorAction Stop

$request | ConvertTo-Json -Depth 10
```

This requests SSH port 22 from the example source `203.0.113.50` for one hour. `endTimeUtc` specifies the expiration using UTC time. The automation identity needs the documented JIT request actions at scopes covering the policy and relevant VM and network resources. Security Reader alone is insufficient.

> [!IMPORTANT]
> An accepted initiation request isn't proof that the requested network access is ready. The service can return HTTP 202 with a per-port status such as `Initiating`. `-ErrorAction Stop` surfaces cmdlet errors, but it doesn't replace checking the returned request and the effective network path.

Inspect the returned VM and port records for the intended VM ID, port, permitted source, expiration, `Status`, and `StatusReason`. If initiation is still in progress, read the policy's available request records with `Get-AzJitNetworkAccessPolicy`, as shown in the auditing section, and correlate the intended request using its request time, requester, VM, port, source, and expiration. Don't assume that the first request record is the current one.

Before reporting usable access, complete the effective-rule and new-connection checks in **Validate the access window**. A pending, revoked, missing, or unexpected status isn't proof of usable access. Automated workflows should use a bounded wait, report an unresolved result explicitly, and avoid automatically resubmitting initiation just to check progress.

> [!NOTE]
> The typed request-port objects exposed by `Start-AzJitNetworkAccessPolicy` and `Get-AzJitNetworkAccessPolicy` don't include the Azure Firewall `mappedPort` field. For a Firewall-backed connection, obtain the connection details from Defender for Cloud's JIT portal experience or inspect the full JIT service response through REST. Match the VM, requested port, and current grant before using its Firewall endpoint and mapped port. Don't assume the mapped port equals the guest's management port.

## Audit JIT access activity

Use Activity Log for JIT control-plane operations, then correlate those operations with the available JIT request records when you need the granted sources, ports, and expiration.

Use an account with Activity Log read access, such as Monitoring Reader, and separate access to the JIT policy for request details. JIT request permissions alone don't provide Activity Log access.

To review JIT activity in the portal:

1. Open Defender for Cloud > **Just-in-time VM access** > **Configured**.
1. Open the ellipsis menu at the end of the target VM's row.
1. Select **Activity Log** and review the filtered operations.
1. Select the required time range and inspect event status and details. Select **Download as CSV** if you need an export.

If you start from a subscription or resource-group Activity Log instead, select the relevant `Microsoft.Security/locations/jitNetworkAccessPolicies` resource. If you start from the VM's ordinary Activity Log, remove the VM-only resource filter before looking for operations on that separate policy resource.

Review initiate, write, and delete operations for the policy. Check the caller, time, operation status, resource ID, and available details. Don't assume every event contains the requested connection source, all ports, and expiration. An API caller IP, when present, isn't necessarily the source granted access to the VM.

A policy can include multiple VMs. Deleting the policy isn't the same operation as removing one VM or port from its configuration. Review the affected resource and its full configuration when interpreting an event.

You can read a policy's available request records with PowerShell:

```powershell
$policy = Get-AzJitNetworkAccessPolicy `
    -ResourceGroupName "RESOURCE_GROUP" `
    -Location "POLICY_LOCATION" `
    -Name "JIT_POLICY_NAME" `
    -ErrorAction Stop

$policy.Requests | ConvertTo-Json -Depth 10
```

Replace the placeholders with the actual policy identifiers. Review the request and its VM and port records for the requester, time, permitted source, and expiration. This command doesn't create a durable archive or prove a successful guest login. Use guest authentication and session records when the review requires evidence of actual VM use.

Review each relevant port's `Status`, `StatusReason`, and expiration when interpreting a request. A record of an earlier request isn't evidence of a current grant.

`$policy.Requests` is a typed view of the available request records, not the complete service response. Use a full REST response when required evidence includes fields that this model doesn't expose, such as a Firewall port mapping.

### Retain evidence for quarterly reviews

Contoso reviews management access quarterly, so the security team must plan retention before collecting the evidence.

> [!IMPORTANT]
> Activity Log retains events for 90 days by default. A quarterly review can extend beyond that window. Before the review period begins, have a monitoring administrator configure a subscription Activity Log diagnostic setting to export the required events to an approved destination, such as a Log Analytics workspace or Azure Storage, and set retention to meet your organization's requirements. The administrator needs diagnostic-setting write permissions on the source subscription and the permissions required by the selected destination.

Include the relevant administrative operations, protect access to the destination, and confirm events are arriving. If the requirement includes exact granted sources, ports, or durations, preserve the necessary JIT request details rather than assuming every exported event contains them. Collect guest authentication or session records separately when required.

## Monitor and operationalize JIT adoption

The built-in **Management ports of virtual machines should be protected with just-in-time network access control** audits a Defender for Cloud assessment for Azure VM resources. It supports `AuditIfNotExists` and `Disabled`. It doesn't enable JIT, modify NSGs, or block VM creation.

The definition targets `Microsoft.Compute/virtualMachines` and checks whether the associated assessment is `Healthy` or `NotApplicable`. A compliant result doesn't prove that every VM has JIT configured. Inspect the recommendation and the VM's configuration to understand the result. This Azure-VM policy isn't an AWS inventory control.

Have a policy administrator with assignment permissions at the intended scope perform this step. To assign the policy, open **Azure Policy** > **Definitions**, search for "just-in-time network access," and select the built-in definition. Select **Assign** and choose the scope. Contoso uses a management-group assignment for the relevant factory subscriptions, including future subscriptions in that hierarchy. The administrator needs rights at that management group, not just a child subscription.

Azure Policy applies a new assignment to its scope in about five minutes and then begins evaluating applicable resources. Evaluation has no fixed completion time. Assignments are automatically reevaluated once every 24 hours, and other events can trigger evaluations. Review **Azure Policy** > **Compliance** after processing completes. Because this definition uses a Defender for Cloud assessment, the result also depends on the available assessment state.

Combine assessment-based monitoring with an explicit adoption workflow:

1. Assign the audit definition at the intended scope. Confirm that the relevant subscriptions meet the Defender for Servers Plan 2 prerequisite and review each target VM's effective coverage, including resource-level overrides. Resolve conflicting coverage through the authorized plan administrator or record an approved exception.
1. Add JIT configuration to the approved VM provisioning workflow after the VM and its network controls exist. Use the preceding PowerShell configuration example for an NSG-only policy. Where supported Azure Firewall integration is required, use a deployment or REST workflow that represents the Firewall association as well as every intended VM and port entry. The supported deployment resource is `Microsoft.Security/locations/jitNetworkAccessPolicies@2020-01-01`.
1. Supply the actual target VM IDs, policy location, approved management ports, permitted sources, and maximum durations. Use an authorized deployment identity, preserve unaffected configuration, and coordinate updates to shared policies.
1. Make successful configuration and the required network-access checks a release condition. A failed JIT step must fail the workflow rather than be reported as a successful protected deployment.
1. Review the audit results and a separate inventory of required JIT configurations for existing resources and drift. Apply controlled changes to eligible VMs and record justified exceptions, including resources whose assessment isn't applicable. Include resource-level plan overrides in the inventory so a later downgrade or exclusion isn't hidden by the subscription's Plan 2 setting.

> [!NOTE]
> This is a deployment-workflow control combined with monitoring, not a deny effect or automatic remediation supplied by the audit built-in. Changes outside the approved workflow need separate governance. Azure Policy remediation tasks apply to `DeployIfNotExists` and `Modify`, not this audit definition. A custom deploying policy would be a separate design, not an effect you can select on this built-in.
