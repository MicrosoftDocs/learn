In this unit, explore how to configure the scope of a service connection in Azure DevOps, focusing on security and best practices. Service connections enable your agents to interact with external services, such as source control repositories, cloud services, or package registries.

## Understanding service connection scope

The scope of a service connection determines the level of access and permissions the connection has within the external service. By properly configuring the scope, you can ensure that your pipelines have the necessary access to complete their tasks, while minimizing the risk of unauthorized access and potential security breaches.

## Best practices for configuring service connection scope

Follow these best practices when configuring the scope of a service connection:

- **Least privilege:** Grant the minimum set of permissions required for the specific tasks the service connection will be used for. Avoid giving broader access than necessary.
- **Limit the number of service connections:** Reduce the number of service connections to minimize the potential attack surface. Reuse service connections when appropriate, but ensure that the access levels are suitable for all the pipelines using the connection.
- **Regularly review and update permissions:** Periodically review and update the permissions and scope of your service connections to ensure they remain appropriate and secure.
- **Monitor usage:** Keep track of service connection usage across your pipelines to identify any unusual activity or unauthorized access.
- **Use managed identities when possible:** Managed identities provide a secure way to authenticate with Azure services without having to store credentials in your pipeline. Use managed identities for Azure resources whenever possible.

## Configure the scope of a service connection

1. Sign in to your Azure DevOps portal, navigate to your project, and then go to 'Project settings' and 'Service connections.'
2. Click on 'New service connection' and choose the type of connection you want to create, for example, 'Azure Resource Manager.'
3. In the 'Authentication method' section, select 'Service principal (automatic).' This option will automatically create and manage a service principal in your Azure AD, which will be used for authentication.
4. Configure the scope of the service connection by selecting the appropriate subscription, resource group, or resource. The scope determines which resources the service connection has access to. Limit the scope as much as possible to reduce potential security risks.
   - Subscription: Grants access to all resources within the specified Azure subscription.
   - Resource Group: Grants access only to resources within a specific resource group in the Azure subscription.
   - Resource: Grants access to a single resource, such as a storage account or a web app, within the Azure subscription.
5. Provide a name and description for the service connection, and then click 'Save.'
6. Once the service connection is created, open your new service connection, click on the ellipsis (three dots) next to the Edit button and select 'Security.'
7. Review the 'Roles' section to ensure that the service principal has been granted the least privilege necessary for its purpose. If needed, modify the roles or add custom roles to further limit the access, and actions it can perform.
8. Save your changes.

## Challenge yourself

To practice configuring the scope of a service connection, create a pipeline that uses a service connection with a limited scope to deploy an Azure resource, such as a web app or a storage account. Run the pipeline and verify that it runs successfully, deploying the resource with the appropriate level of access.

Then, review the service connection and ensure that the scope is limited to the specific resource or resource group.

Finally, review the roles assigned to the service principal and ensure that it has the least privilege necessary for its purpose.

For more information about service connections, see:

- [Manage service connections.](https://learn.microsoft.com/azure/devops/pipelines/library/service-endpoints)
- [Use Azure Active Directory service principals & managed identities](https://learn.microsoft.com/azure/devops/integrate/get-started/authentication/service-principal-managed-identity)
