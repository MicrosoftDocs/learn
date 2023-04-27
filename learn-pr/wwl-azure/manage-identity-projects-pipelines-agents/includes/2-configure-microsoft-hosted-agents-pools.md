In this unit, we will explore how to configure a Microsoft-hosted pool in Azure DevOps. Microsoft-hosted agents and pools are a convenient way to run your build and release pipelines without having to manage your own infrastructure. They provide pre-configured, scalable, and maintained build agents for a variety of platforms and workloads.

## What is an Agent Pool?

An agent pool is a collection of build agents managed by Microsoft in the Azure cloud. These build agents come with pre-installed software and tools, enabling you to run your build and release pipelines without needing to set up and maintain your own infrastructure. The pool provides build agents for Windows, Linux, and macOS, allowing you to target various platforms and workloads.

## Configuring an Agent Pool

To configure an agent pool in Azure DevOps, follow these steps:

1. Sign in to your Azure DevOps organization.
2. Navigate to the project you want to configure the pool for.
3. In the left-hand menu, click on "Project settings."
4. Under "Pipelines," select "Agent pools."
5. Click on the "New pool" button.
6. Choose the "Microsoft-hosted" option.
7. Provide a name for the new pool, and optionally, a description.
8. Click "Create" to finish configuring the pool.

Now, your new Microsoft-hosted pool is available for use in your build and release pipelines. When creating a new pipeline or modifying an existing one, you can select this pool as the default agent pool to run your pipeline on.

## Advantages of Using a Microsoft-hosted Pool

Simplified management: Microsoft takes care of managing and maintaining the build agents, freeing you from the overhead of infrastructure management.
Scalability: Microsoft-hosted pools can automatically scale to meet the demands of your build and release pipelines, ensuring optimal performance.
Pre-installed software: Microsoft-hosted agents come with a variety of pre-installed software, tools, and SDKs, allowing you to run a wide range of workloads without additional setup.
Cross-platform support: With build agents available for Windows, Linux, and macOS, you can target multiple platforms with ease.

## Challenge yourself

To reinforce your understanding of configuring a Microsoft-hosted pool, complete the following challenge:

Create a new Azure DevOps project or use an existing one.
Configure a new Microsoft-hosted pool in your project, following the steps outlined above.
Create a simple build pipeline that uses your newly configured Microsoft-hosted pool to build a sample application.
Run the pipeline and observe the results.
By completing this challenge, you'll gain practical experience in configuring and using a Microsoft-hosted pool in Azure DevOps. In the next unit, we'll delve into configuring agents for projects, further expanding your identity management skillset in Azure DevOps.

For more information about Hosted Agents, see:

- [Azure Pipelines agents.](https://learn.microsoft.com/azure/devops/pipelines/agents/agents/)
- [Microsoft-hosted agents.](https://learn.microsoft.com/azure/devops/pipelines/agents/hosted/)
- [Create and manage agent pools.](https://learn.microsoft.com/azure/devops/pipelines/agents/pools-queues/)
