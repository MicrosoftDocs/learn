Applications don't just need to be protected from external threats. They also need secure identities to authenticate and access the Azure resources they depend on. Every application that connects to a database, reads from a storage account, or calls another service needs an identity. How you design the identity model for your workloads directly impacts your security posture.

This unit covers how to design a solution for workload identities in Microsoft Entra ID, including managed identities, service principals, and workload identity federation.

## Understanding workload identities

A workload identity is an identity assigned to a software workload, such as an application, service, script, or container, that enables it to authenticate and access other services and resources. In Microsoft Entra ID, workload identities take three forms:

- **Applications** are abstract entities defined by application objects. The application object is the global representation that describes how tokens are issued, which resources the application needs, and what actions the application can perform.
- **Service principals** are the local representation (instance) of an application in a specific tenant. They define what the application can actually do in that tenant, who can use it, and what resources it can access.
- **Managed identities** are a special type of service principal that eliminates the need for developers to manage credentials. Azure manages the identity lifecycle and credential rotation automatically.

### Human vs. workload identities

Human identities and workload identities have fundamentally different security characteristics. Human users typically have a single identity that accesses a broad range of resources. A software workload might use multiple credentials to access different resources, and those credentials need to be stored securely. Workload identities are harder to track (when they're created, when they should be revoked), and they often have broader access than individual human users because they operate at the service level.

The number of workload identities in most organizations is growing dramatically and often exceeds the number of human identities. Adversaries increasingly target workload identities because they tend to have weaker security controls than human accounts.

:::image type="content" source="../media/identity-types.png" alt-text="Diagram that shows different types of machine and human identities." border="true" lightbox="../media/identity-types.png":::

## Design with managed identities

Managed identities should be your default choice for workloads running on Azure. They eliminate credential management entirely because Azure handles the identity lifecycle, credential rotation, and token issuance automatically.

There are two types:

- **System-assigned managed identities** are tied to a specific Azure resource (such as a VM, App Service, or Function App). When the resource is deleted, the identity is deleted automatically. Use system-assigned identities when the workload runs on a single Azure resource and needs permissions tied to that resource's lifecycle.
- **User-assigned managed identities** are created as standalone Azure resources and can be assigned to one or more Azure resources. Use user-assigned identities when multiple resources need to share the same identity (such as in a load-balanced set of VMs) or when you need the identity to persist independently of individual resource lifecycles.

As an architect, design your solutions to use managed identities wherever possible. For Azure services that support managed identities (including App Service, Azure Functions, Virtual Machines, Azure Kubernetes Service, Azure Container Apps, Azure Logic Apps, and many others), there's no reason to use shared secrets or certificates for authentication.

## Workload identity federation

Not all workloads run on Azure. CI/CD pipelines in GitHub Actions, applications on Kubernetes clusters hosted outside Azure, and workloads on other cloud platforms also need to access Azure resources. Traditionally, these scenarios required storing client secrets or certificates, creating credentials that must be rotated and could be compromised.

Workload identity federation eliminates this problem by establishing a trust relationship between Microsoft Entra ID and an external identity provider (IdP). You configure a **user-assigned managed identity** or **app registration** in Microsoft Entra ID to trust tokens from the external IdP. Instead of exchanging secrets, the external workload obtains a token from its own IdP, and Microsoft Entra ID exchanges that token for an Azure access token based on the configured trust. No secrets are stored or transmitted.

Common federation scenarios include:

- **GitHub Actions** authenticating to Azure for CI/CD deployments.
- **Kubernetes workloads** (AKS, Amazon EKS, Google GKE, or on-premises clusters) using service account tokens federated with Microsoft Entra ID through OpenID Connect (OIDC) issuer configuration.
- **Workloads on other cloud platforms** (AWS, GCP) authenticating to Azure using their native identity tokens.
- **Azure compute workloads using app identities** where you assign a user-assigned managed identity to a VM or App Service and configure an app registration to trust that identity.

When designing federation, configure federated credential subjects narrowly. For GitHub Actions, restrict the subject to a specific repository, branch, or environment rather than allowing any workflow in an organization to authenticate.

## Secure workload identities

Assigning identities to workloads isn't sufficient. You need to secure those identities with the same rigor you apply to human accounts. Microsoft Entra Workload ID provides several capabilities for this purpose:

### Conditional Access for workload identities

Apply Conditional Access policies to service principals owned by your organization. For example, restrict workload identity sign-ins to specific named locations or require risk-based authentication. Continuous access evaluation (CAE) for workload identities enables real-time enforcement of these policies, revoking access immediately when conditions change rather than waiting for token expiration.

### Microsoft Entra ID Protection for workload identities

Detect risks to workload identities, including leaked credentials and anomalous sign-in patterns. Identity Protection applies machine learning models to detect suspicious activity for service principals, such as sign-ins from unexpected locations, impossible travel patterns, or access to resources outside normal behavior patterns.

### Access reviews for service principals

Review service principals and managed identities that are assigned to privileged Microsoft Entra directory roles. Access reviews, created through Privileged Identity Management (PIM), verify whether these workload identities still require their role assignments. Reviewers can confirm, remove, or adjust access to ensure that service principals don't retain unnecessary privileges. This capability requires Microsoft Entra Workload Identities Premium licensing in addition to Microsoft Entra ID P2 or Microsoft Entra ID Governance licensing.

## Architect design considerations

When designing workload identity solutions, apply these principles:

- **Eliminate secrets wherever possible.** Use managed identities for Azure workloads and workload identity federation for external workloads. Every stored secret is a potential compromise vector.
- **Apply least privilege.** Grant workload identities only the permissions they need. Use Azure role-based access control (RBAC) scope assignments at the narrowest possible level (resource, resource group) rather than broad subscription-level roles.
- **Monitor and audit.** Enable sign-in logging for workload identities and forward events to Microsoft Sentinel. Implement anomaly detection to identify unusual access patterns that may indicate compromise.
- **Lifecycle management.** Establish processes to review and remove unused service principals and application registrations. Set expiration policies on credentials where managed identities or federation aren't possible.
- **Avoid wildcard federation.** When configuring workload identity federation, use specific subject claims that restrict which external workloads can obtain Azure tokens. Overly broad federation rules create equivalent risk to oversharing a secret.


