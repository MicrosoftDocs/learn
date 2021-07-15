Bicep provides many improvements over JSON for template authoring, including simpler syntax, modules, automatic dependency management and type validation and IntelliSense. Your team may have already deployed Azure resources using the Azure portal, ARM JSON templates, or a command line interface. Migrating your existing ARM JSON templates and Azure resources to Bicep isn't accomplished with a click of a button. The process involves a recommended workflow that includes conversions and verifications.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. Recently, your company acquired a smaller competitor. This company is also using Azure to host its application infrastructure, but their resources were deployed using ARM JSON templates and the Azure portal.

You want to begin the process of standardizing on Bicep for all resource deployments. To accomplish this task, you'll need to convert the existing JSON templates to Bicep and export the existing resource definitions from the Azure portal. Before using these migrated templates, you'll want to verify the migration using the tools available.

## What will we be doing?

In this module, you'll learn about the ways you can migrate your Azure resources to Bicep, including ARM JSON templates and Azure portal resources. You will also learn how you can verify your resource template migrations. You'll find answers to these questions:

- How can you migrate your JSON templates to Bicep using the native tooling?
- How can you export Azure resource definitions to Bicep using the Azure portal and the command line?
- How can you verify your template migrations using the what-if operation and available documentation?

## What is the main goal?

After completing this module, you'll be able to migrate your ARM JSON templates to Bicep and verify the migration using available tools.

## Prerequisites

- You should be familiar with Azure, including the Azure portal, Subscriptions, and Resource groups.
- You should have an understanding of ARM templates (both JSON and Bicep), including parameters, modules, and child and extension resources.
- You should have a basic understanding of the what-if operation.
