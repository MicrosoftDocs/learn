In this unit, learn how to configure Microsoft-hosted agents and agent pools in Azure DevOps, focusing on security best practices. Microsoft-hosted agents are virtual machines maintained by Microsoft, and agent pools enable you to organize and manage these agents efficiently.

## Types of Azure DevOps Agents

Azure DevOps provides two types of agents:

- **Microsoft-hosted agents**: These are agents managed by Microsoft. They are pre-configured and ready to use, with various software already installed. Microsoft-hosted agents are updated regularly and provide a highly scalable option for running your pipelines.
- **Self-hosted agents**: These are agents that you manage on your infrastructure. They provide more control over the environment and can be customized to your requirements. Self-hosted agents are ideal for scenarios where you need specific tools or configurations not available on Microsoft-hosted agents.

## Agent pools

Agent pools are groups of agents that can be shared across multiple projects and pipelines. By organizing your agents into pools, you can manage their access and permissions more efficiently, ensuring that your projects and pipelines remain secure.

## Apply the principle of least privilege in Azure DevOps

To maintain a secure environment in Azure DevOps, it's essential to follow security best practices when configuring Microsoft-hosted agents and agent pools. Some key security considerations include:

- **Role-based access control (RBAC):** Azure DevOps uses RBAC to manage access to agent pools. Roles such as "Administrator," "User," and "Reader" can be assigned to users or groups to grant different levels of access to agent pools. Ensure that you only grant the necessary permissions to team members to maintain a secure environment.
- **Limiting scope:** When creating service connections for your pipelines, it's important to limit the scope of access. This helps prevent unauthorized access and reduces the potential impact of a security breach. Always grant the minimum set of permissions required for a specific task.
- **Securing secrets:** Ensure that secrets like API keys, passwords, and tokens are securely stored using Azure Key Vault or another secure storage solution. Avoid storing secrets in plain text or in code repositories.
- **Regularly review permissions:** Periodically review and update permissions for users and groups to ensure that they have the appropriate level of access based on their current roles and responsibilities.

## Configure permissions for Microsoft-hosted agent pools

To configure permissions for Microsoft-hosted agent pools:

1. In Azure DevOps, navigate to the Organization settings.
2. Under Pipelines, select Agent pools.
3. Select the agent pool for which you want to configure permissions.
4. Select the Security tab.
5. Here, you can add users or groups and assign them specific roles like "Administrator," "User," or "Reader." Make sure to grant the least privilege necessary for each team member to perform their tasks.
6. You can also configure permissions for specific pipelines by clicking on the Pipelines tab and selecting the pipeline for which you want to configure permissions.

## Using Azure Pipelines agent pool in your pipelines

To use a specific agent pool in your Azure Pipelines, you need to specify the name of the image, using the YAML VM Image Label from [this](https://learn.microsoft.com/azure/devops/pipelines/agents/hosted) table. For example, consider the following YAML file:

```YAML
trigger:
- main

pool:
  vmImage: ubuntu-latest # This is the default if you don't specify a pool or vmImage.

steps:
- script: echo "Hello, World!"
  displayName: 'Run a simple script'

```

Replace 'ubuntu-latest' with the name of the agent pool you want. This YAML file is a simple pipeline configuration that uses the specified agent pool to run a single script step, which prints "Hello, World!".

With this YAML configuration, when the pipeline is triggered, it runs on an agent from the specified agent pool. Make sure that the agent pool you use has the necessary tools and capabilities to execute the tasks defined in your pipeline.

## Challenge yourself

To practice configuring permissions for Microsoft-hosted agent pools and pipelines, complete the following steps:

1. Create a new pipeline and configure its permissions as described above.
2. Verify that the permissions granted to users and groups adhere to the principle of least privilege.
3. Modify the pipeline to use the agent pool by updating the pool property in the pipeline YAML file.
4. Execute the pipeline and verify that it runs successfully.

For more information about Microsoft-hosted agents and pools, see:

- [Azure Pipelines agents.](https://learn.microsoft.com/azure/devops/pipelines/agents/agents/)
- [Microsoft-hosted agents.](https://learn.microsoft.com/azure/devops/pipelines/agents/hosted/)
- [Create and manage agent pools.](https://learn.microsoft.com/azure/devops/pipelines/agents/pools-queues/)
