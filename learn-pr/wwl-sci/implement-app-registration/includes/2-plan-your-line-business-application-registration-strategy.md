This unit looks at why applications integrate with Microsoft Entra ID. Add applications to Microsoft Entra ID to apply one or more of the services it provides, including:

- Application authentication and authorization.
- User authentication and authorization.
- Single-sign-on (SSO) using federation or password.
- User provisioning and synchronization.
- Role-based access control: Use the directory to define application roles to perform role-based authorization checks in an application.
- OAuth authorization services: Used by Microsoft 365 and other Microsoft applications to authorize access to APIs/resources.
- Application publishing and proxy: Publish an application from a private network to the internet.
- Directory schema extension attributes: Extend the schema of service principal and user objects to store extra data in Microsoft Entra ID.

There are two representations of applications in Microsoft Entra ID: [application objects](/entra/identity-platform/app-objects-and-service-principals) and service principals. The next two sections explain each, and how they interact with one another in the Azure portal.

## What are application objects and where do they come from?

You can manage application objects in the Azure portal through the App Registrations experience. Application objects define and describe the application to Microsoft Entra ID, enabling your identity provider to know how to issue tokens to the application based on its settings. The application object will only exist in its home directory, even if it's a multitenant application supporting service principals in other directories. The application object includes any of the following (as well as additional information not mentioned here):

- Name, logo, and publisher
- Redirect URIs
- Secrets (symmetric and/or asymmetric keys used to authenticate the application)
- API dependencies (OAuth)
- Published APIs/resources/scopes (OAuth)
- App roles (RBAC)
- SSO metadata and configuration
- User provisioning metadata and configuration
- Proxy metadata and configuration

You can create application objects through multiple pathways, including:

- Application registrations in the Azure portal.
- Creating a new application using Visual Studio and configuring it to use Microsoft Entra authentication.
- When an admin adds an application from the app gallery (which will also create a service principal).
- Using the Microsoft Graph API or PowerShell to create a new application.
- Many other pathways, including various developer experiences in Azure and in API explorer experiences across developer centers.

## What are service principals and where do they come from?

You can manage service principals in the Azure portal through the Enterprise Applications experience. Service principals govern an application connecting to Microsoft Entra ID and can be considered the instance of the application in your directory. Any given application can have at most one application object (which is registered in a "home" directory) and one or more service principal objects representing instances of the application in every directory in which it acts.

The service principal can include:

- A reference back to an application object through the application ID property.
- Records of local user and group application-role assignments.
- Records of local user and admin permissions granted to the application.
    
   - For example: permission for the application to access a particular user's email.

- Records of local policies including Conditional Access policy.
- Records of alternate local settings for an application.
    
   - Claims transformation rules.
   - Attribute mappings (User provisioning).
   - Directory-specific app roles (if the application supports custom roles).
   - Directory-specific name or logo.

Like application objects, service principals can be created through multiple pathways, including:

- When users sign in to a third-party application integrated with Microsoft Entra ID.
    
   - During sign-in, users are asked to give permission to the application to access their profile and other permissions. The first person to give consent causes a service principal that represents the application to be added to the directory.

- When users sign in to Microsoft online services like Microsoft 365.
    
   - When you subscribe to Microsoft 365 or begin a trial, one or more service principals are created in the directory representing the various services that are used to deliver all of the functionality associated with Microsoft 365.
   - Some Microsoft 365 services, like SharePoint, create service principals on an ongoing basis to allow secure communication between components, including workflows.

- When an admin adds an application from the app gallery (this will also create an underlying app object).
- Add an application to use the Microsoft Entra Application Proxy.
- Connect an application for SSO using SAML or password SSO.
- Programmatically via the Microsoft Graph API or PowerShell.

## How are application objects and service principals related to each other?

An application has one application object in its home directory that's referenced by one or more service principals in each of the directories where it operates (including the application's home directory).

:::image type="content" source="../media/how-apps-added-azure-active-directory.png" alt-text="Diagram of the relationship between app objects and service principals.":::

In the preceding diagram, Microsoft maintains two directories internally (shown on the left) that it uses to publish applications:

- One for Microsoft Apps (Microsoft services directory).
- One for preintegrated third-party applications (App gallery directory).

Application publishers/vendors who integrate with Microsoft Entra ID are required to have a publishing directory (shown on the right as "Some SaaS directory").

Applications that you add (represented as "App (yours)" in the diagram) include:

- Apps you developed (integrated with Microsoft Entra ID).
- Apps you connected for SSO.
- Apps you published using the Microsoft Entra Application Proxy.

### Notes and exceptions to service principals

Not all service principals point back to an application object. When Microsoft Entra ID was originally built, the services provided to applications were more limited, and the service principal was sufficient for establishing an application identity. The original service principal was closer in shape to the Windows Server Active Directory service account. For this reason, it's still possible to create service principals through different pathways, such as using PowerShell, without first creating an application object. The Microsoft Graph API requires an application object before creating a service principal.

