A workload identity is an identity you assign to a software workload (such as an application, service, script, or container) to provide access to protected environments. For example, in order for Azure Pipelines or GitHub Actions to be able to deploy resources into Azure subscriptions, their individual actions need to establish a security context that would grant them required privileges in these subscriptions. Workload identities provide that security context through their support for authentication and authorization.

Microsoft Entra ID offers supports for three types of workload identities:

 -  **Application** is a Microsoft Entra ID object that is the global representation of a software application as defined by its developer. This object, created as part of application registration by the developer, determines the mechanism used by the application to issue tokens, the resources the application needs to access, and the actions that the application can take.
 -  **Service principal** is a Microsoft Entra ID object that is a local representation of a software application. This object gets created when the corresponding application is registered in the Entra tenant where the application will be used. The application object is used as a template to create the corresponding service principal object. The service principal object defines what the app is permitted to do in the local tenant, what resources the app can access, and who can access the app.
 -  **Managed identity** is a special type of service principal that is associated with an Azure resource in order to allow that resource to authenticate and get authorized on its own. Managed identity offers additional benefit by eliminating the need to maintain credentials. Instead, the credentials used by managed identity are maintained automatically by the platform.

## Implement service principals

The traditional approach to granting Azure Pipelines and GitHub Actions access to Azure subscriptions relies on service principals.

### Microsoft Entra applications

Applications are registered with a Microsoft Entra tenant within Microsoft Entra ID. Registering an application creates an identity configuration. You also determine who can use it:

 -  Accounts in the same organizational directory
 -  Accounts in any organizational directory
 -  Accounts in any organizational directory and personal Microsoft accounts
 -  Personal accounts only

    :::image type="content" source="../media/workload-identities-register-application-635f9d16.png" alt-text="Screenshot of register an application feature.":::


## Client secret

Once the application is created, you then should create at least one client secret for the application.

:::image type="content" source="../media/workload-identities-client-secret-3f9f10d0.png" alt-text="Screenshot of the client secret feature.":::


## Grant permissions

The application identity can then be granted permissions within services and resources that trust Microsoft Entra ID, such as those hosted in Azure subscriptions.

## Service principal

To access resources, an entity must be represented by a security principal. To connect, the entity must know:

 -  TenantID.
 -  ApplicationID (also referred to as clientID).
 -  Client Secret.

For more information on Service Principals, see [App Objects and Service Principals](/entra/identity-platform/app-objects-and-service-principals).
