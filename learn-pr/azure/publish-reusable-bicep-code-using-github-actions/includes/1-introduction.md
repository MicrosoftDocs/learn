Sometimes, your Bicep code isn't deployed directly to Azure. Instead, you might want it to be _reused_ in multiple deployments. Azure template specs enable you to create reusable deployments for complete solutions. Bicep modules and registries enable you to create components that you can add to other Bicep deployments.

Publishing reusable Bicep code comes with different concerns than normal Bicep deployments. In this Microsoft Learn module, you'll learn how to automate the validation and publishing of your template specs and Bicep modules.

## Example scenario

Suppose you're the Azure administrator at a toy company. The company's use of Azure is expanding. The company has introduced a new cloud governance approach to ensure that your deployments follow Microsoft's recommended practices for security and reliability.

To make it easy for your colleagues, you've created a set of security-hardened Bicep files. Some of the files deploy complete solutions that your colleagues need. Other files define sets of resources that your colleagues can use within their own Bicep deployments.

You've previously used GitHub Actions to automate the deployment of your Azure resources. Now, you want to find a way to automate the validation and publishing of your reusable Bicep code.

:::image type="content" source="../media/1-architecture-diagram.png" alt-text="Diagram that shows two workflows. One publishes a complete Bicep file to a template spec, and the other publishes a module to a Bicep registry." border="false":::

## What will we be doing?

In this module, you'll learn about publishing reusable Bicep code from a deployment workflow. You'll learn how your workflow securely identifies itself so that it can publish your code. You'll also learn how to perform code validation and versioning within an automated deployment process.

You'll create GitHub Actions workflows to publish two Bicep files: one as a template spec, and another as a module to a private Bicep registry.

## What is the main goal?

After you complete this module, you'll be able to publish reusable Azure template specs and Bicep modules from your deployment workflows.

If you need a refresher on Bicep modules, registries, or template specs, see these Microsoft Learn training modules:

- [Create composable Bicep files by using modules](xref:learn.azure.create-composable-bicep-files-using-modules)
- [Share Bicep modules by using private registries](xref:learn.azure.share-bicep-modules-using-private-registries)
- [Publish libraries of reusable infrastructure code by using template specs](xref:learn.azure.arm-template-specs)
