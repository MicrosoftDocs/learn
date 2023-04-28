In this unit, we'll explore how to configure agent identities in Azure DevOps. Agent identities are crucial for controlling access to resources and maintaining security in your pipelines.

## Understanding agent identities

An agent identity determines the permissions an agent has when accessing resources and performing tasks on behalf of your pipeline. By default, agents run with the identity of the build service user account. However, you might need to configure a custom identity for an agent to grant it specific permissions or restrict access to certain resources.

## Configuring agent identities

To configure agent identities, follow these steps:

1. Determine the required identity for your agent based on the tasks it needs to perform and the resources it needs to access.
2. If using a Microsoft-hosted agent, you can configure a custom identity using a service connection or managed identity. Follow the [official documentation](https://docs.microsoft.com/azure/devops/pipelines/agents/v2-windows) for detailed steps on setting up service connections and managed identities.
3. If using a self-hosted agent, configure the agent to run under the desired identity by following the [official documentation](https://docs.microsoft.com/azure/devops/pipelines/agents/v2-windows) for your platform (Windows, macOS, or Linux).
4. Update your pipeline YAML file to use the configured agent identity when executing tasks, if necessary.
5. Regularly review and update agent identities and their associated permissions to ensure that they adhere to the principle of least privilege.

## Challenge yourself

To practice configuring agent identities, complete the following steps:

1. Choose a project in your Azure DevOps environment and determine the required identity for the agent based on the project's requirements.
2. Configure the agent identity as appropriate, using either a service connection, managed identity, or custom identity for self-hosted agents.
3. Update the pipeline YAML file to use the configured agent identity when executing tasks, if necessary.
4. Review the agent identity's permissions and ensure that they follow the principle of least privilege.
5. Execute the pipeline and verify that it runs successfully using the chosen agent identity.

For more information about agents identities, see:

- [Azure Pipelines agents.](https://learn.microsoft.com/azure/devops/pipelines/agents/agents/)
- [Microsoft-hosted agents.](https://learn.microsoft.com/azure/devops/pipelines/agents/hosted/)
- [Create and manage agent pools.](https://learn.microsoft.com/azure/devops/pipelines/agents/pools-queues/)
