After Just-in-Time (JIT) is enabled on a virtual machine, connecting to the VM requires submitting an access request that specifies which ports to open, the source IP address, and the duration of access. Defender for Cloud evaluates the request against the configured JIT policy and, if approved, creates a temporary NSG ALLOW rule with the specified parameters. This request-and-grant workflow ensures that management ports remain closed except during verified administrative sessions.

| Request Parameter | Purpose | Example Value |
|-------------------|---------|---------------|
| Ports | Which management ports to open | 3389 (RDP), 22 (SSH) |
| Source IP | IP address or range allowed to connect | 203.0.113.45 or 203.0.113.0/24 |
| Time window | How long the port remains open | One hour, 3 hours (up to 24 hours max) |

## Request JIT access from Defender for Cloud

The centralized JIT interface provides a streamlined workflow for requesting access to protected virtual machines. Navigate to Defender for Cloud → **Workload protections** → **Just-in-time VM access** → **Configured** tab. This view displays all VMs with active JIT policies.

Select the virtual machine you want to access and select **Request access** from the command bar. The request form displays the ports configured in the JIT policy with toggles to enable or disable each port. Select the ports you need—for a Windows VM, you typically select only port 3389 (RDP); for Linux, only port 22 (SSH).

The **My IP** field autopopulates with your current public IP address as detected by Azure. This value works correctly for direct internet connections but requires adjustment if you connect through a corporate proxy or VPN. For Contoso Manufacturing administrators working from the office, the source IP must be set to the office network's public IP range (203.0.113.0/24) rather than the individual workstation's private IP address.

The **Time range** field specifies how long the port remains open. Select a duration appropriate for your task—one hour for a quick configuration check, 3 hours for troubleshooting sessions. The maximum value is constrained by the JIT policy's `maxRequestAccessDuration` parameter. After setting all parameters, select **Open ports**.

Defender for Cloud creates the temporary NSG ALLOW rule within seconds. The connection details panel updates to show the open ports and the approved time window. You can now connect to the VM using RDP, SSH, or the specified protocol. The connection succeeds only from the approved source IP and only until the time window expires.

## Request JIT access from the VMConnect page

For operators who start their workflow from the virtual machine view rather than the Defender for Cloud security center, the VMConnect page provides an integrated JIT request interface. Navigate to the virtual machine in the Azure portal. Next select **Connect** from the command bar, then choose your connection method (RDP, SSH, or Bastion).

If the VM has JIT enabled, the connection page displays a **Request access** option before showing connection details. Select **Request access**, specify the time window and source IP (ports are preselected based on the connection type), then select **Request**. After Defender for Cloud grants access, the connection details page updates with the RDP file download link or SSH connection string.

This workflow reduces friction for administrators who manage VMs individually and expect to connect directly from the VM's overview page. The experience feels similar to non-JIT VMs, with the access request step inserted transparently into the connection workflow.

## Request JIT access programmatically

Automation scripts and deployment pipelines can request JIT access using the `Start-AzJitNetworkAccessPolicy` PowerShell cmdlet. This capability supports scenarios where administrative tasks run on a scheduled basis or require scripted access:

```powershell
Start-AzJitNetworkAccessPolicy `
    -ResourceGroupName "contoso-factory-rg" `
    -Location "eastus" `
    -Name "JIT_POLICY_NAME" `
    -VirtualMachine @(@{
        id="/subscriptions/SUBSCRIPTION_ID/resourceGroups/contoso-factory-rg/providers/Microsoft.Compute/virtualMachines/factory-vm-01";
        ports=@(@{
            number=22;
            allowedSourceAddressPrefix=@("203.0.113.50");
            endTimeUtc=(Get-Date).AddHours(1).ToUniversalTime()
        })
    })
```

This script requests SSH access (port 22) from source IP 203.0.113.50 for a one-hour window. The `endTimeUtc` parameter specifies when the access expires using UTC time. Automation accounts running this script must have the appropriate Azure RBAC permissions to request JIT access (Security Reader role at minimum, or a custom role with `Microsoft.Security/locations/jitNetworkAccessPolicies/initiate/action` permission).

## Audit JIT access activity

Each JIT access request (approval, and port opening event) is recorded in the Azure Activity Log, providing a complete audit trail for security reviews and compliance reporting. Navigate to the virtual machine or resource group, select **Activity log** from the left navigation, then filter for **Resource type: JitNetworkAccessPolicy**.

The Activity Log displays entries for each JIT event:

- **Initiate JIT Network Access**: User submitted a JIT access request
- **Update JIT Network Access Policy**: Policy configuration was modified
- **Delete JIT Network Access Policy**: JIT was disabled on the VM

Each entry includes the caller identity (who requested access), timestamp, source IP address, ports opened, and the approved time window. For Contoso Manufacturing's compliance requirements, this audit data feeds into the quarterly security review process, where the security team validates that JIT access patterns align with approved maintenance schedules.

Defender for Cloud also provides a connection history view directly in the JIT interface. Navigate to **Just-in-time VM access** → **Configured** tab, select a virtual machine, and review the **Request history** section. This view summarizes recent access requests with approval status, requester identity, and time windows, providing quick visibility into access patterns without navigating to the Activity Log.

## Enforce JIT adoption with Azure Policy

Manual JIT enablement addresses existing virtual machines but doesn't prevent new VMs from being deployed with permanently open management ports. Azure Policy provides the enforcement mechanism to drive organization-wide JIT adoption and identify noncompliant resources at scale.

The built-in policy **"Management ports of virtual machines should be protected with just-in-time network access control"** audits all virtual machines in the assigned scope and identifies VMs that have management ports open without JIT protection. This policy uses the AuditIfNotExists effect—it doesn't automatically enable JIT, but it surfaces noncompliant resources in the Policy compliance dashboard.

To assign this policy, navigate to **Azure Policy** → **Definitions**, search for "just-in-time network access," and select the built-in policy. Select **Assign** and choose the scope—Contoso Manufacturing assigns the policy at the management group level to cover all factory subscriptions automatically, including future subscriptions added to the hierarchy.

After assignment, Azure Policy evaluates all VMs in scope during the next evaluation cycle (typically within 30 minutes, with full scans every 24 hours). Navigate to **Azure Policy** → **Compliance** to view the compliance state. Noncompliant VMs appear in the resource list with details about which management ports are open without JIT protection.

The security operations team uses this compliance report to prioritize JIT enablement. Each week, the team exports the noncompliant VM list, groups VMs by resource group and owner, and sends remediation requests to the responsible teams. This workflow ensures that JIT adoption remains current as new VMs are deployed, with the policy assignment acting as a continuous control rather than a one-time deployment effort.
