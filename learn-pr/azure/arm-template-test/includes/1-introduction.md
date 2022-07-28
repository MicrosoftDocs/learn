Azure Resource Manager (ARM) templates use things like parameters, variables, and functions to create the templates. These constructs save you time, because you don't need to create a new template for each environment. You also get consistent naming.

## Example scenario

You're on a software team that's authoring these templates for the company Tailwind Traders. You plan to deploy the described infrastructure in the templates. As you author these templates, you care about having a fast feedback loop. It's important that you're aware of any issues before deployment. Issues that can happen while authoring include errors in the templates or violation of good practices.

You decide to evaluate the existing set of tools that addresses these issues.

## What will we be doing?

In this module, you gain an understanding of what practices are beneficial to follow and why they're important. You also practice using the ARM Template Test Toolkit (ARM-TTK) to correct issues in your templates.

[!INCLUDE [Bicep introduction for JSON modules](../../includes/azure-template-json-bicep-intro.md)]

> [!CAUTION]
> If you use Bicep to write your code, we recommend you don't use the ARM-TTK. Instead, you should use the Bicep linter.

## What is the main goal?

By the end of this module, you'll be able to validate your template's adherence to recommendations by using the ARM Template Test Toolkit. You'll also be able to implement domain-specific rules for deployments that can be run by using the ARM Template Test Toolkit.

## Prerequisites

You should have familiarity with Azure, including the Azure portal, subscriptions, resource groups, and resource definitions.

To follow along with the exercises in the module, you'll need:

  - [Visual Studio Code](https://code.visualstudio.com?azure-portal=true) installed locally.

