
Microsoft Entra is Microsoft's family of identity and network access products. As organizations adopt Zero Trust security models, they need solutions that go beyond basic authentication to cover identity governance, verified credentials, secure network access, and identities for AI agents. In this unit, you explore the Microsoft Entra product family and how these products work together to secure end-to-end access for employees, customers, partners, workloads, and AI agents across any cloud environment.

The Microsoft Entra family is organized around the access scenarios it secures.

| Category | What it covers |
| ---------- | ------------- |
| Establish Zero Trust access controls | Foundational identity, authentication, and managed domain services |
| Secure access for employees | Identity governance, identity protection, secure network access, and verified credentials |
| Secure access for customers and partners | External collaboration and customer identity and access management (CIAM) |
| Secure access in any cloud | Identities for applications, services, and workloads |
| Secure access for AI agents | Identity, governance, and protection for nonhuman AI agent identities |

## Understand the Microsoft Entra product family

Each category in the Microsoft Entra family maps to a specific access scenario that organizations commonly face. The following sections describe the key products in each category and what they do.

### Establish Zero Trust access controls

**Microsoft Entra ID** is the foundational product of the family. It's a cloud-based identity and access management service that provides authentication, single sign-on (SSO), policy enforcement, and protection for users, devices, apps, and resources. If your organization uses Microsoft 365, Azure, or Dynamics CRM Online, you're already using Microsoft Entra ID. Every tenant of those services is automatically a Microsoft Entra tenant, with an initial domain name like `contoso.onmicrosoft.com`. Organizations can also add their own custom domain names.

**Microsoft Entra Domain Services** provides managed domain services for organizations that run older applications in the cloud that require traditional Windows Server Active Directory features. It lets those applications work in the cloud without needing to deploy and manage domain controllers. Microsoft manages the underlying infrastructure, so organizations don't have to.

### Secure access for employees

This category groups the products most organizations use to govern, protect, and connect their workforce.

- **Microsoft Entra Private Access** secures access to private apps and resources, including corporate networks and multicloud environments. Remote users can connect to internal resources from any device or network without a virtual private network (VPN). For example, an employee can securely reach a corporate network printer while working from home or a cafe.
- **Microsoft Entra Internet Access** secures access to internet resources, including software as a service (SaaS) apps and Microsoft 365 apps and resources. Administrators can enable web content filtering to regulate access to websites based on content categories and domain names.
- **Microsoft Entra ID Governance** simplifies identity and permissions management by automating access requests, assignments, and reviews. It also helps protect critical assets through identity lifecycle management. For example, administrators can automatically assign user accounts, groups, and licenses to new employees and remove those assignments when employees leave.
- **Microsoft Entra ID Protection** detects and reports identity-based risks, such as risky users and risky sign-ins. Administrators can investigate and automatically remediate risks using tools like risk-based Conditional Access policies. A common scenario is a policy that requires multifactor authentication (MFA) when the sign-in risk level is medium or high.
- **Microsoft Entra Verified ID** is a credential verification service based on open decentralized identity (DID) standards. Organizations can issue verifiable credentials—digital signatures that prove the validity of information—to users, who store the credentials on their personal devices and present them when needed. For example, a recent college graduate can ask their university to issue a digital diploma to their DID, then present it to a potential employer who can independently verify the issuer, issuance time, and status.

### Secure access for customers and partners

**Microsoft Entra External ID** lets external identities safely access business resources and consumer apps. It provides secure methods for collaborating with business partners and guests on internal apps, and for managing customer identity and access management (CIAM) in consumer-facing applications. For example, an organization can set up self-service registration so customers sign in to a web application using one-time passcodes or social accounts from providers like Google or Facebook.

### Secure access in any cloud

**Microsoft Entra Workload ID** is the identity and access management solution for workload identities—applications, services, and containers that need authentication and authorization policies. It lets organizations secure access to resources using adaptive policies and custom security attributes. For example, GitHub Actions need a workload identity to access Azure subscriptions and run software development workflows.

### Secure access for AI agents

**Microsoft Entra Agent ID** is an identity and security framework that extends Microsoft Entra capabilities to AI agents. As organizations deploy assistive, autonomous, and user-like agents, Agent ID provides purpose-built identity constructs to authenticate, authorize, govern, and protect these nonhuman identities at enterprise scale. For example, when an organization deploys AI agents that access corporate data on behalf of users, Agent ID gives each agent a governed identity, enforces least-privilege access, and maintains an audit trail of the agent's actions.

## How Microsoft Entra products work together

The strength of the Microsoft Entra family is how its products integrate. Consider a scenario where a new employee joins your organization:

1. **Microsoft Entra ID** authenticates the employee and provides single sign-on to corporate apps.
2. **Microsoft Entra ID Governance** automatically provisions the right access based on the employee's role.
3. **Microsoft Entra ID Protection** evaluates each sign-in for risk and triggers stronger authentication when needed.
4. **Microsoft Entra Internet Access** secures the employee's connection to cloud and internet resources.
5. **Microsoft Entra Private Access** provides secure access to on-premises apps without a VPN.

This integrated approach reduces the security gaps that occur when organizations use disconnected tools for identity and network access management.

## Microsoft Entra licensing

Each product in the Microsoft Entra family can be used independently, but the products deliver the most value when used together as part of a comprehensive identity and access strategy. Microsoft Entra ID is available in several licensing tiers, and additional products can be added or bundled depending on an organization's needs:

- **Microsoft Entra ID Free** — Included with Microsoft cloud subscriptions such as Microsoft Azure and Microsoft 365. Provides core identity capabilities including user and group management, basic reporting, and self-service password reset.
- **Microsoft Entra ID P1** — Adds capabilities such as Conditional Access, hybrid identity support, and advanced group features. Included with Microsoft 365 E3, F1, F3, Enterprise Mobility + Security E3, and Microsoft 365 Business Premium.
- **Microsoft Entra ID P2** — Adds risk-based Conditional Access, Microsoft Entra ID Protection, and Privileged Identity Management (PIM). Included with Microsoft 365 E5 and Enterprise Mobility + Security E5.
- **Microsoft Entra Suite** — A bundled license that combines five Entra products under a single offering, designed for organizations that want comprehensive identity and network access protection. A Microsoft Entra ID P1 subscription is required. The suite includes Microsoft Entra Private Access, Microsoft Entra Internet Access, Microsoft Entra ID Governance, Microsoft Entra ID Protection, and premium capabilities of Microsoft Entra Verified ID.

Microsoft Entra also integrates with Security Copilot to help administrators investigate identity risks and troubleshoot access issues using AI.

## Microsoft Entra admin center

Administrators configure and manage all Microsoft Entra products from a single web-based portal called the **Microsoft Entra admin center**.

Now that you have a high-level understanding of the Microsoft Entra product family, the rest of this module focuses on Microsoft Entra ID—the foundational product of the family. You learn about its core functions, the identity types it supports, the concept of hybrid identity, and how external identities work.
