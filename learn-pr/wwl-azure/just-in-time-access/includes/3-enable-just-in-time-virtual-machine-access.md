You can use Microsoft Defender for Cloud's just-in-time (JIT) access to protect your Azure virtual machines (VMs) from unauthorized network access. Many times firewalls contain allow rules that leave your VMs vulnerable to attack. JIT lets you allow access to your VMs only when the access is needed, on the ports needed, and for the period of time needed.

Learn more about [how JIT works](/azure/defender-for-cloud/just-in-time-access-overview) and the [permissions required to configure and use JIT](/azure/defender-for-cloud/just-in-time-access-usage#prerequisites).

In this article, you learn how to include JIT in your security program, including how to:

 -  Enable JIT on your VMs from the Azure portal or programmatically
 -  Request access to a VM that has JIT enabled from the Azure portal or programmatically
 -  [Audit the JIT activity](/azure/defender-for-cloud/just-in-time-access-usage#audit-jit-access-activity-in-defender-for-cloud) to make sure your VMs are secured appropriately

## Availability

| **Aspect**                      | **Details**                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| ------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Release state:                  | General availability (GA)                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| Supported VMs:                  | Yes - VMs deployed through Azure Resource Manager<br>No - VMs deployed with [classic deployment models](/azure/azure-resource-manager/management/deployment-models)<br>Yes - VMs protected by Azure Firewalls on the same VNET as the VM<br>No - VMs protected by Azure Firewalls controlled by [Azure Firewall Manager](/azure/firewall-manager/overview)<br>Yes - AWS EC2 instances (Preview) |
| Required roles and permissions: | Reader, SecurityReader, or a [custom role](/azure/defender-for-cloud/just-in-time-access-usage#prerequisites) can view the JIT status and parameters.<br>To create a least-privileged role for users that only need to request JIT access to a VM, use the [Set-JitLeastPrivilegedRole script](https://github.com/Azure/Microsoft-Defender-for-Cloud/tree/main/Powershell%20scripts/JIT%20Scripts/JIT%20Custom%20Role).          |
| Clouds:                         | Yes - Commercial clouds<br>Yes - National (Azure Government, Microsoft Azure operated by 21Vianet)<br>Yes - Connected AWS accounts (preview)                                                                                                                                                                                                                                                                                                                      |

## Prerequisites

 -  JIT requires [Microsoft Defender for Servers Plan 2](/azure/defender-for-cloud/plan-defender-for-servers-select-plan#plan-features) to be enabled on the subscription.
 -  Reader and SecurityReader roles can both view the JIT status and parameters.
 -  If you want to create custom roles that work with JIT, you need the details from the following table:

| **To enable a user to:**                | **Permissions to set**                                                                                                                                                                                                                                                                                     |
| --------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Configure or edit a JIT policy for a VM | Assign these actions to the user:`Microsoft.Security/locations/jitNetworkAccessPolicies/read``Microsoft.Security/locations/jitNetworkAccessPolicies/initiate/action``Microsoft.Security/policies/read``Microsoft.Security/pricings/read``Microsoft.Compute/virtualMachines/read``Microsoft.Network/*/read` |
| Request JIT access to a VM              | Assign these actions to the user:`Microsoft.Security/locations/jitNetworkAccessPolicies/initiate/action``Microsoft.Security/locations/jitNetworkAccessPolicies/*/read``Microsoft.Compute/virtualMachines/read``Microsoft.Network/networkInterfaces/*/read``Microsoft.Network/publicIPAddresses/read`       |
| Read JIT policies                       | Assign these actions to the user:`Microsoft.Security/locations/jitNetworkAccessPolicies/read``Microsoft.Security/locations/jitNetworkAccessPolicies/initiate/action``Microsoft.Security/policies/read``Microsoft.Security/pricings/read``Microsoft.Compute/virtualMachines/read``Microsoft.Network/*/read` |

> [!NOTE]
> Only the `Microsoft.Security` permissions are relevant for AWS.

 -  To set up JIT on your Amazon Web Service (AWS) VM, you need to [connect your AWS account](/azure/defender-for-cloud/quickstart-onboard-aws) to Microsoft Defender for Cloud.

> [!TIP]
> To create a least-privileged role for users that need to request JIT access to a VM, and perform no other JIT operations, use the Set-JitLeastPrivilegedRole script from the Defender for Cloud GitHub community pages.

## Work with JIT VM access using Microsoft Defender for Cloud

> [!NOTE]
> In order to successfully create a custom JIT policy, the policy name, together with the targeted VM name, must not exceed a total of 56 characters.

You can use Defender for Cloud or you can programmatically enable JIT VM access with your own custom options, or you can enable JIT with default, hard-coded parameters from Azure virtual machines.

**Just-in-time VM access** shows your VMs grouped into:

 -  **Configured** \- VMs configured to support just-in-time VM access, and shows:
     -  the number of approved JIT requests in the last seven days
     -  the last access date and time
     -  the connection details configured
     -  the last user
 -  **Not configured** \- VMs without JIT enabled, but that can support JIT. We recommend that you enable JIT for these VMs.
 -  **Unsupported** \- VMs that don't support JIT because:
     -  Missing network security group (NSG) or Azure Firewall - JIT requires an NSG to be configured or a Firewall configuration (or both)
     -  Classic VM - JIT supports VMs that are deployed through Azure Resource Manager. [Learn more about classic vs Azure Resource Manager deployment models](/azure/azure-resource-manager/management/deployment-models).
     -  Other - The JIT solution is disabled in the security policy of the subscription or the resource group.

## Enable JIT on your VMs from Microsoft Defender for Cloud

:::image type="content" source="../media/configure-just-in-time-access-c9431ddd.gif" alt-text="Screenshot showing how to enable just in time virtual machine from Microsoft Defender for Cloud.":::


From Defender for Cloud, you can enable and configure the JIT VM access.

1.  Open the **Workload protections** and, in the advanced protections, select Just-in-time VM access.
2.  In the **Not configured** virtual machines tab, mark the VMs to protect with JIT and select Enable JIT on VMs. The JIT VM access page opens listing the ports that Defender for Cloud recommends protecting:
     -  22 - SSH
     -  3389 - RDP
     -  5985 - WinRM
     -  5986 - WinRM
3.  To customize the JIT access:
     -  Select **Add**.
     -  Select one of the ports in the list to edit it or enter other ports. For each port, you can set the:
         -  **Protocol** \- The protocol that is allowed on this port when a request is approved
         -  **Allowed source IPs** \- The IP ranges that are allowed on this port when a request is approved
         -  **Maximum request time** \- The maximum time window during which a specific port can be opened
4.  Select **OK**.
5.  To save the port configuration, select **Save**.

## Edit the JIT configuration on a JIT-enabled VM using Defender for Cloud

You can modify a VM's just-in-time configuration by adding and configuring a new port to protect for that VM, or by changing any other setting related to an already protected port.

To edit the existing JIT rules for a VM:

1.  Open the **Workload protections** and, in the advanced protections, select **Just-in-time VM access**.
2.  In the **Configured** virtual machines tab, right-click on a VM and select **Edit**.
3.  In the **JIT VM access configuration**, you can either edit the list of port or select Add a new custom port.
4.  When you finish editing the ports, select **Save**.

## Request access to a JIT-enabled VM from Microsoft Defender for Cloud

When a VM has a JIT enabled, you have to request access to connect to it. You can request access in any of the supported ways, regardless of how you enabled JIT.

1.  From the **Just-in-time VM access** page, select the **Configured** tab.
2.  Select the VMs you want to access:<br>
     -  The icon in the **Connection Details** column indicates whether JIT is enabled on the network security group or firewall. If it's enabled on both, only the firewall icon appears.<br>
     -  The **Connection Details** column shows the user and ports that can access the VM.<br>
3.  Select **Request access**. The **Request access** window opens.<br>
4.  Under **Request access**, select the ports that you want to open for each VM, the source IP addresses that you want the port opened on, and the time window to open the ports.<br>
5.  Select **Open ports**.<br>
    
    > [!NOTE]
    > If a user who is requesting access is behind a proxy, you can enter the IP address range of the proxy.

## Other ways to work with JIT VM access

### Azure virtual machines<br>

#### Enable JIT on your VMs from Azure virtual machines<br>

You can enable JIT on a VM from the Azure virtual machines pages of the Azure portal.

> [!TIP]
> If a VM already has JIT enabled, the VM configuration page shows that JIT is enabled. You can use the link to open the JIT VM access page in Defender for Cloud to view and change the settings.

1. From the [Azure portal](https://portal.azure.com/), search for and select **Virtual machines**.

2. Select the virtual machine you want to protect with JIT.

3. In the menu, select **Configuration**.

4. Under **Just-in-time access**, select **Enable just-in-time**. By default, just-in-time access for the VM uses these settings:

 -  Windows machines
     -  RDP port: 3389
     -  Maximum allowed access: Three hours
     -  Allowed source IP addresses: Any
 -  Linux machines
     -  SSH port: 22
     -  Maximum allowed access: Three hours
     -  Allowed source IP addresses: Any

5. To edit any of these values or add more ports to your JIT configuration, use Microsoft Defender for Cloud's just-in-time page:

 -  From Defender for Cloud's menu, select **Just-in-time VM access**.<br>
 -  From the Configured tab, right-click on the VM to which you want to add a port, and select **Edit**.<br>

:::image type="content" source="../media/virtual-machine-configuration-page-24446245.png" alt-text="Screenshot showing how to edit the virtual machine from the configuration page.":::


 -  **Under JIT VM access configuration**, you can either edit the existing settings of an already protected port or add a new custom port.
 -  When you've finished editing the ports, select **Save**.<br>

#### Request access to a JIT-enabled VM from the Azure virtual machine's connect page

When a VM has a JIT enabled, you have to request access to connect to it. You can request access in any of the supported ways, regardless of how you enabled JIT.

:::image type="content" source="../media/virtual-machine-test-page-51cfa082.png" alt-text="Screenshot showing how to request access to a just in time enabled virtual machine from the connect page.":::


To request access from Azure virtual machines:

1.  In the Azure portal, open the virtual machines pages.
2.  Select the VM to which you want to connect, and open the Connect page. Azure checks to see if JIT is enabled on that VM.
     -  If JIT isn't enabled for the VM, you're prompted to enable it.
     -  If JIT is enabled, select Request access to pass an access request with the requesting IP, time range, and ports that were configured for that VM.
    
    > [!NOTE]
    > After a request is approved for a VM protected by Azure Firewall, Defender for Cloud provides the user with the proper connection details (the port mapping from the DNAT table) to use to connect to the VM.

### PowerShell

#### Enable JIT on your VMs using PowerShell

To enable just-in-time VM access from PowerShell, use the official Microsoft Defender for Cloud PowerShell cmdlet `Set-AzJitNetworkAccessPolicy`.

**Example** \- Enable just-in-time VM access on a specific VM with the following rules:

 -  Close ports 22 and 3389
 -  Set a maximum time window of 3 hours for each so they can be opened per approved request
 -  Allow the user who is requesting access to control the source IP addresses
 -  Allow the user who is requesting access to establish a successful session upon an approved just-in-time access request

The following PowerShell commands create this JIT configuration:

1. Assign a variable that holds the just-in-time VM access rules for a VM:

```powershell
$JitPolicy = (@{ id="/subscriptions/SUBSCRIPTIONID/resourceGroups/RESOURCEGROUP/providers/Microsoft.Compute/virtualMachines/VMNAME"; ports=(@{ number=22; protocol="*"; allowedSourceAddressPrefix=@("*"); maxRequestAccessDuration="PT3H"}, @{ number=3389; protocol="*"; allowedSourceAddressPrefix=@("*"); maxRequestAccessDuration="PT3H"})})
```

2. Insert the VM just-in-time VM access rules into an array:

```powershell
$JitPolicyArr=@($JitPolicy)
```

3. Configure the just-in-time VM access rules on the selected VM:

```powershell
Set-AzJitNetworkAccessPolicy -Kind "Basic" -Location "LOCATION" -Name "default" -ResourceGroupName "RESOURCEGROUP" -VirtualMachine $JitPolicyArr
```

Use the -Name parameter to specify a VM. For example, to establish the JIT configuration for two different VMs, VM1 and VM2, use: `Set-AzJitNetworkAccessPolicy -Name VM1` and `Set-AzJitNetworkAccessPolicy -Name VM2`.

#### Request access to a JIT-enabled VM using PowerShell

In the following example, you can see a just-in-time VM access request to a specific VM for port 22, for a specific IP address, and for a specific amount of time:

Run the following commands in PowerShell:

1. Configure the VM request access properties:

```powershell
$JitPolicyVm1 = (@{ id="/subscriptions/SUBSCRIPTIONID/resourceGroups/RESOURCEGROUP/providers/Microsoft.Compute/virtualMachines/VMNAME"; ports=(@{ number=22; endTimeUtc="2020-07-15T17:00:00.3658798Z"; allowedSourceAddressPrefix=@("IPV4ADDRESS")})})
```

2. Insert the VM access request parameters in an array:

```powershell
$JitPolicyArr=@($JitPolicyVm1)
```

3. Send the request access (use the resource ID from step 1)

```powershell
Start-AzJitNetworkAccessPolicy -ResourceId "/subscriptions/SUBSCRIPTIONID/resourceGroups/RESOURCEGROUP/providers/Microsoft.Security/locations/LOCATION/jitNetworkAccessPolicies/default" -VirtualMachine $JitPolicyArr
```

Learn more in the [PowerShell cmdlet documentation](/powershell/scripting/developer/cmdlet/cmdlet-overview).<br>
