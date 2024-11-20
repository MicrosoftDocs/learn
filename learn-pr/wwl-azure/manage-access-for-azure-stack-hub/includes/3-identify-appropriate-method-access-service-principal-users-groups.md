Azure Stack Hub requires Microsoft Entra ID or Active Directory Federation Services (AD FS), backed by Active Directory as an identity provider. The choice of a provider is a one-time decision that you make when you first deploy Azure Stack Hub. The concepts and authorization details in this unit can help you choose between identity providers.

Your choice of either Microsoft Entra ID or AD FS is determined by the mode in which you deploy Azure Stack Hub:

 -  When you deploy it in a connected mode, you can use either Microsoft Entra ID or AD FS.
 -  When you deploy it in a disconnected mode, without a connection to the internet, only AD FS is supported.

## Common concepts for identity providers

The remainder of this unit looks at identity providers and their use in Azure Stack Hub.

:::image type="content" source="../media/identity-providers-c9da76c9.png" alt-text="Image showing normalized relational tables.":::


### Directory tenants and organizations

A directory is a container that holds information about users, applications, groups, and service principals.

A directory tenant is an organization, such as Microsoft or your own company.

 -  Microsoft Entra ID supports multiple tenants, and it can support multiple organizations, each in its own directory. If you use Microsoft Entra ID and have multiple tenants, you can grant apps and users from one tenant access to other tenants of that same directory.
 -  AD FS supports only a single tenant and, therefore, only a single organization.

### Users and groups

User accounts (identities) are standard accounts that authenticate individuals by using a user ID and password. Groups can include users or other groups.

How you create and manage users and groups depends on the identity solution you use.

In Azure Stack Hub, user accounts:

 -  Are created in the `username@domain` format. Although AD FS maps user accounts to an Active Directory instance, AD FS doesn't support the use of the *&lt;domain&gt;&lt;alias&gt;* format.
 -  Can be set up to use multifactor authentication.
 -  Are restricted to the directory where they first register, which is their organization's directory.
 -  Can be imported from your on-premises directories.

When you sign in to your organization's user portal, you use the `https://portal.local.azurestack.external` URL. When signing into the Azure Stack Hub portal from domains other than the one used to register Azure Stack Hub, the domain name used to register Azure Stack Hub must be appended to the portal url.

For example, if Azure Stack Hub has been registered with `fabrikam.onmicrosoft.com` and the user account logging in is `admin@contoso.com`, the URL to use to log into the user portal would be: `https://portal.local.azurestack.external/fabrikam.onmicrosoft.com`.

### Guest users

Guest users are user accounts from other directory tenants that have been granted access to resources in your directory. To support guest users, you use Microsoft Entra ID and enable support for multi-tenancy. When support is enabled, you can invite guest users to access resources in your directory tenant, which in turn enables their collaboration with outside organizations.

To invite guest users, cloud operators and users can use Microsoft Entra B2B collaboration. Invited users get access to documents, resources, and apps from your directory, and you maintain control over your own resources and data.

As a guest user, you can sign in to another organization's directory tenant. To do so, you append that organization's directory name to the portal URL. For example, if you belong to the Contoso organization and want to sign in to the Fabrikam directory, you use `https://portal.local.azurestack.external/fabrikam.onmicrosoft.com`.

### Apps

You can register apps to Microsoft Entra ID or AD FS, and then offer the apps to users in your organization.

Apps include:

 -  **Web apps**: Examples include the Azure portal and Azure Resource Manager. They support Web API calls.
 -  **Native client**: Examples include Azure PowerShell, Visual Studio, and Azure CLI.

Apps can support two types of tenancy:

 -  **Single-tenant**: Supports users and services only from the same directory where the app is registered.

Because AD FS supports only a single directory, apps you create in an AD FS topology are, by design, single-tenant apps.

 -  **Multi-tenant**: Supports use by users and services from both the directory where the app is registered and additional tenant directories. With multi-tenant apps, users of another tenant directory (another Microsoft Entra tenant) can sign in to your app.

When you register an app, you create two objects:

 -  **Application object**: The global representation of the app across all tenants. This relationship is one-to-one with the software app and exists only in the directory where the app is first registered.
 -  **Service principal object**: A credential that's created for an app in the directory where the app is first registered. A service principal is also created in the directory of each additional tenant where that app is used. This relationship can be one-to-many with the software app.

## Service principals

A service principal is a set of *credentials* for an app or service that grant access to resources in Azure Stack Hub. The use of a service principal separates the app permissions from the permissions of the user of the app.

A service principal is created in each tenant where the app is used. The service principal establishes an identity for sign-in and access to resources (such as users) that are secured by that tenant.

 -  **A single-tenant app** has only one service principal, which is in the directory where it's first created. This service principal is created and consents to being used during registration of the app.
 -  **A multi-tenant web app** or API has a service principal that's created in each tenant where a user from that tenant consents to the use of the app.

Credentials for service principals can be either a key that's generated through the Azure portal or a certificate. The use of a certificate is suited for automation because certificates are considered more secure than keys.

When you use AD FS with Azure Stack Hub, only the administrator can create service principals. With AD FS, service principals require certificates and are created through the privileged endpoint (PEP).

### Services

Services in Azure Stack Hub that interact with the identity provider are registered as apps with the identity provider. Like apps, registration enables a service to authenticate with the identity system.

All Azure services use OpenID Connect protocols and JSON Web Tokens to establish their identity. Because Microsoft Entra ID and AD FS use protocols consistently, you can use Azure Active Directory Authentication Library (ADAL) to authenticate on-premises or to Azure (in a connected scenario). With ADAL, you can also use tools such as Azure PowerShell and Azure CLI for cross-cloud and on-premises resource management.

### Identities and identity system

Identities for Azure Stack Hub include user accounts, groups, and service principals.

When you install Azure Stack Hub, several built-in apps and services automatically register with your identity provider in the directory tenant. Some services that register are used for administration. Other services are available for users. The default registrations give core services identities that can interact both with each other and with identities that you add later.

If you set up Microsoft Entra ID with multi-tenancy, some apps propagate to the new directories.
