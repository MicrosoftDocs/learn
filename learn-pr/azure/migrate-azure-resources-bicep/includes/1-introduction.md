Bicep provides many improvements over JSON for template authoring. These benefits include: simpler syntax, support for modules, automatic dependency management, type validation, and IntelliSense. Your team may have already deployed Azure resources using the Azure portal, JSON ARM templates, or a command line interface. Migrating your existing JSON ARM templates and Azure resources to Bicep isn't accomplished with a click of a button. The process involves a recommended workflow that includes converting, migrating, refactoring, and testing.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. Recently, your company acquired a smaller competitor. This company is also using Azure to host its application infrastructure, but their resources were deployed using JSON ARM templates and the Azure portal.

You want to begin the process of standardizing on Bicep for all resource deployments. To accomplish this task, you'll need to convert the existing JSON templates to Bicep, export the existing resource definitions from the Azure portal, and refactor the templates for clarity. Before using these migrated templates, you'll want to verify the migration using the available tools and documentation resources.

## What will we be doing?

In this module, you'll learn about a recommended workflow for migrating your JSON ARM templates and Azure resources to Bicep. This workflow consists of five phases: convert, migrate, refactor, test, and deploy. 

:::image type="content" source="../media/1-five-phases.png" alt-text="Diagram of the recommended workflow for migrating Azure resources to Bicep." border="true":::

Throughout this module, you will also learn about the available tools and documentation resources that can help improve the quality of your templates.

- How can you convert and migrate your JSON templates to Bicep?
- How can you refactor your Bicep files to meet best practices?
- How can you perform test and production deployments of your migrated templates?

## What is the main goal?

After completing this module, you'll be able to migrate your JSON ARM templates to Bicep and have confidence in the fidelity of your templates for future deployments.

## Prerequisites

- You should be familiar with Azure, including the Azure portal, Subscriptions, and Resource groups.
- You should have an understanding of ARM templates (both JSON and Bicep), including parameters, modules, and child and extension resources.
- You should have a basic understanding of the what-if operation.
