Hardening a point-to-site (P2S) virtual private network (VPN) gateway protects the connection itself, but it doesn't limit what authenticated users can access after they connect. Once users establish a VPN session, network routing allows them to reach any resource in the virtual network (virtual network). Microsoft Entra Private Access replaces this broad network-layer access with per-application Zero Trust controls. In this unit, you learn the architecture of Microsoft Entra Private Access, configure per-application access segments, and apply Conditional Access policies to private resources—transforming Contoso's remote access model from "trust the network" to "verify every request."

| Step | Action |
|------|--------|
| 1. Deploy Private Network Connector | Install connector agent in target network to establish outbound tunnel |
| 2. Create application segment | Define destination (fully qualified domain name (FQDN), IP), protocol (Transmission Control Protocol (TCP)), and port |
| 3. Assign users and groups | Grant specific identities access to the application |
| 4. Configure Conditional Access policy | Require multifactor authentication (MFA), compliant device, or other controls |
| 5. Deploy Global Secure Access client | Install client on user devices to route traffic through Private Access |

VPN technology operates at the network layer: after authentication completes, IP routing takes over and users can initiate connections to any TCP or UDP port on any resource within the virtual network. Broad network access conflicts with Zero Trust principles, which require verification for every request to every resource based on current user context. Microsoft Entra Private Access narrows the access scope from "the entire network" to "specific application ports and FQDNs," ensuring that even a compromised session can only reach explicitly authorized applications. For Contoso, this distinction is critical: a compromised P2S VPN session could reach all Azure workloads across development, testing, and production environments. A compromised Private Access session is limited to the single application the user was granted—such as the finance reporting portal or a specific development API endpoint.

## Explore the Microsoft Entra Private Access architecture

Microsoft Entra Private Access is one component of **Global Secure Access**, which is part of the Microsoft Entra Suite. Global Secure Access provides two distinct capabilities: **Microsoft Entra Private Access** replaces VPN by providing per-application access to internal resources, while **Microsoft Entra Internet Access** secures and filters internet-bound traffic. Private Access for securing hybrid connectivity is the sole focus of this unit.

The Private Access architecture relies on three core components working together. The **Private Network Connector** is a lightweight Windows service you install on a virtual machine (VM) or server inside the target network. Unlike traditional VPN infrastructure that requires inbound firewall rules and public IP addresses, the connector establishes an outbound Hypertext Transfer Protocol Secure (HTTPS) tunnel over port 443 to the Global Secure Access service. The outbound design eliminates the need for inbound firewall exceptions and reduces attack surface—the connector initiates all connections from inside your network to Microsoft's cloud.

When a user requests access to a private resource, traffic flows from the user device to the Global Secure Access service. Then flows through the connector, and finally to the private application. The connector acts as a reverse proxy, forwarding authorized requests while keeping the internal resource invisible to the public internet. For this architecture to function, the connector host must meet specific prerequisites: it must reside in the same network as the private resources users need to reach, maintain outbound HTTPS connectivity to Microsoft cloud endpoints, and be Microsoft Entra joined, hybrid-joined, or registered. The connector supports Windows Server 2016 or later.

The **Global Secure Access client** is a lightweight application installed on user devices that intercepts traffic destined for private resources and routes it through the Global Secure Access infrastructure. Like a VPN client, it manages connectivity transparently, but unlike VPN, it operates at the application layer—it only intercepts traffic to explicitly configured destinations rather than capturing all network traffic. Selective routing allows users to access private corporate applications and public internet resources simultaneously without forcing all traffic through a corporate gateway.

> [!NOTE]
> The hands-on exercise covers connector installation and client deployment. Architecture and application segment configuration are the focus of this unit.

## Choose between Quick Access and per-app access

Microsoft Entra Private Access offers two configuration modes that balance ease of deployment against Zero Trust precision. **Quick Access** allows you to define a set of IP ranges, FQDNs, and ports that all users granted Quick Access permissions can reach. It functions like "Private Access for an entire subnet"—it's faster to configure initially but still provides network-scoped access within the defined ranges. Quick Access is useful for broad scenarios like granting remote access to an entire file server farm or a legacy application subnet that can't be segmented further.

**Per-app access** (configured as Enterprise Applications) represents the Zero Trust approach: you create a specific application segment for each resource, such as "HR Portal" pointing to TCP port 443 at `hrportal.contoso.internal`. Each application segment becomes an Enterprise Application in Microsoft Entra ID, allowing you to assign specific users or groups and apply distinct Conditional Access policies per application. The granular model ensures that developers access only development APIs, finance users access only financial reporting tools, and nobody receives automatic access to all internal resources simply by authenticating.

For Contoso's migration scenario, per-app access is the recommended pattern. The organization's P2S VPN currently provides all authenticated users' access to development, staging, and production networks simultaneously—a model that violates separation of duties and increases blast radius for credential compromise. By admins configuring each high-sensitivity workload as a separate Private Access application, Contoso enforces least-privilege access: the finance team's access to the production database administration tool is independent from the development team's access to API testing environments. Each application can enforce different security controls based on data sensitivity and compliance requirements.

