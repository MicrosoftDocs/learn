Designing a secure remote access solution for server and client endpoints requires a layered approach aligned with Zero Trust principles: verify explicitly, use least privilege access, and assume breach. The strategy must address how users securely connect to servers, virtual machines, and corporate resources without exposing management ports or relying solely on traditional VPNs.

## Azure Bastion

Azure Bastion is a platform-as-a-service (PaaS) resource that provides secure RDP and SSH connectivity to Azure virtual machines directly through the Azure portal or via the native RDP/SSH client on the user's workstation, over a TLS-encrypted channel on port 443. Because Azure Bastion sits inside the virtual network, target VMs don't need public IP addresses, and management ports (3389 and 22) don't need to be exposed to the internet. This eliminates a significant attack surface.

:::image type="content" source="../media/azure-standalone-bastion.png" alt-text="Diagram showing the Azure Bastion architecture. A user connects through the Azure portal over TLS to Azure Bastion deployed in the AzureBastionSubnet, which then connects via private IP to target virtual machines without requiring public IP addresses on the VMs.":::

Azure Bastion is deployed into a dedicated subnet named AzureBastionSubnet (minimum /26 prefix) and offers four SKU tiers:

- **Developer**: A free, shared-pool tier for development and testing. Supports a single VM connection and doesn't support virtual network peering.
- **Basic**: Dedicated deployment with fixed capacity for production environments with moderate connection requirements.
- **Standard**: Adds support for connecting via the native RDP/SSH client on the user's workstation, shareable links, IP-based connections, custom ports, file transfer, and increased scalability.
- **Premium**: Includes all Standard features plus session recording for compliance auditing and private-only deployment without a public IP address.

For production, Standard or Premium is recommended. Premium is the preferred choice for environments with compliance or audit requirements.

### Network topology considerations

In a **hub-and-spoke topology**, a single Azure Bastion instance deployed in the hub virtual network can provide connectivity to VMs in peered spoke virtual networks. This centralizes management but requires users connecting through Bastion to hold a Reader RBAC role on both the Bastion resource and the hub virtual network. Where this RBAC assignment isn't acceptable for security or compliance reasons, deploy a dedicated Bastion instance in each spoke virtual network that requires remote access.

:::image type="content" source="../media/azure-hub-spoke-bastion.png" alt-text="Diagram showing a hub-and-spoke network topology with Azure Bastion deployed in the centralized hub virtual network. The bastion host connects to virtual machines in peered spoke virtual networks through virtual network peering.":::

In an **Azure Virtual WAN topology**, Bastion can't be deployed inside a Virtual WAN virtual hub. Instead, deploy Bastion in a spoke virtual network using the Standard or Premium SKU with IP-based connection enabled. This allows Bastion to reach VMs in other virtual networks connected to the same Virtual WAN through its associated hubs, provided routing is configured correctly.

### Securing Azure Bastion

When designing for Azure Bastion, ensure the architecture includes NSG rules that restrict inbound access to the Bastion subnet and prevent direct exposure of management ports on target VMs. Plan for centralized logging by directing Bastion diagnostic logs to a Log Analytics workspace for auditing and threat detection. For SSH access to Linux VMs, the design should incorporate Azure Key Vault for private key storage rather than allowing keys to be managed on individual workstations.

## Just-in-time VM access

Microsoft Defender for Cloud's just-in-time (JIT) VM access feature reduces exposure to brute-force and other network-based attacks by locking down inbound traffic to management ports on virtual machines. JIT keeps ports like RDP (3389) and SSH (22) closed by default and opens them only when an authorized user requests access, for a limited time window and from specified source IP addresses. When the time window expires, Defender for Cloud automatically restores the NSG or Azure Firewall rules to block inbound traffic.

JIT requires Microsoft Defender for Servers Plan 2 and supports VMs deployed through Azure Resource Manager and VMs protected by Azure Firewalls. Administrators configure JIT through the Azure portal, PowerShell, or REST API, specifying permitted ports, maximum access duration, and allowed source IP ranges.

JIT complements Azure Bastion. Bastion provides the secure access channel, while JIT provides time-bounded port control. Together, they create a defense-in-depth model where management ports remain closed until explicitly requested and access is brokered through a secure intermediary.

## Hybrid connectivity with VPN Gateway and ExpressRoute

For environments that require remote access to both Azure and on-premises resources, Azure VPN Gateway and Azure ExpressRoute provide secure hybrid connectivity options.

**Point-to-site (P2S) VPN** allows individual client devices to establish encrypted connections to an Azure virtual network. P2S supports OpenVPN (TLS-based, cross-platform), IKEv2 (IPsec-based), and SSTP (Windows only). Authentication options include Microsoft Entra ID for single sign-on and Conditional Access enforcement, certificate-based authentication, and RADIUS. Microsoft Entra ID authentication is recommended because it supports Conditional Access policies that evaluate user risk, device compliance, and location before granting access.

