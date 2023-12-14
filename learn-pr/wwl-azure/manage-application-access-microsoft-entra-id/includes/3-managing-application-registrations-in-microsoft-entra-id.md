When you register a new application in Microsoft Entra ID, a service principal is automatically created for the app registration. The service principal is the app's identity in the Microsoft Entra tenant. Access to resources is restricted by the roles assigned to the service principal, giving you control over which resources can be accessed and at which level. For security reasons, it's always recommended to use service principals with automated tools rather than allowing them to sign in with a user identity.

> [!IMPORTANT]
> *Instead of creating a service principal, consider using managed identities for Azure resources for your application identity. If your code runs on a service that supports managed identities and accesses resources that support Microsoft Entra authentication, managed identities are a better option for you.*

## Prerequisites

To register an application in your Microsoft Entra tenant, you need:

A Microsoft Entra user account. If you don't already have one, you can create an account for free.

## Permissions required for registering an app

You must have sufficient permissions to register an application with your Microsoft Entra tenant, and assign to the application a role in your Azure subscription. To complete these tasks, you require `Application.ReadWrite.Allpermission`.

## Register an application with Microsoft Entra ID and create a service principal

Sign in to the Microsoft Entra admin center as at least a Cloud Application Administrator.

Browse to **Identity**, **Applications**, **App registrations** then select **New registration**.<br>

Name the application, for example "example-app".<br>

Select a supported account type, which determines who can use the application.<br>

Under **Redirect URI**, select **Web** for the type of application you want to create. Enter the URI where the access token is sent to.<br>

Select **Register**.

:::image type="content" source="../media/create-app-f14fa95c.png" alt-text="Screenshot showing how to register an application.":::


You've created your Microsoft Entra application and service principal.

## Assign a role to the application

To access resources in your subscription, you must assign a role to the application. Decide which role offers the right permissions for the application.

You can set the scope at the level of the subscription, resource group, or resource. Permissions are inherited to lower levels of scope.

1.  Sign in to the Azure portal.
2.  Select the level of scope you wish to assign the application to. For example, to assign a role at the subscription scope, search for and select **Subscriptions**. If you don't see the subscription you're looking for, select **global subscriptionsfilter**. Make sure the subscription you want is selected for the tenant.
3.  Select **Access control (IAM)**.
4.  Select **Add**, then select **Add role assignment**.
5.  In the **Role** tab, select the role you wish to assign to the application in the list. For example, to allow the application to execute actions like reboot, start and stop instances, select the **Contributor** role.
6.  Select the **Next**.
7.  On the **Members** tab. Select **Assign access to**, then select **User**, **group**, **or service principal**
8.  Select **Select members**. By default, Microsoft Entra applications aren't displayed in the available options. To find your application, Search for it by its name.
9.  Select the **Select** button, then select **Review + assign**.
    
    :::image type="content" source="../media/add-role-assignment-73442465.png" alt-text="Screenshot showing how to add a role assignment.":::
    <br>

Your service principal is set up. You can start using it to run your scripts or apps. To **manage your service principal** (permissions, user consented permissions, see which users have consented, review permissions, see sign in information, and more), go to **Enterprise applications**.
