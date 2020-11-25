Azure Resource Manager (ARM) templates has numerous constructs able to handle everything from simpler setups to even more complex ones. These constructs help you to for example conditionally run statements, define dependencies between resources, and read secrets at deployment time.

You're on a software team at Tailwind Traders. You plan to deploy infrastructure to Azure by using ARM templates. There are various challenges that you need to address, including managing secrets, assigning secrets to template resources, and dealing with repetitive resources. You also need to look into how you can express dependencies to control the order in which resources are deployed.

In this module, you'll gain an understanding for how to handle more complex scenarios that you'll face. You'll use constructs like _copy_ and _dependsOn_, as well as learn how to manage secrets during deployment.

## Learning objectives

After completing this module, you'll be able to:

- Control the deployment order of resources by using the _dependsOn_ construct.
- Securely assign secrets like passwords to resources in your templates by using an Azure Key Vault and ARM template configuration.
- Conditionally deploy resources by using the _condition_ construct and parameters at deployment time.
- Deploy multiple resources of the same type by using the _copy_ construct and thereby reducing repetitive configuration.

## Prerequisites

- Familiarity with Azure, including the Azure portal, subscriptions, resource
groups, and resource definitions.
- Experience building and running basic ARM templates.
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true) installed locally.
- The [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&azure-portal=true) extension installed locally.
