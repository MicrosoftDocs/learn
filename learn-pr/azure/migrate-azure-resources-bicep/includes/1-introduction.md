Bicep provides many improvements over JSON for template authoring. These benefits include: simpler syntax, support for modules, automatic dependency management, type validation, and IntelliSense. Your team may have already deployed Azure resources using the Azure portal, JSON ARM templates, or a command-line interface. Migrating your existing JSON ARM templates and Azure resources to Bicep isn't accomplished with a click of a button. The process involves a recommended workflow that includes converting, migrating, refactoring, and testing.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. Recently, your company acquired a smaller competitor that has created a popular toy truck. This company also uses Azure to host its application infrastructure, but their resources were deployed using the Azure portal. They've deployed a virtual machine that provides some of the services to support the toy truck.

You want to begin the process of standardizing on Bicep for all resource deployments. To accomplish this task, you'll convert and migrate your resources to Bicep. You'll refactor the templates for clarity and test deployments to verify the migration.

## What will we be doing?

In this module, you'll learn about the recommended workflow for migrating your Azure resources to Bicep. This workflow consists of five phases: convert, migrate, refactor, test, and deploy.

:::image type="content" source="../media/1-five-phases.png" alt-text="Diagram of the recommended workflow for migrating Azure resources to Bicep." border="false":::

You'll learn how to convert and migrate your Azure resources and JSON templates to a Bicep file. You'll also learn about the available tools and resources that can help improve the quality of your templates, and how to perform test deployments of your converted templates.

## What is the main goal?

After completing this module, you'll be able to migrate your Azure resources to Bicep and have confidence in the fidelity of your templates for future deployments.

## Prerequisites

- You should be familiar with Azure, including the Azure portal, subscriptions, and resource groups.
- You should have an understanding of ARM templates (both JSON and Bicep), including parameters, modules, the `existing` keyword, and child and extension resources.
- You should have a basic understanding of the what-if operation.
- You should have a basic understanding of how to refactor Bicep files to conform to best practices.
