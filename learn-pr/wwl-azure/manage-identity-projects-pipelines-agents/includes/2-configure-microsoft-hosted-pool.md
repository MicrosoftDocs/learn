In this unit, we will explore the process of configuring Microsoft-hosted agents and pools in Azure DevOps. Microsoft-hosted pools provide a convenient and scalable way to run your build and release pipelines without having to manage your own infrastructure. These pools include a set of pre-configured agents with popular software and tools installed, ensuring that you have the necessary resources to execute your pipelines.

## What are Microsoft-hosted agents and pools?

Microsoft-hosted agents are virtual machines provided and managed by Microsoft, which are used to run your build and release pipelines. These agents come with a variety of pre-installed software, ensuring that your pipelines have access to the tools they need.

Microsoft-hosted pools are groups of Microsoft-hosted agents that you can use to run your pipelines. By configuring a Microsoft-hosted pool, you can ensure that your pipelines have access to the necessary resources and can scale as needed without having to manage your own infrastructure.

## Configuring Microsoft-hosted agents and pools

To configure a Microsoft-hosted pool in Azure DevOps, follow these steps:

1. Sign in to your Azure DevOps organization and navigate to the Organization settings page.
2. Select Agent pools from the menu on the left side.
3. You should see a list of available pools, including the default Microsoft-hosted pool called "Azure Pipelines." To use this pool, simply reference it in your pipeline YAML file using the following syntax:

    ```YAML
    pool:
      vmImage: 'ubuntu-latest'
    
    ```

    Replace 'ubuntu-latest' with the appropriate image for your needs. You can find a list of available Microsoft-hosted agent images in the official documentation.

## Challenge yourself

Now that you've learned how to configure a Microsoft-hosted pool, try the following challenge to test your understanding:

1. Create a simple YAML pipeline in Azure DevOps that uses the Microsoft-hosted pool with the 'windows-latest' VM image.
2. Add a script task that echoes "Hello, Azure DevOps!" to the console.
3. Run the pipeline and verify that the output displays the message "Hello, Azure DevOps!"

Once you've completed this challenge, you'll have successfully configured and used a Microsoft-hosted pool in Azure DevOps. In the next unit, we'll explore how to configure agents for projects, further enhancing your understanding of identity management in Azure DevOps.

For more information about Hosted Agents, see:

- [Azure Pipelines agents.](https://learn.microsoft.com/azure/devops/pipelines/agents/agents/)
- [Microsoft-hosted agents.](https://learn.microsoft.com/azure/devops/pipelines/agents/hosted/)
- [Create and manage agent pools.](https://learn.microsoft.com/azure/devops/pipelines/agents/pools-queues/)
