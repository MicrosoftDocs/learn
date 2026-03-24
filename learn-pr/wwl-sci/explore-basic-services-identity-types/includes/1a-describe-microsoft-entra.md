<!-- markdownlint-disable MD041 -->
Microsoft Entra is Microsoft's family of identity and network access products. As organizations adopt Zero Trust security models, they need solutions that go beyond basic authentication to cover identity governance, verified credentials, and secure network access. In this unit, you explore the Microsoft Entra product family, its core categories, and how these products work together to secure identities across your environment.

| Category | Description |
| ---------- | ------------- |
| Identity and access management | Secure authentication and access to apps and resources |
| Identity governance | Automate identity lifecycle and enforce access policies |
| Identity protection | Detect and remediate identity-based risks |
| Network access | Secure access to apps and resources based on identity |
| Verified identity | Issue and verify credentials for decentralized identity |

## Understand the Microsoft Entra product family

Microsoft Entra brings together several identity and network access capabilities under a single brand. Before Microsoft Entra, many of these capabilities existed as standalone services. The Microsoft Entra family consolidates them to give organizations a unified approach to securing identities and access.

The core products in the Microsoft Entra family include:

- **Microsoft Entra ID** — The cloud-based identity and access management service, formerly known as Azure Active Directory (Azure AD). It provides authentication, single sign-on (SSO), and conditional access for users and applications.
- **Microsoft Entra ID Governance** — Automates identity lifecycle management, access reviews, and entitlement management to ensure the right people have the right access at the right time.
- **Microsoft Entra External ID** — Enables secure collaboration with external users such as partners, customers, and consumers through customizable sign-up and sign-in experiences.
- **Microsoft Entra Verified ID** — Enables organizations to issue and verify decentralized identity credentials, letting users control their own identity data.
- **Microsoft Entra Internet Access** — An identity-centric Secure Web Gateway (SWG) that protects access to internet and SaaS applications.
- **Microsoft Entra Private Access** — Provides Zero Trust Network Access (ZTNA) to private apps and resources without requiring a traditional VPN.

## How Microsoft Entra products work together

The strength of the Microsoft Entra family lies in how its products integrate with each other. Consider a scenario where an employee joins your organization:

1. **Microsoft Entra ID** authenticates the employee and provides single sign-on to corporate apps.
2. **Microsoft Entra ID Governance** automatically provisions the right access based on the employee's role.
3. **Microsoft Entra Internet Access** secures the employee's connection to cloud and internet resources.
4. **Microsoft Entra Private Access** provides secure access to on-premises apps without a VPN.

This integrated approach reduces security gaps that occur when organizations use disconnected tools for identity and network access management.

> [!NOTE]
> Each product in the Microsoft Entra family can be used independently, but they deliver the most value when used together as part of a comprehensive identity and access strategy.

Now that you have a high-level understanding of the Microsoft Entra product family, the rest of this module dives deeper into Microsoft Entra ID specifically. You learn about its core functions, the identity types it supports, the concept of hybrid identity, and how external identities work.