Not all of the information described above is currently exposed programmatically. The following are only available in the UI:

- Claims transformation rules
- Attribute mappings (User provisioning)

For more detailed information on the service principal and application objects, see the Microsoft Graph API reference documentation:

- Application
- Service Principal

## Adding a new app registration

:::image type="content" source="../media/register-new-app.png" alt-text="Diagram of the relationship between app objects and service principals, focusing on process flow.":::


**Process flow of the diagram**

1. User requests to register an application – a request token is issued.
2. Authorization endpoint sends back an Authentication.
3. User consents to have the application registration.
4. Service is created from the application
5. Token returned to the user.

## Who has permission to add applications to my Microsoft Entra instance?

You can assign roles like Application Administrator, and Cloud Application Administrator to perform these tasks. You **must remember** that by default all users in your directory have rights to register application objects they're developing, and they have discretion over which applications they share / give access to their organizational data through consent. When the first user in your directory connects to an application, and grants consent that will create a service principal. Otherwise, the consent grant information will be stored on the existing service principal.

Allowing users to register and consent to applications might initially sound concerning, but keep the following in mind:

- Applications have been able to leverage Windows Server Active Directory for user authentication for many years without requiring the application to be registered or recorded in the directory. Now the organization will have improved visibility to exactly how many applications are using the directory and for what purpose.
- Delegating these responsibilities to users negates the need for an admin-driven application registration and publishing process. With Active Directory Federation Services (AD FS), an admin likely had to add an application as a relying party on behalf of their developers. Now developers can deploy themselves (self-service).
- Users signing in to applications using their organization accounts for business purposes is a good thing. If they subsequently leave the organization, they'll automatically lose access to their account in the application they were using.
- Having a record of what data was shared with which application is a good thing. Data is more transportable than ever and it's useful to have a clear record of who shared what data with which applications.
- API owners who use Microsoft Entra ID for OAuth decide exactly what permissions users are able to grant to applications and which permissions require an admin to agree to. Only admins can consent to larger scopes and more significant permissions, while user consent is scoped to the users' own data and capabilities.
- When a user adds or allows an application to access their data, the event can be audited. You can view the Audit Reports within the Azure portal to determine how an application was added to the directory.

If you still want to prevent users in your directory from registering applications and from signing in to applications without administrator approval, two settings enable you to turn off those capabilities:

To prevent users from consenting to applications on their own behalf:

- In the Azure portal, go to the User settings section under Enterprise applications.
- Change **Users can consent to apps accessing company data on their behalf** to **No**.
    
   > [!NOTE]
   > If you decide to turn off user consent, an admin will be required to consent to any new application a user needs to use.

To prevent users from registering their own applications:

- In the Azure portal, go to the User settings section under Microsoft Entra ID.
- Change **Users can register applications** to **No**.

## Tenancy in Microsoft Entra ID

Microsoft Entra organizes objects like users and apps into groups called *tenants*. Tenants enable an administrator to set policies on the users within the organization and the apps that the organization owns to meet their security and operational policies.

### Who can access your app?

When it comes to developing apps, developers can choose to configure their app to be either single-tenant or multitenant during app registration in the Azure portal.

- Single-tenant apps are only available in the tenant they were registered in, also known as their home tenant.
- Multitenant apps are available to users in both their home tenant and other tenants.

In the Azure portal, you can configure your app to be single-tenant or multitenant by setting the audience as follows:

**Specific app access**

| **Audience**                                                                                                 | **Single/multitenant** | **Who can sign in**                                                                                                                                                                                                                                                                                               |
| ------------------------------------------------------------------------------------------------------------ | ---------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Accounts in this directory only                                                                              | Single tenant          | All user and guest accounts in your directory can use your application or API. *Use this option if your target audience is internal to your organization*.                                                                                                                                                        |
| Accounts in any Microsoft Entra directory                                                                    | Multitenant            | All users and guests with a work or school account from Microsoft can use your application or API. This includes schools and businesses that use Microsoft 365. *Use this option if your target audience is business or educational customers.*                                                                   |
| Accounts in any Microsoft Entra directory and personal Microsoft accounts (such as Skype, Xbox, Outlook.com) | Multitenant            | All users with a work, school, or personal Microsoft account can use your application or API. It includes schools and businesses that use Microsoft 365, as well as personal accounts that are used to sign in to services like Xbox and Skype. *Use this option to target the widest set of Microsoft accounts.* |

### Best practices for multitenant apps

Building great multitenant apps can be challenging because of the number of different policies that IT administrators can set in their tenants. If you choose to build a multitenant app, follow these best practices:

- Test your app in a tenant that has configured Conditional Access policies.
- Follow the principle of least user access to ensure that your app only requests permissions it actually needs.
- Provide appropriate names and descriptions for any permissions you expose as part of your app. This helps users and admins know what they're agreeing to when they attempt to use your app's APIs. For more information, see the best practices section in the permissions guide.