**Site-to-site (S2S) VPN** connects an entire on-premises network to Azure through an IPsec/IKE tunnel, appropriate for persistent data center connectivity.

**Azure ExpressRoute** provides dedicated private connectivity to Microsoft cloud services without traversing the public internet, offering higher reliability and lower latency. For high-security environments, combine ExpressRoute with a site-to-site VPN as a failover path.

## Microsoft Entra Private Access

Microsoft Entra Private Access, part of Microsoft's Global Secure Access Security Service Microsoft Edge (SSE) solution, offers a Zero Trust alternative to traditional VPNs for accessing private applications and resources. It enables per-app access to specific servers and services—scoped by FQDN, IP address, port, and protocol—rather than granting broad network-level connectivity. From a security architecture perspective, Private Access is relevant here because it directly addresses remote access to server endpoints while enforcing Conditional Access policies (including MFA and device compliance) at the network layer, even for legacy applications that don't natively support modern authentication.

Microsoft Entra Private Access is covered in another module in this learning path.

## Conditional Access as a policy engine

Microsoft Entra Conditional Access serves as the Zero Trust policy engine across all remote access scenarios. It evaluates signals including user identity, device compliance, location, application sensitivity, and real-time risk scores. Conditional Access policies should be applied to Azure Bastion sessions (requiring MFA and compliant devices), P2S VPN connections (enforcing risk-based access controls), and Microsoft Entra Private Access (applying per-app policies with MFA and device compliance). Combining Conditional Access with Microsoft Entra ID Protection enables automated responses to sign-in risk, such as requiring password changes or blocking access from suspicious sources.

## Design recommendations

When designing a secure remote access solution for server and client endpoints:

- Never expose RDP or SSH management ports directly to the internet. Use Azure Bastion, JIT access, or both.
- Deploy Azure Bastion Premium SKU in production environments where compliance requires session recording or private-only access.
- Consider Microsoft Entra Private Access as a Zero Trust alternative to traditional VPN for per-app access to on-premises and private cloud server endpoints.
- Configure Microsoft Entra ID authentication for P2S VPN connections and enforce Conditional Access policies that evaluate device compliance and user risk.
- Combine Azure Bastion with JIT for defense-in-depth: Bastion provides the secure channel, JIT provides time-bounded port access.
- Use ExpressRoute for persistent, high-security hybrid connectivity and maintain a site-to-site VPN as a failover path.
- Apply Conditional Access policies across all remote access paths to enforce consistent Zero Trust controls.
- Send diagnostic logs from Azure Bastion, VPN Gateway, and Global Secure Access to a central Log Analytics workspace for unified monitoring and threat detection.

## Choosing the right remote access mechanism

The following table summarizes the secure remote access mechanisms covered in this unit and when to use each.

| Mechanism | What it does | When to use |
|---|---|---|
| **Azure Bastion** | Broker-based RDP/SSH access to Azure VMs over TLS (port 443) through the Azure portal or the native RDP/SSH client on the user's workstation. No public IP required on VMs. | Secure administrative access to Azure VMs. Use Premium SKU when session recording or private-only deployment is required. |
| **Just-in-time (JIT) VM access** | Temporarily opens management ports on VMs for a limited time window, from specified source IPs, then automatically closes them. | Reduce the attack surface on VM management ports. Combine with Azure Bastion for defense-in-depth. Requires Defender for Servers Plan 2. |
| **Point-to-site (P2S) VPN** | Encrypted VPN tunnel from an individual client device to an Azure virtual network using OpenVPN, IKEv2, or SSTP. | Remote users who need network-level access to Azure-hosted resources. Use Microsoft Entra ID authentication for Conditional Access integration. |
| **Site-to-site (S2S) VPN** | IPsec/IKE tunnel connecting an entire on-premises network to an Azure virtual network. | Persistent, always-on hybrid connectivity between an on-premises data center and Azure. |
| **Azure ExpressRoute** | Dedicated private WAN connection to Microsoft cloud services; traffic doesn't traverse the public internet. | High-security, high-bandwidth, low-latency hybrid connectivity. Use S2S VPN as a failover path. |
| **Microsoft Entra Private Access** | Zero Trust per-app access to private resources through Microsoft's SSE edge, enforcing Conditional Access at the network layer. | Replace or supplement VPN for remote access to specific on-premises or cloud server endpoints, especially legacy applications. Covered in detail in another module. |
| **Conditional Access** | Policy engine that evaluates identity, device, location, and risk signals to make real-time access decisions. | Apply across all remote access paths (Bastion, VPN, Private Access) to enforce consistent Zero Trust controls. |
