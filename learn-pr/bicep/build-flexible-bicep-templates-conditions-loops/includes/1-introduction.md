When you work with Bicep templates, conditions and loops can help make your Azure deployments more flexible. With conditions, you can deploy resources only when specific constraints are in place. And with loops, you can deploy multiple resources that have similar properties.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. Your company is designing a new smart teddy bear toy. Some of the teddy bear's features are based on back-end server components and SQL databases that are hosted in Azure. For security reasons, within your production environments, you need to make sure that you've enabled auditing on your Azure SQL servers.

You expect that the toy will be very popular, and your company plans to launch it in new countries regularly. Every country where you launch the smart teddy bear will need a separate database server and virtual network. To comply with each country's laws, you'll need to physically place these resources in specific locations. You've been asked to deploy each country's database servers and virtual networks and, at the same time, make it easy to add servers and virtual networks as the toy is launched in new countries.

:::image type="content" source="../media/1-architecture-diagram.png" alt-text="Architecture diagram illustrating a resource group containing SQL Server instances in multiple countries." border="false":::

## What will we be doing?

In this module, you'll extend a Bicep template by using conditions and loops. You'll:

- Use *conditions* to deploy Azure resources only when they're required.
- Use *loops* to deploy multiple instances of Azure resources.
- Learn how to control loop parallelism.
- Learn how to create nested loops.
- Combine loops with variables and outputs.

## What is the main goal?

By the end of this module, you'll be able to:
- Create Bicep templates by using conditions and loops.
- Write Bicep code that configures how loops are executed.
- Create variable loops and output loops to make your templates even more flexible.
- Control how your Azure resources are deployed.
