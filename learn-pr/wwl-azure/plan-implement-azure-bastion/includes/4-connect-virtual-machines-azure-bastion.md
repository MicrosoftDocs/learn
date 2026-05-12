Azure Bastion provides multiple connection methods that accommodate different user workflows and security requirements. Factory engineers at Contoso Manufacturing connect to operational VMs using browser-based sessions for quick troubleshooting and native client tunnels for complex administrative tasks requiring full RDP client features.

## Connect using browser-based sessions

Browser-based connectivity works with all Bastion SKUs and provides the simplest connection experience. This method requires no client-side software beyond a modern web browser and establishes RDP or SSH sessions directly through the Azure portal.

To initiate a browser-based connection, navigate to the target virtual machine in the Azure portal and select **Connect** from the overview page. Choose **Bastion** from the available connection methods. The portal displays a connection form requesting credentials—enter the username and password (or SSH private key for Linux VMs) for the target system. Select **Connect** to launch the session.

The browser opens a new tab or window displaying the remote desktop or terminal session. All keyboard input, mouse actions, and display output flow through the HTTPS connection to the Bastion service, which forwards the session to the target VM. The target VM requires no public IP address and needs no open inbound ports for RDP or SSH in its network security group.

Browser-based sessions support standard RDP features including clipboard operations, though some advanced features like drive redirection or printer mapping can have limitations. For Linux VMs, the SSH session provides a full terminal interface with command history, tab completion, and text-based application support.

This connection method works seamlessly across operating systems and network environments because it runs entirely through HTTPS port 443. Users behind restrictive corporate firewalls or using managed devices with limited software installation rights can connect without more configuration.

## Connect using native client tunneling

Native client support (Standard and Premium SKUs) enables connections using standard RDP and SSH client applications through an Azure CLI tunnel. This capability preserves existing workflows for engineers who rely on specific client configurations, custom RDP settings, or advanced features not available in the browser-based client.

### Configure the Azure CLI tunnel

Native client connectivity requires the Azure CLI with the bastion extension installed. Install the extension using:

```azurecli
az extension add --name bastion
```

To establish a tunnel for an RDP connection, use the `az network bastion tunnel` command with the target VM's resource ID and a local port number:

```azurecli
az network bastion tunnel --name bastion-hub-prod \
  --resource-group rg-network-prod \
  --target-resource-id /subscriptions/<subscription-id>/resourceGroups/<vm-rg>/providers/Microsoft.Compute/virtualMachines/<vm-name> \
  --resource-port 3389 \
  --port 50001
```

This command establishes a listening port on localhost:50001 that tunnels through the Bastion service to the target VM's RDP port. The command continues running in the terminal and maintains the tunnel as long as it executes. Keep this terminal window open while you use the RDP connection.

### Connect RDP clients through the tunnel

With the tunnel established, launch your preferred RDP client and connect to `localhost:50001`. Microsoft Remote Desktop, Windows App, or the built-in mstsc.exe client all work with the tunnel. The RDP client treats the localhost connection as a standard RDP session, enabling all client-side features including:

- Display configuration (multi-monitor support, custom resolutions)
- Clipboard synchronization (copy/paste between local and remote)
- Drive redirection (access local files from the remote session)
- Audio redirection (play remote system audio locally)
- Printer mapping (print from remote applications to local printers)

The connection flows from the RDP client to localhost, through the Azure CLI tunnel command, across the internet to the Bastion service over HTTPS 443, and finally to the target VM over the Azure backbone network. This path preserves the security benefits of Bastion while enabling full native client functionality.

### Connect SSH clients through native tunneling

For SSH connections, Azure Bastion provides direct SSH support through the `az network bastion ssh` command:

```azurecli
az network bastion ssh --name bastion-hub-prod \
  --resource-group rg-network-prod \
  --target-resource-id /subscriptions/<subscription-id>/resourceGroups/<vm-rg>/providers/Microsoft.Compute/virtualMachines/<vm-name> \
  --auth-type password \
  --username azureuser
```

This command establishes an interactive SSH session directly through Bastion without requiring a separate tunnel setup. You also tunnel SSH connections similarly to RDP if you need to use specific SSH client features or configurations not supported by the direct method.

