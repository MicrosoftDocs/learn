---
uid: learn.wwl.design-identity-security-strategy.secure-conditional-access
title: Secure conditional access
description: Secure conditional access
durationInMinutes: 10
---
[Conditional access](/azure/active-directory/conditional-access/overview) is a key part of Zero Trust because it helps to ensure the right user has the right access to the right resources. Enabling Conditional Access allows Azure Active Directory to make access decisions based on computed risk and pre-configured policies. Independent software vendors can take advantage of conditional access by surfacing the option to apply conditional access policies when relevant.

## Requirements

Every company has different requirements and security policies. When you
create an architecture and follow this suggested framework for
Conditional Access, consider the company's requirements. The guidance
includes principles related to Zero Trust that can be used as input when
you create an architecture. Then, address specific company requirements
and policies and adjust the architecture accordingly.

For example, a company might have these requirements:

-   At least two factors must protect all access.
-   No data on unmanaged devices.
-   No guest access is allowed.
-   Access to cloud services must be based on password-less authentication.

## Conditional access guidance

This section includes the following articles:

-   [Conditional Access design principles and dependencies](/azure/architecture/guide/security/conditional-access-design) provide recommended principles that, together with your company's requirements, serve as input to the suggested persona-based architecture.

-   [Conditional Access architecture and personas](/azure/architecture/guide/security/conditional-access-architecture) introduce the persona-based approach for structuring Conditional Access policies. It also provides suggested personas to use as a starting point.

-   [Conditional Access framework and policies](/azure/architecture/guide/security/conditional-access-framework) provide specific details on how to structure and name Conditional Access policies based on the personas.

## Conditional Access as a Zero Trust policy engine

The Microsoft approach to Zero Trust includes Conditional Access as the
main policy engine. Here's an overview of that approach:

![Diagram showing an overview of the Zero Trust model.](../media/components-zero-trust-model.png) 

