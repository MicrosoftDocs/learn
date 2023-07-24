In this unit, explore how to configure agents for projects in Azure DevOps. Agents are responsible for running the tasks specified in your pipelines, and configuring them correctly is essential for ensuring smooth execution and maintaining a secure environment.

## Agent selection in Azure Pipelines

When configuring agents for your projects, consider the following factors:

- **Resource requirements**: Microsoft-hosted agents may not always have the necessary resources or software to execute specific tasks. In such cases, you might need to use self-hosted agents with custom configurations.

- **Security and compliance**: Some organizations have strict security or compliance requirements that necessitate the use of self-hosted agents. These agents can be deployed within your organization's infrastructure, providing better control over security and data handling.

## Configure agents for projects

To configure agents for your projects:

1. Determine whether you need to use Microsoft-hosted agents or self-hosted agents based on your project requirements.
2. Select the appropriate agent pool and configure permissions.
3. Update your pipeline YAML file to specify the desired agent pool using the pool property.

    ```YAML
    trigger:
    - main
    
    pool:
      vmImage: 'ubuntu-latest'

    ```

4. Configure permissions for your pipeline, ensuring that the principle of least privilege is followed.

## Challenge yourself

To practice configuring agents for projects:

1. Choose a project in your Azure DevOps environment and decide whether to use Microsoft-hosted agents or self-hosted agents based on the project's requirements.
2. Configure the agent pool and permissions as appropriate.
3. Create a new pipeline for the project and update the pipeline YAML file to use the configured agent pool.
4. Configure permissions for the pipeline, adhering to the principle of least privilege.
5. Execute the pipeline and verify that it runs successfully using the chosen agent pool.

For more information about agents configuration, see:

- [Azure Pipelines agents.](https://learn.microsoft.com/azure/devops/pipelines/agents/agents/)
- [Microsoft-hosted agents.](https://learn.microsoft.com/azure/devops/pipelines/agents/hosted/)
- [Create and manage agent pools.](https://learn.microsoft.com/azure/devops/pipelines/agents/pools-queues/)
- [Set pipeline permissions](https://learn.microsoft.com/azure/devops/pipelines/policies/permissions)
- [Plan how to secure your YAML pipelines](https://learn.microsoft.com/azure/devops/pipelines/security/approach)