## Generate and use shareable links

Shareable links (Standard and Premium SKUs) provide time-limited browser-based access without requiring Azure portal authentication. This feature supports scenarios where contractors, vendors, or temporary staff need access without full Azure subscriptions or role-based access control assignments.

To create a shareable link, navigate to the target VM in the Azure portal, select **Connect**, and choose **Bastion**. Toggle the **Shareable link** option and select **Create shareable link**. The portal generates a URL that provides direct browser-based access to the VM through Bastion.

Configure the shareable link properties:

- **Expiration time**: Set how long the link remains valid (maximum 90 days)
- **Allowed credentials**: Optionally restrict which VM credentials can authenticate through the link
- **Description**: Add notes about the link's purpose for audit records

Share the generated URL with the intended recipient. When they open the URL, they see a connection form requesting VM credentials. After authentication, the browser establishes a Bastion session identical to the standard browser-based connection experience.

Shareable links appear in the Bastion resource's **Shareable Links** page, where you can revoke individual links before their expiration time. Revoked links immediately stop working, terminating any active sessions using those links.

Contoso Manufacturing uses shareable links to provide vendor access during equipment maintenance windows. The security team creates 24-hour links before scheduled maintenance and revokes them immediately after the vendor completes their work.

## Authenticate using Kerberos

Kerberos authentication is available with all Azure Bastion SKU tiers and enables domain-joined virtual machines to authenticate users through Active Directory without transmitting passwords over the connection. This capability supports Windows domains using Active Directory Domain Services (AD DS) or Azure Active Directory Domain Services (Azure AD DS).

With Kerberos authentication enabled in the Bastion configuration, domain users connecting through the native client tunnel authenticate using their domain credentials. The authentication process uses Kerberos tickets instead of password validation, which provides enhanced security and supports single sign-on workflows.

To enable Kerberos authentication, the target VMs must be domain-joined, and the Bastion subnet must have network connectivity to domain controllers. Users initiate connections using the native client tunnel with their domain username in the format `domain\username`.

## Monitor and manage active sessions

Azure Bastion maintains visibility into all active connections through the **Sessions** page in the Azure portal. This view displays currently connected users, target VMs, connection duration, and session types (RDP or SSH).

Security teams use this monitoring capability to identify unusual access patterns, verify that expected users have appropriate access, and disconnect sessions when necessary. To terminate an active session, select the session from the list and choose **Disconnect**. The disconnection happens immediately and logs the administrative termination for audit purposes.

Session monitoring provides real-time visibility without requiring access to individual VMs or reviewing distributed logs. All Bastion connectivity—regardless of whether users connect through the browser, native clients, or shareable links—appears in this centralized view.

## Remove public IP addresses from VMs

Once Bastion provides reliable connectivity, you can remove public IP addresses from target virtual machines to eliminate their exposure to internet-based attacks. This change represents the primary security benefit of Azure Bastion—VMs become inaccessible from the internet while remaining fully manageable through Bastion.

Before removing public IPs, verify that all required access paths work through Bastion. Test browser-based connections, native client tunnels, and any other workflows that users depend on for VM management. Confirm that monitoring tools, backup systems, and other automation that might depend on direct VM connectivity either work through private networks or have alternative access methods.

To remove a public IP, navigate to the VM in the Azure portal, select **Networking**, and disassociate the public IP address from the network interface. You can delete the now-unused public IP resource or retain it for potential future use.

After removing public IPs, update network security group rules to remove inbound allow rules for ports 3389 and 22. These ports no longer require internet accessibility because all RDP and SSH traffic flows through the Bastion service.

Contoso Manufacturing's security team followed a staged approach: they deployed Bastion, validated connectivity for two weeks while monitoring the Sessions view, confirmed all engineers successfully connected through Bastion, and then removed public IPs from factory VMs during a scheduled maintenance window. Post-implementation monitoring showed zero inbound attempts on RDP and SSH ports, confirming the elimination of the attack surface.

Now that you understand how to connect to VMs through Azure Bastion using multiple methods, you're ready to validate your knowledge with a few scenario-based questions.
