Bicep modules let you split a complex template into smaller parts. You can ensure that each module is focused on a specific task, and that the modules are reusable for multiple deployments and workloads.

In this module, you'll learn about the benefits of Bicep modules and how you can create, use, and combine them for your own deployments.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. You've previously created a Bicep template that deploys websites to support the launch of each new toy product.

Your company recently launched a new toy: a remote control wombat. The wombat toy has become popular, and the traffic to its website has increased significantly. Customers are complaining about slow response times because the server can't keep up with the demand.

To improve performance and reduce cost, you've been asked to add a content delivery network, or CDN, to the website. You know that your company will need to include a CDN in other websites that it makes in the future, but also that not every website needs a CDN. So you decide to make the CDN component optional.

:::image type="content" source="../media/1-architecture-diagram.png" alt-text="Architecture diagram that shows two variants: one with traffic flowing from the internet to the app through a CDN, and another without a CDN." border="false" :::

## What will we be doing?

In this module, you'll create a set of Bicep modules to deploy your website and CDN. Then, you'll create a template that uses those modules together.

## What is the main goal?

By the end of this module, you'll be able to design and build Bicep modules that are composable, reusable, and flexible. You'll also be able to create Bicep templates that compose complex deployments from a set of modules.
