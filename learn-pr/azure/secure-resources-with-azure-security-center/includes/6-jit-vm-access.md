One of the interesting features supported in the Azure Security Center **standard tier** is Just-in-time (JIT) virtual machine (VM) access. JIT VM access can be used to lock down inbound traffic to your Azure VMs, reducing exposure to attacks while providing easy access to connect to VMs when needed.

## Typical attacks on VMs

Brute force attacks commonly target management ports as a means to gain access to a VM. If successful, an attacker can take control over the VM and establish a foothold into your environment. A brute-force attack consists of checking all possible user names or passwords until the correct one is found. This isn’t the most sophisticated form of attack, but it’s relatively simple to perform.

### Stopping brute-force attacks against Remote Desktop

To counteract RDP brute-force attacks, you can take multiple measures such as:

* Disabling the public IP address and using one of these connection methods:
  * Use a point-to-site virtual private network (VPN)
  * Create a site-to-site VPN
  * Use Azure ExpressRoute to create secure links from your on-premise network to Azure

* Requiring two-factor authentication
* Using complex passwords
* Limiting the amount of time that the ports are open

This final approach is what Azure Security Center implements. One way to reduce exposure to a brute force attack is to limit the amount of time that a port is open. Management ports do not need to be open at all times. They only need to be open while you are connected to the VM, for example to perform management or maintenance tasks. When just-in-time access is enabled, Security Center uses network security group (NSG) rules, which restrict access to management ports so they cannot be targeted by attackers.

## Enabling JIT VM Access

When you enable JIT VM Access for your VMs, you can create a policy that determines the ports to help protect, how long ports should remain open, and the approved IP addresses that can access these ports. The policy helps you stay in control of what users can do when they request access. Requests are logged in the Azure activity log, so you can easily monitor and audit access. The policy will also help you quickly identify the existing VMs that have JIT VM Access enabled and the VMs where JIT VM Access is recommended.

### How JIT VM Access works

Remember you need to be in the Standard pricing tier of Azure Security Center to use this feature. Once you migrate a subscription to this tier you can enable JIT VM access for selected Azure VMs in the subscription.

1. Enable JIT VM Access for the selected Azure VMs on the **Just in time VM access** panel under **ADVANCED CLOUD DEFENSE**.

    ![Screenshot that depicts how you can enable JIT VM Access for a selected VM.](../media/M3-RDP02.png)

1. The NSG of the VMs is updated with rules to block remote management access as shown in the below image.

    ![Screenshot that depicts rules to block remote management access.](../media/M3-RDP03.png)

1. Use Azure Security Center to request access to a VM by using one of the protocols in the policy.

    ![Screenshot that depicts how you can request access to a VM.](../media/M3-RDP04.png)

1. The required NSG is updated to allow inbound access for that protocol (Remote desktop using port 3389). This will allow administrators and developers to remotely access the VM.

    ![Screenshot that depicts opening a port by selecting On for its toggle.](../media/M3-RDP05.png)

If a JIT access request is approved for a VM behind an Azure Firewall, then Security Center automatically changes both the NSG and firewall policy rules. For the amount of time that was specified, the rules allow inbound traffic to the selected ports and requested source IP addresses or ranges. After the time is over, Security Center restores the firewall and NSG rules to their previous state. Each request is audited so security personal can identify each access request.
