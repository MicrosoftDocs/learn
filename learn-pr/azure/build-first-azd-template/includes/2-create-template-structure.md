The Azure Developer CLI (`azd`) assists you with building new templates for your apps using the `azd init` command and starter templates. In this unit, you'll create the basic scaffolding or structure of a new template that you'll build on for the rest of the module.

1. In an empty directory on your local machine, run the `azd init` command.

    ```azdeveloper
    azd init
    ```

1. The command output displays a list of starter templates and full sample app options. The starter templates include the essential folder structure, starter infrastructure as code files, and other boilerplate configuration files to get started building templates. The full sample templates also include placeholder application code and the files needed to deploy them. For this module, you'll learn to build your own template rather than modifying existing app code, so choose the **Starter - Bicep** option from the list. The Azure Developer CLI also supports [using Terraform](/azure/developer/azure-developer-cli/use-terraform-for-azd) if you prefer that option. Terraform support is currently in alpha and must be [manually enabled](/azure/developer/azure-developer-cli/use-terraform-for-azd).

1. When prompted for an environment name, enter *azdlearn* or a name of your choosing. The environment name influences the naming of provisioned resources in Azure.

1. A set of folders is created inside of the current directory:

    :::image type="content" source="../media/template-structure.png" alt-text="The starter template structure.":::
    
> [!NOTE]
> You may have noticed the `azd init` command also provides a project template called **Minimal**, which contains the simplest possible template structure. However, the **Starter - Bicep** template you selected includes additional scaffolding code that is very useful but still technology agnostic, so it's often a great choice for getting started.

The generated folders provide all of the essential building blocks of an `azd` template:

* **.azdo** - A folder containing the starter `.yml` configuration files for CI/CD with Azure Pipelines.
* **.azure** - A folder containing essential settings for the template's Azure environment, such as the environment name.
* **.devcontainer** - A folder containing configuration files used to run the template in a dev container environment.
* **.github** - A folder containing a starter `.yml` configuration template to set up a CI/CD pipeline through GitHub actions.
* **infra** - A folder containing starter Bicep files for the template's infrastructure as code. If you selected the Terraform starter template, this folder contains Terraform files instead.
* **azure.yaml** - A file that describes how the parts of your application map to services in Azure.

This starter template contains most of what you need to create your own `azd` template. Over the next several units, you'll learn how to update these existing files and add new assets to build a complete template.
