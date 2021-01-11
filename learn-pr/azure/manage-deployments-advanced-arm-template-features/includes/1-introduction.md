Azure Resource Manager (ARM) templates have numerous constructs, able to handle both simple and complex setups. These constructs help you run statements conditionally, define dependencies between resources, and read secrets at deployment time.

Let's say you're on a software team at Tailwind Traders. You plan to deploy infrastructure to Azure by using ARM templates. There are various challenges that you need to address, including managing secrets, assigning secrets to template resources, and dealing with repetitive resources. You also need to look into how you can express dependencies to control the order in which resources are deployed.

In this module, you'll gain an understanding for how to handle more complex scenarios that you'll face. You'll use constructs like `copy` and `dependsOn`, as well as learn how to manage secrets during deployment.

## Learning objectives

After completing this module, you'll be able to:

- Control the deployment order of resources by using the `dependsOn` construct.
- Securely assign secrets like passwords to resources in your templates by using Azure Key Vault and your ARM template.
- Conditionally deploy resources by using the `condition` construct and parameters at deployment time.
- Deploy multiple resources of the same type by using the `copy` construct to reduce repetitive configuration.

## Prerequisites

- Familiarity with Azure, including the Azure portal, subscriptions, resource groups, and resource definitions.
- Experience building and running basic ARM templates.
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true) (installed locally).
- The [Azure Resource Manager Tools](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&azure-portal=true) extension for Visual Studio Code (installed locally).
- The [PowerShell](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell&azure-portal=true) extension for Visual Studio Code (installed locally).
- On Windows, the [OpenSSH client](https://docs.microsoft.com/windows-server/administration/openssh/openssh_install_firstuse?azure-portal=true).
- Either:
  - The latest [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&azure-portal=true) tools (installed locally).
  - The latest [Azure PowerShell](https://docs.microsoft.com/powershell/azure/install-az-ps?view=azps-4.3.0&azure-portal=true) and the [Azure PowerShell module](https://docs.microsoft.com/powershell/azure/install-az-ps?view=azps-5.2.0&azure-portal=true) (installed locally).