| Access mode | Configuration effort | Granularity | Conditional Access | Best for |
|-------------|---------------------|-------------|-------------------|----------|
| Quick Access | Low—define IP ranges and ports once | Network-level (all resources in range) | Applies to all Quick Access resources | Broad access to legacy subnets, file shares |
| Per-app access | Medium—create segment per application | Application-level (single FQDN or IP:port) | Unique policy per application | Zero Trust segmentation, high-sensitivity workloads |

## Configure a Private Access application segment

Creating a per-app access configuration in the Microsoft Entra admin center follows a straightforward workflow. You start by navigating to **Global Secure Access** > **Applications** > **Enterprise applications** and selecting **New application** > **Private Access**. Doing so creates a new Enterprise Application object that represents your private resource in Microsoft Entra.

The application creation wizard prompts you to name the application—use descriptive names that reflect the business purpose rather than technical details, such as "Contoso HR Portal" instead of "Server-042-App." Under **Application segment**, you define the destination that users access. The **Destination type** field accepts either IP address or FQDN—prefer FQDN whenever possible because IP-based segments don't update automatically if the service moves to a new address. Enter the internal destination in the **Destination** field (for example, `hrportal.contoso.internal`), specify the protocol (TCP or User Datagram Protocol [UDP]), and enter the port number (such as 443 for HTTPS).

> [!TIP]
> Use FQDN destination types whenever possible. IP-based segments require manual updates if the application moves to a new address, while FQDN-based segments rely on Domain Name System (DNS) resolution and adapt automatically.

After defining the application segment, you select the **Connector group** that will service this application. Connector groups are logical collections of Private Network Connectors deployed in specific networks or regions. Choose the connector group that has line-of-sight access to the destination you configured. If you deploy connectors in both Azure and on-premises networks, create separate connector groups for each location and assign applications to the appropriate group.

The final configuration steps involve assigning users and linking Conditional Access policies. Navigate to **Users and groups** within the application settings and add the Microsoft Entra groups or individual users who require access to this resource. Remember that Private Access enforces least-privilege access: only explicitly assigned identities can reach the application. Navigate to the **Conditional Access** section to create or link policies scoped specifically to this application, ensuring that access requires appropriate security controls.

## Apply Conditional Access to private applications

Because each Private Access application is a standard Microsoft Entra ID Enterprise Application, Conditional Access policies can target it just like Microsoft 365 applications or custom software-as-a-service (SaaS) applications. The integration extends the same per-session security controls you apply to cloud applications to your private internal workloads. For Contoso, this means the financial reporting application hosted on-premises can now enforce the same Conditional Access policies as Power BI and Microsoft 365—unified security governance across hybrid infrastructure.

Recommended Conditional Access controls for Private Access applications include requiring compliant devices through Intune compliance policies. Also, enforcing MFA for every session, limiting access to specific named locations, and using sign-in risk policies to block high-risk sessions. You can layer these controls based on application sensitivity: low-risk applications might require only MFA, while high-risk applications such as production database management tools require MFA plus compliant device plus privileged access workstation (PAW).

The Conditional Access policy creation workflow mirrors any other cloud application policy. Create a new policy, select **Cloud apps or actions** > **Select apps**, and choose the Private Access application you configured. Under **Conditions**, specify criteria such as user risk level, sign-in risk level, device platforms, or locations. Under **Access controls**, define grant requirements such as "Require multifactor authentication" and "Require device to be marked as compliant." The layered approach ensures that access decisions account for user identity, device posture, location context, and real-time risk signals.

> [!NOTE]
> Conditional Access for Private Access requires Microsoft Entra ID P1 licenses. The Global Secure Access client is included in Microsoft Entra Suite and Microsoft Entra Private Access add-on licenses.

## Decide when to retain VPN versus replace with Private Access

Not all remote access scenarios are ideal candidates for immediate migration to Private Access. Understanding when to retain VPN infrastructure versus when to replace it with per-app Private Access helps you prioritize migration efforts and maintain service continuity during transition.

| Scenario | Recommended approach | Rationale |
|----------|---------------------|-----------|
| Remote user needs access to specific internal web apps | Per-app Private Access | Application-layer access with Conditional Access policies per app |
| Remote user needs broad file share access (Server Message Block [SMB]) | VPN or Quick Access | SMB requires network-layer connectivity; difficult to segment per-share |
| Branch office connecting multiple on-premises devices | Site-to-site VPN | Device-independent; connects entire networks, not individual users |
| Highly privileged admin access to management plane | Privileged Access Workstation + Private Access per tool | Isolated device plus per-application Zero Trust access |
| Legacy app requiring specific network subnet | VPN until app refactored | Some legacy protocols depend on network-layer features |
| High-compliance workload requiring device posture check | Per-app Private Access + Conditional Access (compliant device) | Granular access with continuous device posture validation |

VPN and Private Access can coexist during migration, allowing you to validate Private Access functionality for specific applications before decommissioning VPN infrastructure. Contoso's migration strategy begins with the highest-sensitivity applications: the production database administration tool and financial reporting portal. Why you start with high-value, well-defined applications, Contoso validates the architecture and builds operational expertise before migrating broader workloads. As each application migrates to Private Access, VPN access policies tighten—removing routes and firewall rules until the VPN infrastructure serves only legacy scenarios that genuinely require network-layer access.
