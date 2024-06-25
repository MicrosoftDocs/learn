Microsoft Entra ID Governance is an identity governance solution that enables organizations to improve productivity, strengthen security and more easily meet compliance and regulatory requirements. You can use Microsoft Entra ID Governance to automatically ensure that the right people have the right access to the right resources, with identity and access process automation, delegation to business groups, and increased visibility. With the features included in Microsoft Entra ID Governance, along with those in related Microsoft Entra, Microsoft Security and Microsoft Azure products, you can mitigate identity and access risks by protecting, monitoring, and auditing access to critical assets.

Specifically, Microsoft Entra ID Governance helps organizations address these four key questions, for access across services and applications both on-premises and in clouds:

 -  Which users should have access to which resources?<br>
 -  What are those users doing with that access?
 -  Are there organizational controls in place for managing access?
 -  Can auditors verify that the controls are working effectively?

With Microsoft Entra ID Governance you can implement the following scenarios for employees, business partners and vendors:

 -  Govern the identity lifecycle<br>
 -  Govern the access lifecycle
 -  Secure privileged access for administration

## Identity lifecycle

Identity Governance helps organizations achieve a balance between productivity - How quickly can a person have access to the resources they need, such as when they join my organization? And security - How should their access change over time, such as due to changes to that person's employment status? Identity lifecycle management is the foundation for Identity Governance, and effective governance at scale requires modernizing the identity lifecycle management infrastructure for applications.

:::image type="content" source="../media/identity-lifecycle-aa35b39e.png" alt-text="Diagram showing an example of the identity lifecycle.":::


For many organizations, identity lifecycle for employees and other workers is tied to the representation of that person in an HCM (human capital management) or HR system. Organizations need to automate the process of creating an identity for a new employee that is based on a signal from that system so that the employee can be productive on day 1. And organizations need to ensure those identities and access are removed when the employee leaves the organization.

In Microsoft Entra ID Governance, you can automate the identity lifecycle for these individuals using:

 -  inbound provisioning from your organization's HR sources, including retrieving from Workday and SuccessFactors, to automatically maintain user identities in both Active Directory and Microsoft Entra ID.<br>
 -  lifecycle workflows to automate workflow tasks that run at certain key events, such before a new employee is scheduled to start work at the organization, as they change status during their time in the organization, and as they leave the organization. For example, a workflow can be configured to send an email with a temporary access pass to a new user's manager, or a welcome email to the user, on their first day.
 -  automatic assignment policies in entitlement management to add and remove a user's group memberships, application roles, and SharePoint site roles, based on changes to the user's attributes.
 -  user provisioning to create, update and remove user accounts in other applications, with connectors to hundreds of cloud and on-premises applications via System for Cross-domain Identity Management (SCIM), Lightweight Directory Access Protocol (LDAP) and Structured Query Language (SQL).

Organizations also need additional identities, for partners, suppliers and other guests, to enable them to collaborate or have access to resources.

In Microsoft Entra ID Governance, you can enable business groups to determine which of these guests should have access, and for how long, using:

 -  entitlement management in which you can specify the other organizations whose users are allowed to request access to your organization's resources. When such a user request is approved, they are automatically added by entitlement management as a B2B guest to your organization's directory, and assigned appropriate access. And entitlement management automatically removes the B2B guest user from your organization's directory when their access rights expire or are revoked.<br>
 -  access reviews that automate recurring reviews of existing guests already in your organization's directory, and removes those users from your organization's directory when they no longer need access.

## Access lifecycle

Organizations need a process to manage access beyond what was initially provisioned for a user when that user's identity was created. Furthermore, enterprise organizations need to be able to scale efficiently to be able to develop and enforce access policy and controls on an ongoing basis.

:::image type="content" source="../media/access-lifecycle-8d743094.png" alt-text="Diagram showing an example of the access lifecycle.":::


With Microsoft Entra ID Governance, IT departments can establish what access rights users should have across various resources, and what enforcement checks such as separation of duties or access removal on job change are necessary. Microsoft Entra ID has connectors to hundreds of cloud and on-premises applications, and you can integrate your organization's other apps that rely upon Microsoft Entra ID groups, other on-premises directories or databases, that have a Simple Object Access Protocol (SOAP\*\*)\*\* or Representational State Transfer (REST) API including Systems Applications and Products (SAP), or that implement standards such as System for Cross-domain Identity Management (SCIM\*\*)**, Security Assertion Markup Language (SAML**)\*\* or OpenID Connect. When a user attempts to sign into to one of those applications, Microsoft Entra ID enforces Conditional Access policies. For example, Conditional Access policies can include displaying terms of use and ensuring the user has agreed to those terms prior to being able to access an application. For more information, see govern access to applications in your environment, including how to define organizational policies for governing access to applications, integrate applications and deploy policies.

Access changes across apps and groups can be automated based on attribute changes. Microsoft Entra lifecycle workflows and Microsoft Entra entitlement management automatically add and remove users into groups or access packages, so that access to applications and resources is updated. Users can also be moved when their condition within the organization changes to different groups, and can even be removed entirely from all groups or access packages.

Organizations that previously had been using an on-premises identity governance product can migrate their organizational role model to Microsoft Entra ID Governance.

Furthermore, IT can delegate access management decisions to business decision makers. For example, employees that wish to access confidential customer data in a company's marketing application in Europe may need approval from their manager, a department lead or resource owner, and a security risk officer. Entitlement management enables you to define how users request access across packages of group and team memberships, app roles, and SharePoint Online roles, and enforce separation of duties checks on access requests.

Organizations can also control which guest users have access, including to on-premises applications. These access rights can then be regularly reviewed using recurring Microsoft Entra access reviews for access recertification.

## Privileged access lifecycle

Governing privileged access is a key part of modern Identity Governance especially given the potential for misuse associated with administrator rights can cause to an organization. The employees, vendors, and contractors that take on administrative rights need to have their accounts and privileged access rights governed.

:::image type="content" source="../media/privileged-access-lifecycle-21c99e2d.png" alt-text="Diagram showing an example of the privileged access lifecycle.":::


Microsoft Entra Privileged Identity Management (PIM) provides additional controls tailored to securing access rights for resources, across Microsoft Entra, Azure, other Microsoft Online Services and other applications. The just-in-time access, and role change alerting capabilities provided by Microsoft Entra PIM, in addition to multifactor authentication and Conditional Access, provide a comprehensive set of governance controls to help secure your company's resources (directory, Microsoft 365, and Azure resource roles). As with other forms of access, organizations can use access reviews to configure recurring access re-certification for all users in privileged administrator roles.
