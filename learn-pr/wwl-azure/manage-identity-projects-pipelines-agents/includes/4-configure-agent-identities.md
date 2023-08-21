In this unit, learn how to configure self-hosted agent identities using Managed Identities. These features provide a secure alternative to personal access tokens (PATs) for authentication and authorization in Azure DevOps.

## Understand agent identities

When an Azure DevOps agent runs a job, it uses the agent identity to authenticate itself to other services and perform actions on behalf of the user. In other words, agent identities define what an agent can and can't do, effectively controlling resource access.

You can create a more secure pipeline by carefully managing agent identities and their permissions. For example, you can limit the potential damage from a compromised agent by ensuring that its identity only has the minimum necessary permissions.

## Importance of agent identities

In Azure DevOps, Agent Identity is fundamental to ensuring the secure and efficient execution of tasks. Agents are the building blocks that carry out the work specified in your pipelines. They run the tasks defined in a stage of your pipeline, and they do so with a specific identity.

This identity is crucial for several reasons:

- **Security**: The agent's identity determines what resources the agent can access during operations. It controls permissions and access rights to different parts of your Azure DevOps environment and other linked systems.
- **Auditing**: Agent Identity is a key component in tracking and auditing the actions performed in your DevOps environment. You can trace back operations to specific agents, making it easier to understand the flow of tasks and identify any issues.
- **Resource Management**: The agent's identity can be used to determine which tasks it should perform. You can allocate certain tasks to specific agents, improving efficiency and resource use.

You can configure agent identities in Azure DevOps using a personal access token (PAT).

For more information about agents identities, see:

- [Azure Pipelines agents.](https://learn.microsoft.com/azure/devops/pipelines/agents/agents/)
- [Microsoft-hosted agents.](https://learn.microsoft.com/azure/devops/pipelines/agents/hosted/)
- [Create and manage agent pools.](https://learn.microsoft.com/azure/devops/pipelines/agents/pools-queues/)
- [Use Azure Active Directory service principals & managed identities](https://learn.microsoft.com/azure/devops/integrate/get-started/authentication/service-principal-managed-identity)
