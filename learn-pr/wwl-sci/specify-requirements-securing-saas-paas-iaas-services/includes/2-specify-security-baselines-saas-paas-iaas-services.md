As a security architect, you define security baselines that establish minimum security configurations for cloud resources. Security baselines translate organizational security requirements into actionable, measurable controls that can be consistently applied across SaaS, PaaS, and IaaS services.

## Understand the shared responsibility model

Before specifying security baselines, you need to understand where your security responsibilities begin and end. The shared responsibility model defines which security tasks your cloud provider handles and which tasks you handle. These responsibilities vary by service model.

| Responsibility area | IaaS | PaaS | SaaS |
|---|---|---|---|
| Customer data | Customer | Customer | Customer |
| Identities and access management | Customer | Customer | Customer |
| Applications | Customer | Shared | Shared |
| Network controls | Customer | Shared | Microsoft |
| Operating system | Customer | Microsoft | Microsoft |
| Physical infrastructure | Microsoft | Microsoft | Microsoft |

In IaaS deployments, you manage virtual machines, operating systems, and applications. PaaS shifts operating system and infrastructure management to Microsoft, but you remain responsible for application configuration and access controls. SaaS applications require you to focus primarily on data protection and identity management.

Regardless of service model, you always retain responsibility for protecting your data, managing identities, configuring access controls, and securing endpoints that access cloud services.

:::image type="content" source="../media/shared-responsibility.png" alt-text="Diagram showing the division of security responsibilities between customer and cloud provider across SaaS, PaaS, and IaaS deployment models.":::

## Use the Microsoft cloud security benchmark

The [Microsoft cloud security benchmark (MCSB)](/security/benchmark/azure/introduction) provides the canonical framework for specifying security baselines in Azure. MCSB defines security controls aligned with industry standards including CIS Controls, NIST SP 800-53, PCI-DSS, and ISO 27001.

MCSB organizes security guidance into 12 security domains:

- **Network security**: Secure virtual networks, establish private connections, and prevent external attacks
- **Identity management**: Implement secure identity and access controls with strong authentication
- **Privileged access**: Protect administrative accounts and privileged access workstations
- **Data protection**: Control data at rest and in transit through encryption and access controls
- **Asset management**: Ensure security visibility and governance over resources
- **Logging and threat detection**: Enable detection, collection, and analysis of security events
- **Incident response**: Prepare for and respond to security incidents
- **Posture and vulnerability management**: Assess and improve security configuration continuously
- **Endpoint security**: Deploy endpoint detection and response capabilities
- **Backup and recovery**: Protect data through validated backup and recovery processes
- **DevOps security**: Integrate security into development and deployment pipelines
- **Artificial intelligence security**: Secure AI platform, applications, and monitoring

When specifying security baselines, map your organizational requirements to the relevant MCSB security domains and controls. Each Azure service has a published security baseline that provides service-specific guidance for implementing MCSB controls.

## Specify IaaS security baselines

IaaS provides the most flexibility but also requires you to manage the largest portion of the security stack. Your IaaS security baseline should address the following areas.

### Authentication and access control

Ensure that only authorized users can provision and access virtual machines. Use [Azure Policy](/azure/governance/policy/overview) to establish conventions for resources and create policies that enforce security standards. Apply policies at the management group or subscription level so VMs inherit them automatically.

### Endpoint protection

Require antimalware solutions on all virtual machines. Deploy [Microsoft Defender for Endpoint](/microsoft-365/security/defender-endpoint/microsoft-defender-endpoint) or supported endpoint protection solutions. Use [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) to monitor endpoint protection status and remediate gaps.

### Update management

Establish patching requirements and timelines for operating systems and applications. Use [Azure Update Manager](/azure/update-manager/overview) to assess update status, schedule maintenance windows, and deploy updates across Windows and Linux machines in Azure, on-premises, and other cloud environments.

### Disk encryption

Require encryption for virtual hard disks to protect data at rest. [Azure Disk Encryption](/azure/virtual-machines/disk-encryption-overview) uses DM-Crypt for Linux and BitLocker for Windows to provide volume encryption. Integrate with [Azure Key Vault](/azure/key-vault/general/overview) to control and manage encryption keys.

### Network segmentation

Restrict direct internet connectivity for management interfaces. Use network security groups to control traffic flow between subnets. Implement [just-in-time VM access](/azure/defender-for-cloud/just-in-time-access-overview) to reduce exposure to brute-force attacks on management ports.

## Specify PaaS security baselines

PaaS services shift infrastructure management to Microsoft, which changes your security focus. Your PaaS security baseline should emphasize identity-centric controls rather than traditional network perimeters.

### Adopt identity as the primary security perimeter

Modern security practices assume that adversaries can breach network perimeters. Identity becomes your primary defense layer. Organizations must establish identity-based security with strong authentication and authorization.

![Diagram showing identity as the new security perimeter.](../media/identity-perimeter.png)

Your PaaS baseline should require:

- **Microsoft Entra Conditional Access** for administrative and sensitive workloads
- **Multifactor authentication** for all users, with phishing-resistant methods like passkeys or FIDO2 for privileged roles
- **Privileged Identity Management (PIM)** to eliminate standing privileges for administrative access
- **Managed identities** for application authentication to avoid credential storage in code

### Application security controls

For web applications hosted on [Azure App Service](/azure/app-service/overview) or similar PaaS platforms, specify baseline requirements for:

- **Authentication**: Integrate with Microsoft Entra ID using OAuth 2.0 and OpenID Connect
- **Transport security**: Enforce HTTPS-only traffic and require TLS 1.2 or higher
- **Key protection**: Store secrets, certificates, and encryption keys in [Azure Key Vault](/azure/key-vault/general/overview)
- **Web application firewall**: Deploy [Azure WAF](/azure/web-application-firewall/overview) to protect against common exploits like SQL injection and cross-site scripting

### DDoS protection

Include DDoS protection requirements in your baseline. [Azure DDoS Protection](/azure/ddos-protection/ddos-protection-overview) provides enhanced mitigation capabilities for network-layer attacks. For application-layer protection, combine DDoS Protection with a web application firewall.

## Specify SaaS security baselines

SaaS applications require you to focus on data protection, identity management, and integration security. Use [Microsoft Defender for Cloud Apps](/defender-cloud-apps/what-is-defender-for-cloud-apps) to discover SaaS applications in your environment, assess their risk, and enforce security policies.

Your SaaS baseline should address:

- **App discovery and assessment**: Inventory SaaS applications and evaluate their security posture
- **Access governance**: Implement Conditional Access policies that control how users access SaaS apps
- **Data protection**: Apply sensitivity labels and data loss prevention policies to prevent unauthorized data sharing
- **Session controls**: Use real-time session monitoring and controls for sensitive operations

## Implement continuous baseline monitoring

Specifying a security baseline is only effective when you monitor compliance and remediate drift. Use [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) to:

- Assess resources against MCSB controls automatically
- View compliance status in the regulatory compliance dashboard
- Generate recommendations for configuration gaps
- Track secure score to measure security posture improvements

Enable the Foundational CSPM (Cloud Security Posture Management) plan to assess resources against the Microsoft cloud security benchmark. For enhanced capabilities, enable paid Defender plans that provide workload-specific threat protection for servers, storage, databases, and containers.

Schedule regular security tests including penetration testing and vulnerability scanning. Use automated tools to detect configuration drift and enforce remediation to maintain baseline compliance across your cloud environment.
