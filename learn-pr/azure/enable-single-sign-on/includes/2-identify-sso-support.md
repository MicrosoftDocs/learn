A team asked the administrator of the retail company to add a new application to help with company promotion. The administrator searches for the application in the Azure Active Directory (Azure AD) application gallery and identifies single sign-on support for it. 

Employees in the retail company likely already have an account in the tenant for the organization, but for testing single sign-on for the application, the administrator should create a test user account. The administrator makes the application available to employees after successfully testing it with single sign-on configured.

## Azure AD application gallery

Azure AD has a gallery that contains thousands of pre-integrated applications. Many of the applications that the retail company uses are probably already in the gallery. When the administrator adds an application to the company's tenant, the following tasks are completed:

- Properties are configured for managing the application
- Users are assigned access
- Single sign-on is set up so that the users can sign in with their Azure AD credentials

You can use the following filters when searching for the application in the gallery:

- **Single sign-on options**: Search for applications that support these SSO types: SAML, OpenID Connect (OIDC), Password, or Linked. Listed as **Single Sign-on Mode** on the overview pane for an application in the gallery.
- **User account management**: The only option available is automated provisioning.
- **Categories**: When an application is added to the gallery, it can be classified in a specific category. Many categories are available, such as Business management, Collaboration, or Education.

Make sure to understand the single sign-on types and the flows that the application supports. Single sign-on types define the protocol that can be used for single sign-on with the application. An application may support one or more of the available types. Single sign-on flows represent the way that single sign-on is processed between the identity provider and the service provider.

When looking at applications in the search list, identify federated single sign-on support by looking for the **Federated SSO** icon. The specific single sign-on types that the application supports are listed on its overview pane in the gallery. When preparing to add an application, access the integration documentation for it to identify the supported single sign-on flows and any particular single sign-on requirements.

## Single sign-on testing

To successfully set up single sign-on, user accounts must exist for the employees in the company at both the identity provider and the service provider.

To test single sign-on between the identity provider and the service provider, test user accounts should be used before the application is introduced to the employees. In the next unit, an account is created at the identity provider and assigned to the application.
