Global Secure Access is Microsoft's Security Service Edge (SSE) solution, built on Zero Trust principles of verifying explicitly, using least privilege, and assuming breach. It combines Microsoft Entra Internet Access, Microsoft Entra Internet Access for Microsoft Services, and Microsoft Entra Private Access—together with Microsoft Defender for Cloud Apps—to converge network, identity, and endpoint access controls so organizations can secure access to any app or resource, from any location, device, or identity.

:::image type="content" source="../media/global-secure-access-v3.png" alt-text="Diagram showing components that make up Global Secure Access.":::

SSE helps organizations address security challenges such as:

- Reducing the risk of lateral movement through a compromised VPN tunnel.
- Putting a security perimeter around internet-based assets.
- Improving service in remote locations, such as branch offices.

The solution employs a Global Secure Access client that gives organizations control over network traffic at the end-user computing device. Organizations route specific traffic profiles through the service, enabling deep integration with Conditional Access policies and real-time risk assessment across identity, device, location, and applications.

### Microsoft Entra Internet Access

Microsoft Entra Internet Access provides an identity-centric Secure Web Gateway (SWG) solution for SaaS applications and other internet traffic. It protects users, devices, and data from internet-based threats with security controls and visibility through traffic logs.

Key features include:

- **Web content filtering**—regulates access to websites based on their content categories and domain names.
- **Universal Conditional Access**—applies Conditional Access policies to all internet destinations, even those not federated with Microsoft Entra ID.
- **Universal Continuous Access Evaluation (CAE)**—apps and Microsoft Entra constantly communicate to ensure user access is up-to-date. If something changes—like a user's location or a security concern—the system can quickly adjust or block access in near real time.

Microsoft Entra Internet Access requires the Microsoft Entra Suite license or a standalone Microsoft Entra Internet Access license.

### Microsoft Entra Internet Access for Microsoft Services

Microsoft Entra Internet Access for Microsoft Services enhances Microsoft Entra ID capabilities with direct connectivity to supported Microsoft services, improving security, performance, and resilience. It uses a prepopulated Microsoft traffic forwarding profile that covers Exchange Online, SharePoint Online, Microsoft Teams, and other Microsoft 365 workloads.

Key features include:

- **Compliant network check**—uses Conditional Access policies to require that users connect through Global Secure Access before accessing any Microsoft Entra ID–integrated application, protecting against token theft at both the authentication plane and the data plane.
- **Universal tenant restrictions**—prevents data exfiltration to unauthorized foreign tenants or personal accounts, including anonymous access.
- **Source IP restoration**—restores the original user IP address in Microsoft Entra ID sign-in logs so that location-based Conditional Access policies and risk detections remain accurate, even though traffic passes through the SSE proxy.
- **Enriched Microsoft 365 logs**—provides detailed network traffic logs for Microsoft traffic, including enforced policy details.

Microsoft Entra Internet Access for Microsoft Services is included with a Microsoft Entra ID P1 or P2 license, making it available to a broad range of organizations.

### Microsoft Entra Private Access

Microsoft Entra Private Access provides users—whether in an office or working remotely—secure access to private, corporate resources. It replaces legacy VPNs with a Zero Trust Network Access (ZTNA) approach that grants per-app access rather than broad network-level connectivity.

Private Access works by creating enterprise applications that serve as containers for private resources. A network connector brokers traffic between the service and the resource a user wants to access. Organizations can configure access two ways:

- **Quick Access**—administrators define private resources by fully qualified domain name (FQDN), IP address, or IP range and ports, grouping them into a single application with linked Conditional Access policies.


- **Per-app Access (Global Secure Access app)**—provides a more granular approach where each enterprise application has its own resource definitions, user assignments, and Conditional Access policies, enabling different policies for different resource groups.

  # [Quick Access](#tab/quick-access)
  :::image type="content" source="../media/quick-access-diagram.png" lightbox="../media/quick-access-diagram.png" alt-text="Diagram of Microsoft Entra Private Access with showing the components of Quick Access.":::
  
  # [Per-app Access](#tab/per-app-access) 
  :::image type="content" source="../media/per-app-access-diagram.png" lightbox="../media/per-app-access-diagram.png" alt-text="Diagram of Microsoft Entra Private Access showing the components of per-app Access.":::

  ---

### Global Secure Access dashboard

Global Secure Access includes a dashboard in the Microsoft Entra admin center that provides visualizations of network traffic acquired by the service. Administrators can monitor users, devices, cross-tenant access, web category filtering, and device status to identify suspicious activity and improve network configurations.

### Securing AI workloads with network controls

As organizations deploy AI services that connect to both cloud and on-premises resources, Global Secure Access helps ensure that traffic to and from these services passes through the same identity-aware security controls applied to other enterprise traffic. Conditional Access policies integrated with Global Secure Access traffic profiles can enforce compliant network checks and restrict access based on user risk, device state, and location—extending Zero Trust principles to AI workloads that access sensitive corporate data.
