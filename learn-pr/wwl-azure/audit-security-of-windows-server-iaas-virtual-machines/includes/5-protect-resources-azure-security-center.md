Management ports such as Remote Desktop Protocol (RDP), Secure Shell (SSH), and Windows Remote Management (WinRM) are common targets for attackers. If these ports are open for long periods, threat actors can discover them through scanning and attempt brute-force or exploitation attacks.

Microsoft Defender for Cloud includes just-in-time (JIT) VM access with Defender for Servers Plan 2. JIT VM access helps reduce exposure by closing selected management ports by default and opening them only when an approved user requests access for a specific source IP address and time window.

## How JIT VM access works

When you enable JIT VM access for an Azure VM, Defender for Cloud configures network security group (NSG) and Azure Firewall rules to block inbound traffic on the ports that you select. When a user requests access, Defender for Cloud checks whether the user has the required Azure role-based access control (Azure RBAC) permissions. If the request is approved, Defender for Cloud temporarily updates the NSG or Azure Firewall rules to allow inbound traffic from the requested source IP address or range.

After the approved time expires, Defender for Cloud restores the previous rules and closes the ports again. Existing connections aren't interrupted when the time window expires, but new connection attempts are blocked unless a new request is approved.

JIT VM access can protect supported Azure VMs and supported AWS EC2 instances connected to Defender for Cloud. For Azure VMs, the VM must be deployed through Azure Resource Manager and protected by an NSG, Azure Firewall, or both. JIT doesn't support classic VMs, VMs protected by Azure Firewall Manager-controlled firewalls, or Azure Firewall policies.

## Configure JIT VM access

Before configuring JIT VM access, verify that Defender for Servers Plan 2 is enabled on the subscription or connector that contains the VM.

To configure JIT VM access in Microsoft Defender for Cloud:

1. In the Azure portal, open **Microsoft Defender for Cloud**.
2. Select **Workload protections**.
3. Under **Advanced protection**, select **Just-in-time VM access**.
4. On the **Not configured** tab, select the VMs that you want to protect.
5. Select **Enable JIT on VMs**.
6. Review the recommended management ports. Common protected ports include:
   - **22** for SSH
   - **3389** for RDP
   - **5985** for WinRM over HTTP
   - **5986** for WinRM over HTTPS
7. To customize the policy, add or edit ports and configure the protocol, allowed source IP addresses, and maximum request time.
8. Select **Save**.

You can also enable JIT VM access from a VM's **Configuration** page by selecting **Enable just-in-time** under **Just-in-time access**. This uses default port and access-duration settings. Use Microsoft Defender for Cloud if you need to customize those settings.

## Request access to a JIT-protected VM

After JIT VM access is enabled, administrators request access before connecting.

To request access:

1. In Microsoft Defender for Cloud, open **Workload protections**.
2. Select **Just-in-time VM access**.
3. On the **Configured** tab, select the VM that you want to access.
4. Select **Request access**.
5. Select the ports to open, the source IP address or range, and the access duration.
6. Select **Open ports**.
7. Connect to the VM by using the appropriate tool, such as RDP or SSH, during the approved time window.

You can also request access from the VM's **Connect** page in the Azure portal. If JIT is enabled for the VM, the portal prompts you to request access before connecting.

## Audit JIT VM access

JIT VM access activity is recorded so you can review who requested access and when access was opened. To audit activity:

1. In Microsoft Defender for Cloud, open **Just-in-time VM access**.
2. On the **Configured** tab, locate the VM that you want to review.
3. Open the VM's context menu, and then select **Activity Log**.
4. Review the filtered activity log, or download it as a CSV file for offline analysis.

## Compare JIT VM access with Azure Bastion

JIT VM access and Azure Bastion both help protect administrative access to VMs, but they solve different problems.

| Technology | Primary purpose | How it protects VMs | Best use |
|---|---|---|---|
| **JIT VM access** | Controls when management ports are open. | Uses Defender for Cloud to close selected inbound ports by default and open them temporarily after an approved request. | Reduce exposure for RDP, SSH, WinRM, or custom management ports when direct network access is required. |
| **Azure Bastion** | Provides a managed RDP/SSH connection path. | Lets users connect over TLS through the Azure portal or native clients by using the VM's private IP address. VMs don't need public IP addresses, agents, or special client software. | Provide secure administrative connectivity to VMs without exposing management ports directly to the internet. |

Use JIT VM access when you need time-bound control over management port exposure. Use Azure Bastion when you want administrators to connect to VMs through a managed service without assigning public IP addresses to the VMs.

The technologies can be part of the same privileged-access strategy. For example, Azure Bastion can remove the need for public management endpoints, while Defender for Cloud recommendations and JIT policies help enforce least-exposure access patterns. If you use them together, test the VM's NSG and routing rules to ensure legitimate Bastion traffic is permitted only as intended.
