Azure includes several built-in roles that you can use. There are four fundamental built-in roles. The first three apply to all resource types.

 -  **Owner**. Has full access to all resources including the right to delegate access to others. The Service Administrator and Co-Administrators are assigned the Owner role at the subscription scope.
 -  **Contributor**. Can create and manage all types of Azure resources but can’t grant access to others.
 -  **Reader**. Can view existing Azure resources.
 -  **User Access Administrator**. Lets you manage user access to Azure resources.

## Other things to know

 -  There are other built-in roles. For example, the **Virtual Machine Contributor** role allows a user to create and manage virtual machines.
 -  When the built-in roles don't meet the specific needs of your organization, you can create your own custom roles.
 -  Roles can grant access to data within an object. For example, if a user has read data access to a storage account, then they can read the blobs or messages in the storage account.
