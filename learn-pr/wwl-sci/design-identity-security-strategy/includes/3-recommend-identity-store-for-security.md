
Azure Active Directory is Microsoft's cloud-based identity and access
management service. It provides single sign-on authentication,
conditional access, password-less and multifactor authentication,
automated user provisioning, and many more features that enable
enterprises to protect and automate identity processes at scale.

## Azure Active Directory

There are many ways to integrate your solution with Azure Active
Directory. Foundational integrations are about protecting your customers
using Azure Active Directory's built-in security capabilities. Advanced
integrations will take your solution one step further with enhanced
security capabilities.

![Diagram showing components of a zero trust integration: single sign-on and publisher verification and conditional access.](../media/key-components-identity-zero-trust-integrations.png)

## Foundational integrations

Foundational integrations protect your customers with Azure Active Directory's built-in security capabilities.

### Enable single sign-on and publisher verification

To enable single sign-on, we recommend publishing your app in [the app gallery](https://www.microsoft.com/security/business/identity-access-management/integrated-apps-azure-ad).
This will increase customer trust because they know that your application has been validated as compatible with Azure Active Directory, and you can become a [verified publisher](/azure/active-directory/develop/publisher-verification-overview) so
that customers are certain you're the publisher of the app they're adding to their tenant.

Publishing the app gallery will make it easy for IT admins to integrate
the solution into their tenant with automated app registration. Manual
registrations are a common cause of support issues with applications.
Adding your app to the gallery will avoid these issues with your app.

### Integrate user provisioning

Managing identities and access for organizations with thousands of users
are challenging. If large organizations use your solution, consider
synchronizing information about users and access between your
application and Azure Active Directory. This helps keep user access
consistent when changes occur.

SCIM (System for Cross-Domain Identity Management) is an open standard
for exchanging user identity information. Use the SCIM user management
API to automatically provision users and groups between your application
and Azure Active Directory.

### Azure Active Directory B2C

Azure Active Directory B2C is a customer identity and access management
(CIAM) solution capable of supporting millions of users and billions of
authentications per day. It is a white-label authentication solution
that enables user experiences that blend with branded web and mobile
applications.

As with Azure Active Directory, partners can integrate with Azure Active
Directory B2C by using [Microsoft Graph](/azure/active-directory-b2c/microsoft-graph-operations) and
key security APIs such as Conditional Access, confirm compromise, and
risky user APIs. Read more about those integrations in the Azure AD
section above.

### Integrate with RESTful endpoints

Independent software vendors can integrate their solutions via RESTful
endpoints to enable multifactor authentication (MFA) and role-based
access control (RBAC), enable identity verification and proofing,
improve security with bot detection and fraud protection, and meet
Payment Services Directive 2 (PSD2) Secure Customer Authentication (SCA)
requirements.

We have [guidance on how to use our RESTful endpoints](/azure/active-directory-b2c/api-connectors-overview?pivots=b2c-user-flow) as well as detailed sample walk-throughs of partners who have integrated using the RESTful APIs:
- [Identity verification and proofing](/azure/active-directory-b2c/partner-gallery#identity-verification-and-proofing), which enables customers to verify the identity of their end users
- [Role-based access control](/azure/active-directory-b2c/partner-gallery#role-based-access-control), which enables granular access control to end users
- [Secure hybrid access to the on-premises application](/azure/active-directory-b2c/partner-gallery#role-based-access-control), which enables end users to access on-premises and legacy applications with modern authentication protocols
- [Fraud protection](/azure/active-directory-b2c/partner-gallery#fraud-protection), which enables customers to protect their applications and end users from fraudulent login attempts and bot attacks