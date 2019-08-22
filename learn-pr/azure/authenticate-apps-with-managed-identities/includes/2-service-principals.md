Your company has a number of a number of on-premises applications used by its staff in the day-to-day running of the company.  Recently the company undertook an enterprise-wide security assessment and audit.  The results of the audit highlighted a design flaw in several applications where username and password credentials were stored either in application source code or in the associated configuration files. 

The report indicated the following security issues with storing username and passwords in code or within configuration files:

- passwords were stored in plaintext making them accessible to anyone.  
- compromised user credentials expose the network security of your enterprise domain.
- compromised user credentials allow access to sensitive resources, like your sales and marketing data, etc.
- it creates an unnecessary technical debt in updating and redeploying the application anytime those credentials expire.
- it can also tether the application to on-premises only usage, preventing it from scaling to cloud usage without significant changes.

As a developer for your organization, you have been tasked with fixing the issues in these applications. The report suggested using Azure service principles as a means to improve application security.

In this unit, you'll explore Azure service principals in more detail, the concept behind them, and how to implement them to access Azure resources.

## What are Azure service principals

An Azure service principal is a specific account with limited permissions, scope, and access to only needed resources.  It embraces the "least privileged" principle. Service principals allow for precise and controlled access to resources on your domain.

In the Azure portal, you'll create an application object to represent your on-premises app. This application object is then associated with a service principal. If your app needs access to other Azure resources, additional service principals can be added.

Service principals offer a better way to manage credentials for your applications.

## Working with service principals in Azure

In the context of Azure AD, an application is an object for authentication or authorization that's created, consisting of two parts:

- **An application object**: An Azure AD application that's a global representation of a LOB application for all tenants.
- **A service principal object**: Used to grant access to resources secured by Azure AD for your app – think of it as an instance of the application object granted access in a specific tenant.

To work with service principals in Azure, an Azure AD application object must be created first.

There are several ways to create a service principal:

- through the portal,
- using PowerShell,
- through CLI commands, or
- API calls.  

We will look at just two them here.

- **The portal**: After you create an AD Application through App Registrations in Azure AD, the service principal is automatically created with the application.
- **Programmatically**: Uses code to configure an application for AD authentication, first creating the AD application object then creating the service principal. For example, using PowerShell to create the application and the service principal with the **New-AzureRmADApplication** and **New-AzureRmADServicePrincipal** cmdlets.

## Using Microsoft Identity platform in your applications

Microsoft identity platform simplifies the way your application authenticates with your Azure AD.  It provides a unified way to authenticate your apps.  When an application successfully authenticates against your Azure AD, it is given a unique token.  This token is used each time your application makes a call to an API or to access a service.  When building your application use the Microsoft Authentication Library (MSAL) to provide single-sign-on support.

While there are a number of ways to provision an application for Microsoft identity platform, we will focus on using the portal to register an application in Azure:

- Sign in to the Azure portal, select **Azure Active Directory**.
- Select **App registrations**, and in the top left, select **New registration**.
![Screenshot of adding an application to Azure AD](../media/2-adding-an-app.png)
- Enter a name for the application, this is a display name for the app that doesn't need to follow Azure naming conventions.
- Supported account types must be specified. Choose from:
  - Accounts within your company's active directory,
  - Accounts in any company's AD using Azure, or
  - Any organizational accounts and personal accounts, such as Microsoft or XBox.
- A **redirect URI** is an optional parameter. Two types are available: **Web** or **Public Client**. A redirect URI takes the form of a web link (https) but doesn't need to be a valid link unless you're selecting a public client.
- The application is then registered with Azure AD and has a service principal associated with it.

## Assigning application roles

Azure AD applications must be assigned roles to work with other services.  Azure uses Role-Based Access Control (RBAC) to tightly manage access to Azure resources and what can be done with them. The roles assigned to the application determine which permissions and scope the application will have.

RBAC permissions are inherited from the level of the scope set. For example, if you assign the reader role on a resource group, read permissions are assigned to all resources within that group. Granting tenant administrator grants permissions for the application, gives it access the entire user directory, which would not be a good idea.

![Screenshot of adding a role to an application](../media/2-adding-a-role.png)

You can use the Azure portal to assign the required roles for your app to access the Key Vault by:

- Selecting your key vault in the portal.
- On the left, select **Access Control (IAM)**.
- Select **Add** from the Add a role assignment pane.
- Choose the role you need.
- Accept the default **assign access to** option: Azure AD user, group, or service principal.
- Search for your created application – it won't appear in the drop-down – select it, and then select **Save**.

## Managing keys and permissions

To access Azure resources with service principals, two parameters are required to successfully authenticate the requests:

- **Directory (tenant) ID**: The unique ID for the Azure AD tenant.
- **Application (client) ID**: The unique ID to identify your Azure AD application.

![Screenshot of adding a client secret](../media/2-adding-a-secret.png)

The application needs to have credentials created for requests to be authenticated. The credentials allow the application to identify itself. Choose from two forms:

- **Certificate**: Commonly referred to as a public key, you'll need to have generated it locally, and then upload the .cer, .pem, or .crt file.
- **Client secret**: A complex secret string generated in Azure, also known as an application password.

Whether you opt to use a client secret or a certificate, you need to define when it will expire. This will vary depending on your organization, however it is good practice to pick one or two years.

> [!NOTE]
> Certificates can expire, and for the best security, the client secret should be set to expire. Managing these credentials is a downside of an app accessing Azure resources via a service principal.

Service principals can be used to authenticate application access to Azure resources, but if your application runs on Azure, there's a better way and that's to use managed identities.