Download an [SVG file](https://arch-center.azureedge.net/zero-trust-model.svg) of this architecture.

Conditional Access is used as the policy engine for a Zero Trust
architecture that covers both policy definition and policy enforcement.
Based on various signals or conditions, Conditional Access can block or
give limited access to resources, as shown here:

![Diagram showing an overview of the Conditional Access signal, decision, enforcement path.](../media/signal-decision-enforcement.png) 

## Conditional access Zero Trust architecture

You first need to choose an architecture. We recommend that considering
either a Targeted or a Zero Trust Conditional Access architecture. This
diagram shows the corresponding settings:

![Diagram showing the settings for Targeted and Zero Trust architectures.](../media/targeted-and-zero-trust-architecture.png) 

The **Zero Trust Conditional Access architecture** is the one that best
fits the principles of Zero Trust. If the **All cloud apps** option in a
Conditional Access policy is selected, all endpoints are protected by
the provided grant controls, like known users and known or compliant
devices. But the policy doesn't just apply to the endpoints and apps
that support Conditional Access. It applies to any endpoint that the
user interacts with.

The challenge with this sign-in is that it doesn't support device-based
Conditional Access. This means that nobody can use the tools and
commands if you apply a baseline policy requiring known users and known
devices for all cloud apps. Other applications have the same problem
with device-based Conditional Access.

The **other architecture, the Targeted one**, is built on the principle
that you target only individual apps you want to protect in Conditional
Access policies. In this case, endpoints like device-login endpoints
aren't protected by the Conditional Access policies, so they continue
to work.

The challenge with this architecture is that you might forget to protect
all your cloud apps. The number of Office 365 and Azure Active Directory
(Azure AD) apps increases as Microsoft and partners release new
features, and your IT admins integrate various applications with Azure
AD.

## Design conditional access personas

There are many ways to structure Conditional Access policies. One
approach is to structure policies based on the sensitivity of the
resource being accessed. In practice, this approach can be difficult to
implement in a way that still protects access to resources for various
users.

Another approach is defining access policies based on where a user is in
the organization. This approach might result in many Conditional Access
policies and might be unmanageable.

A better approach is to structure policies related to common access
needs and bundle a set of access needs in a persona for a group of users
who have the same needs. Personas are identity types that share common
enterprise attributes, responsibilities, experiences, objectives, and
access. Understanding how enterprise assets and resources are accessed
by various personas is integral to developing a comprehensive Zero Trust
strategy.

## Suggested conditional access personas from Microsoft

Microsoft also recommends defining a separate persona for identities that aren't part of any other persona group. This is called the Global persona. Global is meant to enforce policies for identities that aren't in a persona group and policies that should be enforced for all personas.

The following list describes some recommended personas.

* `Global` - Global is a persona/placeholder for policies that are general. It's used to define policies that apply to all personas or that don't apply to one specific persona. Use it for policies that aren't covered by other personas. You need this persona to protect all relevant scenarios.
* `Admins` - In this context, an admin is any non-guest identity, cloud or synced, that has any Azure AD or other Microsoft 365 admin role (for example, in Microsoft Defender for Cloud Apps, Exchange, Defender for Endpoint, or Compliance Manager). Because guests who have these roles are covered in a different persona, guests are excluded from this persona.
* `Developers` - The Developers persona contains users who have unique needs. They're based on Active Directory accounts synced to Azure AD, but they need special access to services like Azure DevOps, CI/CD pipelines, device code flow, and GitHub. The Developers persona can include users considered internal and others considered external, but a person should be in only one of the personas.
* `Internals` - Internals contains all users who have an Active Directory account synced to Azure AD, are employees of the company and work in a standard end-user role. We recommend that you add internal users who are developers to the Developers persona.
* `Externals` - This persona holds all external consultants who have an Active Directory account synced to Azure AD. We recommend that you add external users who are developers to the Developers persona.
* `Guests` - Guests hold all users who have an Azure AD guest account invited to the customer tenant.
* `GuestAdmins` - The GuestAdmins persona holds all users who have an Azure AD guest account assigned any of the previously mentioned admin roles.
* `Microsoft365ServiceAccounts` - This persona contains cloud (Azure AD) user-based service accounts used to access Microsoft 365 services when no other solution meets the need, like using a managed service identity.
* `AzureServiceAccounts` - This persona contains cloud (Azure AD) user-based service accounts that are used to access Azure (IaaS/PaaS) services when no other solution meets the need, like using a managed service identity.
* `CorpServiceAccounts` - This persona contains user-based service accounts that have all of these characteristics:
    * Originate from on-premises Active Directory. Originate from on-premises Active Directory
    * They are used from on-premises or an IaaS-based virtual machine in another (cloud) datacenter, like Azure.
    * Are synced to an Azure AD instance that accesses any Azure or Microsoft 365 service. Note that this scenario should be avoided.
* `WorkloadIdentities` - This persona contains machine identities, like Azure AD service principals and managed identities. Conditional Access now supports protecting access to resources from these

## Access template cards

We recommend that you use access template cards to define the
characteristics of each persona. Here's an example:

:::image type="content" source="../media/employee.png" alt-text="Diagram showing an example of an access template card." lightbox="../media/employee.png":::

The template card for each persona provides input for creating the specific Conditional Access policies for each persona.

## Conditional access framework and policies

Important factors to remember in the creation of conditional access
policies include:

-   Naming conventions - A properly defined naming convention helps you and your colleagues understand the purpose of a policy, which enables easier policy management and troubleshooting. Your naming convention should fit the framework you use to structure your policies.
-   Numbering Scheme - use a standard and predictable numbering scheme
-   Policy types - recommended types include `BaseProtection`, `IdentityProtection`, `DataProtection`, `AppProtection`, `AttackSurfaceReduction` and `Compliance`
-   Standard policy components - Apps, platform types, grant control types, named locations should all be defined in advanced to ensure consistency across all policies

For more details on the recommended framework for conditional access policies, see [Conditional Access framework and policies](/azure/architecture/guide/security/conditional-access-framework).

For more detailed guidance on configuring Conditional Access, view the following interactive guide.

[:::image type="content" source="../media/configure-conditional-access-interactive-guide.png" alt-text="Cover for an interactive guide that says Configure Conditional Access in Azure AD." border="true":::](https://mslearn.cloudguides.com/guides/Configure%20Conditional%20Access%20in%20Azure%20AD)