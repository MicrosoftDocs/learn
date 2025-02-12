[Defender for Servers](/azure/defender-for-cloud/defender-for-servers-overview) in Microsoft Defender for Cloud provides a just-in-time machine access feature.

You can use Microsoft Defender for Cloud's just-in-time access to protect your Azure VMs from unauthorized network access. Many times firewalls contain allow rules that leave your VMs vulnerable to attack. JIT lets you allow access to your VMs only when the access is needed, on the ports needed, and for the period of time needed.

In this unit, you learn how to set up and use just-in-time access, including how to:

 -  Enable just-in-time on VMs from the Azure portal or programmatically
 -  Request access to a VM that has just-in-time access enabled from the Azure portal or programmatically
 -  [Audit just-in-time access activity](/azure/defender-for-cloud/just-in-time-access-usage#audit-jit-access-activity-in-defender-for-cloud) to make sure your VMs are secured appropriately

## Prerequisites

 -  [Microsoft Defender for Servers Plan 2](/azure/defender-for-cloud/defender-for-servers-overview) must be enabled on the subscription.
 -  Supported VMs: VMs deployed through Azure Resource Manager, VMs protected by Azure Firewalls on the same VNET as the VM, AWS EC2 instances (Preview)
 -  Unsupported VMs: VMs deployed with [classic deployment models](/azure/azure-resource-manager/management/deployment-models), VMs protected by Azure Firewalls controlled by [Azure Firewall Manager](/azure/firewall-manager/overview)
 -  To set up just-in-time access on your AWS VMs, you need to [connect your AWS account](/azure/defender-for-cloud/quickstart-onboard-aws) to Microsoft Defender for Cloud.
 -  To JIT policy, the policy name, together with the targeted VM name, must not exceed a total of 56 characters.
 -  You need Reader and SecurityReader permissions, or a custom role can view the JIT status and parameters.
 -  For a custom role, assign the permissions summarized in the table. To create a least-privileged role for users that only need to request JIT access to a VM, use the [Set-JitLeastPrivilegedRole script](https://github.com/Azure/Microsoft-Defender-for-Cloud/tree/main/Powershell%20scripts/JIT%20Scripts/JIT%20Custom%20Role).
    
    | **User action**                         | **Permissions to set**                                                                                                                                                                                                                                                                                                                                                         |
    | --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
    | Configure or edit a JIT policy for a VM | **Assign these actions to the role**:<br>On the scope of a subscription (or resource group when using API or PowerShell only) that is associated with the VM:<br>Microsoft.Security/locations/jitNetworkAccessPolicies/write<br><br>On the scope of a subscription (or resource group when using API or PowerShell only) of VM:<br>Microsoft.Compute/virtualMachines/write<br> |
    | Request JIT access to a VM              | **Assign these actions to the user**:<br>Microsoft.Security/locations/jitNetworkAccessPolicies/initiate/action<br>Microsoft.Security/locations/jitNetworkAccessPolicies/\*/read<br>Microsoft.Compute/virtualMachines/read<br>Microsoft.Network/networkInterfaces/\*/read<br>Microsoft.Network/publicIPAddresses/read<br>                                                       |
    | Read JIT policies                       | **Assign these actions to the user**:<br>Microsoft.Security/locations/jitNetworkAccessPolicies/read<br>Microsoft.Security/locations/jitNetworkAccessPolicies/initiate/action<br>Microsoft.Security/policies/read<br>Microsoft.Security/pricings/read<br>Microsoft.Compute/virtualMachines/read<br>Microsoft.Network/\*/read<br>                                                |
    
    > [!NOTE]
    > Only the Microsoft.Security permissions are relevant for AWS. To create a least-privileged role for users that only need to request JIT access to a VM, use the Set-JitLeastPrivilegedRole script.

## Work with JIT VM access using Microsoft Defender for Cloud

You can use Defender for Cloud or you can programmatically enable JIT VM access with your own custom options, or you can enable JIT with default, hard-coded parameters from Azure virtual machines.

Just-in-time VM access shows your VMs grouped into:

 -  Configured - VMs configured to support just-in-time VM access, and shows:
     -  the number of approved JIT requests in the last seven days
     -  the last access date and time
     -  the connection details configured
     -  the last user
 -  Not configured - VMs without JIT enabled, but that can support JIT. We recommend that you enable JIT for these VMs.
 -  Unsupported - VMs that don't support JIT because:
     -  Missing network security group (NSG) or Azure Firewall - JIT requires an NSG to be configured or a Firewall configuration (or both)
     -  Classic VM - JIT supports VMs that are deployed through Azure Resource Manager.
     -  Other - The JIT solution is disabled in the security policy of the subscription or the resource group.

### Enable JIT on your VMs from Microsoft Defender for Cloud

From Defender for Cloud, you can enable and configure the JIT VM access.

1.  Open the Workload protections and, in the advanced protections, select Just-in-time VM access.
2.  In the Not configured virtual machines tab, mark the VMs to protect with JIT and select Enable JIT on VMs.
    
    The JIT VM access page opens listing the ports that Defender for Cloud recommends protecting:
    
    
     -  22 - SSH
     -  3389 - RDP
     -  5985 - WinRM
     -  5986 - WinRM
    
    To customize the JIT access:
    
    
     -  Select Add.
     -  Select one of the ports in the list to edit it or enter other ports. For each port, you can set the:
        
        
         -  Protocol - The protocol that is allowed on this port when a request is approved
         -  Allowed source IPs - The IP ranges that are allowed on this port when a request is approved
         -  Maximum request time - The maximum time window during which a specific port can be opened
     -  Select OK.
3.  To save the port configuration, select Save.

### Edit the JIT configuration on a JIT-enabled VM using Defender for Cloud

You can modify a VM's just-in-time configuration by adding and configuring a new port to protect for that VM, or by changing any other setting related to an already protected port.

To edit the existing JIT rules for a VM:

1.  Open the Workload protections and, in the advanced protections, select Just-in-time VM access.
2.  In the Configured virtual machines tab, right-click on a VM and select Edit.
3.  In the JIT VM access configuration, you can either edit the list of port or select Add a new custom port.
4.  When you finish editing the ports, select Save.

### Request access to a JIT-enabled VM from Microsoft Defender for Cloud

When a VM has a JIT enabled, you have to request access to connect to it. You can request access in any of the supported ways, regardless of how you enabled JIT.

1.  From the Just-in-time VM access page, select the Configured tab.
2.  Select the VMs you want to access:
    
    
     -  The icon in the Connection Details column indicates whether JIT is enabled on the network security group or firewall. If it's enabled on both, only the firewall icon appears.
     -  The Connection Details column shows the user and ports that can access the VM.
3.  Select Request access. The Request access window opens.
4.  Under Request access, select the ports that you want to open for each VM, the source IP addresses that you want the port opened on, and the time window to open the ports.
5.  Select Open ports.
    
    > [!NOTE]
    > If a user who is requesting access is behind a proxy, you can enter the IP address range of the proxy.

## Other ways to work with JIT VM access

### Azure virtual machines

#### Enable JIT on your VMs from Azure virtual machines

You can enable JIT on a VM from the Azure virtual machines pages of the Azure portal.

> [!TIP]
> If a VM already has JIT enabled, the VM configuration page shows that JIT is enabled. You can use the link to open the JIT VM access page in Defender for Cloud to view and change the settings.

1.  From the [Azure portal](https://portal.azure.com/), search for and select Virtual machines.
2.  Select the virtual machine you want to protect with JIT.
3.  In the menu, select Configuration.
4.  Under Just-in-time access, select Enable just-in-time.
    
    By default, just-in-time access for the VM uses these settings:
    
    
     -  Windows machines
         -  RDP port: 3389
         -  Maximum allowed access: Three hours
         -  Allowed source IP addresses: Any
     -  Linux machines
         -  SSH port: 22
         -  Maximum allowed access: Three hours
         -  Allowed source IP addresses: Any
5.  To edit any of these values or add more ports to your JIT configuration, use Microsoft Defender for Cloud's just-in-time page:
    
    
    1.  From Defender for Cloud's menu, select Just-in-time VM access.
    2.  From the Configured tab, right-click on the VM to which you want to add a port, and select Edit.
    3.  Under JIT VM access configuration, you can either edit the existing settings of an already protected port or add a new custom port.
    4.  When you've finished editing the ports, select Save.

#### Request access to a JIT-enabled VM from the Azure virtual machine's connect page

When a VM has a JIT enabled, you have to request access to connect to it. You can request access in any of the supported ways, regardless of how you enabled JIT.

To request access from Azure virtual machines:

1.  In the Azure portal, open the virtual machines pages.
2.  Select the VM to which you want to connect, and open the Connect page.
    
    Azure checks to see if JIT is enabled on that VM.
    
    
     -  If JIT isn't enabled for the VM, you're prompted to enable it.
     -  If JIT is enabled, select Request access to pass an access request with the requesting IP, time range, and ports that were configured for that VM.

> [!NOTE]
> After a request is approved for a VM protected by Azure Firewall, Defender for Cloud provides the user with the proper connection details (the port mapping from the DNAT table) to use to connect to the VM.
