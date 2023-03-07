Bicep modules enable you to create composable, reusable files that define a set of related resources. You then use those modules in your deployment templates.

When you work with Bicep code in your own organization, you often create reusable modules that benefit your colleagues. These modules can create resources in a way that fits your organization's requirements. For example, the modules can use your defined naming conventions and configure your resources so that they meet your security requirements. Private Bicep registries provide an easy way for you to share these modules within your organization.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. You've previously worked with one of your toy product development teams to create a set of Bicep modules. You created a module to deploy a website, and another module to deploy a content delivery network (CDN).

Now, members of another team have asked you if they can reuse the same modules for their own deployments. They're building a new toy dog, and they need to deploy a website and CDN to help promote the product on social media.

You considered sending the modules to each team by email, but you're worried about how to control access and manage different versions. You want to find a way to share the modules throughout your organization, to make it easier for any team to reuse them for future deployments.

:::image type="content" source="../media/1-architecture-diagram.png" alt-text="Architecture diagram that shows the CDN and website modules being published to a registry and used by multiple other deployments." border="false":::

## What will we be doing?

In this module, you'll learn about private registries for sharing modules. You'll find out how to create your own private registry, and how you publish modules to it. You'll also learn how to consume modules from a private registry.

## What is the main goal?

By the end of this module, you'll be able to create private registries, publish modules to them, and consume modules from them.
