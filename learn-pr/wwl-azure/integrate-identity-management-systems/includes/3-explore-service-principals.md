Azure AD offers different kinds of mechanisms for authentication. In DevOps Projects, though, one of the most important is the use of Service Principals.

## Azure AD applications

Applications are registered with an Azure AD tenant within Azure Active Directory. Registering an application creates an identity configuration. You also determine who can use it:

 -  Accounts in the same organizational directory.
 -  Accounts in any organizational directory.
 -  Accounts in any organizational directory and Microsoft Accounts (personal).
 -  Microsoft Accounts (Personal accounts only).

    :::image type="content" source="../media/register-application-e63165fd.png" alt-text="Register Application.":::


    :::image type="content" source="../media/created-application-e9b31923.png" alt-text="Created Application.":::


## Client secret

Once the application is created, you then should create at least one client secret for the application.

:::image type="content" source="../media/client-secret-1625d2c0.png" alt-text="Client Secret.":::


## Grant permissions

The application identity can then be granted permissions within services and resources that trust Azure Active Directory.

## Service principal

To access resources, an entity must be represented by a security principal. To connect, the entity must know:

 -  TenantID.
 -  ApplicationID.
 -  Client Secret.

For more information on Service Principals, see [App Objects and Service Principals](/azure/active-directory/develop/app-objects-and-service-principals).
