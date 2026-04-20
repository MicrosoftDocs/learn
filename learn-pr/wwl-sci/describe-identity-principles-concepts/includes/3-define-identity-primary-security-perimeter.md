
Digital collaboration has transformed how and where work gets done. Employees and partners now access organizational resources from anywhere—home offices, coffee shops, client sites, and across borders. They use corporate devices, personal devices, and shared workstations. They're accessing both on-premises systems and cloud services using the same identities.

This shift has fundamentally changed how organizations need to think about security.

## The traditional security perimeter

Historically, organizations protected their resources using a *network perimeter*—a defined boundary, enforced by firewalls and VPN gateways, around corporate systems. Security controls at the edge of the network kept untrusted traffic out and allowed trusted internal traffic to flow freely.

This model worked well when most employees worked in a single office, accessed applications running on local servers, and used only company-managed devices connected to the corporate network. When everything important was inside the boundary, trusting the network made sense.

That environment no longer describes most organizations. Several factors have eroded the traditional perimeter:

- **Cloud and SaaS applications**: Business-critical workloads like email, collaboration tools, and line-of-business applications now run in the cloud, outside the corporate network entirely.
- **Remote and hybrid work**: Employees connect from home networks, public Wi-Fi, and locations around the world. Their traffic may never pass through the corporate perimeter.
- **Personal devices (BYOD)**: Employees access corporate resources on personal phones, tablets, and laptops that the organization doesn't fully manage or control.
- **Partner and customer access**: External users—vendors, contractors, and customers—need access to specific resources without becoming part of the internal network.
- **IoT devices**: Connected devices throughout facilities and customer locations access organizational networks, often using credentials and interfaces that are difficult to manage through traditional tools.

When trusted users and unmanaged devices all connect from outside the traditional network boundary, the perimeter alone is no longer a reliable security control. An attacker who compromises a VPN credential or a cloud account can bypass perimeter defenses entirely.

## Identity as the new security perimeter

If you can't reliably control who or what is on your network, what *can* you use as a security boundary? The answer is identity.

An *identity* is the set of attributes that define or characterize a person, device, or software component. A user's identity might include their username, their organizational role, their assigned permissions, and the authentication methods registered to their account. A device's identity might include its hardware ID, its management enrollment status, and whether it meets compliance standards.

When an identity—whether a user, a device, or an application—requests access to a resource, that identity becomes the central point of verification. Rather than asking "Is this request coming from inside our corporate network?", the security question becomes: "Who or what is making this request, and should it be trusted?"

:::image type="content" source="../media/3-identity-new-security-perimeter.png" alt-text="Diagram showing identity at the center connecting employees, partners and customers, cloud apps, on-premises apps, and devices—illustrating identity as the new security perimeter." lightbox="../media/3-identity-new-security-perimeter.png":::

This is why *identity is the new security perimeter*. Every access decision starts with identity. Verifying identity—and controlling what each identity is authorized to do—is the fundamental security control for a world where work and data are no longer confined to a fixed location.

## Types of identities

Identities in a modern environment come in several types:

- **Human identities** represent people: employees, contractors, customers, and partners who sign in to access applications and data.
- **Device identities** represent hardware: laptops, mobile phones, tablets, and IoT sensors that connect to organizational systems. A device can be enrolled in management, checked for compliance, and trusted or restricted based on its state.
- **Workload identities** represent software: applications, services, containerized workloads, and automated processes that access APIs, databases, and other resources without a human user actively involved.

All three types of identities need to be authenticated and authorized. A compromised application credential can give an attacker the same access as a compromised user account. A device that doesn't meet compliance standards can be used to access sensitive data. Treating identity holistically—across users, devices, and workloads—is essential to a strong security posture.

## Four pillars of an identity infrastructure

Managing identity across an organization requires more than just usernames and passwords. Organizations need a comprehensive approach that covers the full lifecycle of every identity—from creation through removal. This approach can be organized into four fundamental pillars:

- **Administration**: The creation, management, and governance of identities for users, devices, and services. Administration covers how identities are created and assigned (provisioning), how they're updated when roles change, and how they're removed when a user leaves the organization (deprovisioning). It also includes defining the policies that govern how identities are managed across the organization.

- **Authentication**: The process of verifying that an identity is who or what it claims to be. It involves challenging the identity for legitimate credentials to provide sufficient proof before granting access.

- **Authorization**: The process of determining what an authenticated identity is allowed to do. Authorization evaluates assigned permissions and the context of the access request, then grants or restricts access accordingly. The goal is to ensure that identities can only access what they need for their specific role or task.

- **Auditing**: The tracking and recording of who did what, when, and from where. Auditing encompasses sign-in logs, activity reports, alerts on anomalous behavior, and forensic investigation capabilities. Auditing is essential for meeting compliance requirements, detecting security incidents, and understanding the scope of a breach.

Together, these four pillars form the foundation of a comprehensive identity and access management solution. Addressing each pillar—not just authentication—is key to protecting resources in a world where identity is the primary security boundary.
