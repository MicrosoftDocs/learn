In this unit, we'll explore how to configure the scope of a service connection in Azure DevOps, focusing on security and best practices. Service connections enable your agents to interact with external services, such as source control repositories, cloud services, or package registries.

## Understanding service connection scope

The scope of a service connection determines the level of access and permissions the connection has within the external service. By properly configuring the scope, you can ensure that your pipelines have the necessary access to complete their tasks, while minimizing the risk of unauthorized access and potential security breaches.

## Best practices for configuring service connection scope

Follow these best practices when configuring the scope of a service connection:

- **Least privilege:** Grant the minimum set of permissions required for the specific tasks the service connection will be used for. Avoid giving broader access than necessary.
- **Limit the number of service connections:** Reduce the number of service connections to minimize the potential attack surface. Reuse service connections when appropriate, but ensure that the access levels are suitable for all the pipelines using the connection.
- **Regularly review and update permissions:** Periodically review and update the permissions and scope of your service connections to ensure they remain appropriate and secure.
- **Monitor usage:** Keep track of service connection usage across your pipelines to identify any unusual activity or unauthorized access.
- **Use managed identities when possible:** Managed identities provide a secure way to authenticate with Azure services without having to store credentials in your pipeline. Use managed identities for Azure resources whenever possible.

## Configuring service connection scope

To configure the scope of a service connection, follow these steps:

1. In Azure DevOps, navigate to your project and select Project settings.
2. Under Pipelines, click Service connections.
3. Create a new service connection or edit an existing one.
4. Configure the scope and permissions for the service connection according to the best practices mentioned above. The configuration steps will vary depending on the type of service connection you're working with.

## Challenge yourself

To practice configuring the scope of a service connection, complete the following steps:

Choose a project in your Azure DevOps environment and identify an external service that the project requires access to.
Create a new service connection for the external service, or modify an existing one.
Configure the scope and permissions of the service connection following the best practices outlined above.
Update your pipeline to use the newly configured service connection.
Execute the pipeline and verify that it runs successfully, accessing the external service with the appropriate level of access.

For more information about service connections, see:

- [Use Azure Active Directory service principals & managed identities](https://learn.microsoft.com/azure/devops/integrate/get-started/authentication/service-principal-managed-identity)
- [Azure Pipelines agents.](https://learn.microsoft.com/azure/devops/pipelines/agents/agents/)
- [Microsoft-hosted agents.](https://learn.microsoft.com/azure/devops/pipelines/agents/hosted/)
- [Create and manage agent pools.](https://learn.microsoft.com/azure/devops/pipelines/agents/pools-queues/)
