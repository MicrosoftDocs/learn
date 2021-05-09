Using conditions and loops with Bicep templates enables you to make your templates more flexible and reusable. Conditions enable you to deploy resources only when specific condition, such as value of parameter is validated. Loops will enable you to deploy multiple instances of resource with similar properties.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. Your company is designing a new smart teddy bear toy. Some of the teddy bear's features are based on backend server components and SQL databases hosted in Azure. For security reasons, within your production environments, you need to make sure that you auditing have enabled on your Azure SQL servers.

You expect the toy will be very popular, and your company plans to launch into new countries regularly. Every country you launch the smart teddy bear into will need to have a separate database. These databases need to be physically located in specific places to follow the laws of each country. You've been asked to deploy each country's databases while making it easy to add new databases as the toy is launched into new countries.

:::image type="content" source="../media/1-architecture-diagram.png" alt-text="Architecture diagram illustrating a resource group containing multiple instances of SQL Server in different countries." border="false":::

## What will we be doing?

In this module, you'll extend Bicep template with conditions and loops. You'll:

- Use **conditions** based on parameter value to deploy Azure resource only when required.
- Use **loops** to deploy multiple instances of Azure resources.
- Learn how you can control loop parallelism
- Use loops with variables and outputs

## What is the main goal?

By the end of this module you'll be able to create advanced Bicep templates that contain simple business logic by using conditions and loops. You'll be able to use various types of loops parallelism and use loops with parameters, variables, and outputs.
