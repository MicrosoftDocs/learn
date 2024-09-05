By using input variables, you can create flexible and reusable Terraform modules, whether they will act as the root module for your deployment or a reusable module referenced by another Terraform module. You define input variables for any aspect of your deployment that might change, such as environment-specific settings, pricing and capacity configuration for your Azure resources, and API keys to access external systems. Input variables can be configured to securely handle sensitive data. In this module, you'll learn how to define and configure input variables, and how you can specify input variable values during your deployments.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. The human resources (HR) department is migrating an on-premises web application and its database to Azure. The application will handle information about all of the toy company employees, so security is important.

You've been asked to prepare infrastructure for three environments: dev, test, and production. You'll build this infrastructure by using infrastructure as code techniques so that you can reuse the same templates to deploy across all of your environments. You'll create separate sets of input variable values for each environment, while securely retrieving database credentials from Azure Key Vault.

## What will we be doing?

In this module, you'll build a reusable Terraform module with input variables. Our Terraform configuration will define an Azure App Service plan and an app. It will also define a SQL server and database. You'll create a parameter file to specify the values for your environments. Then you'll secure the parameter values by using Key Vault.

## What is the main goal?

By the end of this module, you'll be able to:

- Customize input variables and limit the values that can be used by each input variable
- Understand the ways that input variables can be passed to Terraform when executing Terraform core workflow operations (e.g., `terraform plan` and `terraform apply`)
- Work with secure input variables to ensure that secrets aren't leaked or shared unnecessarily
