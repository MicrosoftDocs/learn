The Azure Developer CLI (`azd`) assists you with building new templates for your apps using the `azd init` command and starter templates. In this unit, you'll create the basic scaffolding or structure of a new template that you'll build on for the rest of the module.

1. In an empty directory on your local machine, run the `azd init` command.

    ```azdeveloper
    azd init
    ```

1. The command output displays three different choices for initializing an `azd` template:

- **Use code in the current directory**: Analyzes your app code to create and configure certain template assets for you.
- **Select a template**: Choose an existing starter template that includes the essential folder structure, starter infrastructure as code files, and other boilerplate configuration files to streamline building templates.
- **Create a minimal project**: Generates the minimum configuration files to get started.

    Read more about these different choices in the [Create Azure Developer CLI templates overview](/azure/developer/azure-developer-cli/make-azd-compatible) documentation.

1. Choose the **Select a template** option and `azd` displays a pre-configured list of available templates.
1. Search for **Starter** and then select the **Starter - Bicep** option from the results list. The Azure Developer CLI also supports [using Terraform](/azure/developer/azure-developer-cli/use-terraform-for-azd) if you prefer that option. Terraform support is currently in alpha and must be [manually enabled](/azure/developer/azure-developer-cli/use-terraform-for-azd).

1. When prompted for an environment name, enter *azdlearn* or a name of your choosing. The environment name influences the naming of provisioned resources in Azure.

1. A set of folders is created inside of the current directory:

    :::image type="content" source="../media/template-structure.png" alt-text="The starter template structure.":::

> [!NOTE]
> You may have noticed the `azd init` command also provides a project template called **Minimal**, which contains the simplest possible template structure. However, the **Starter - Bicep** template you selected includes additional scaffolding code that is very useful but still technology agnostic, so it's often a great choice for getting started.

The generated folders provide all of the essential building blocks of an `azd` template:

- **.azure** - A folder containing essential settings for the template's Azure environment, such as the environment name.
- **.devcontainer** - A folder containing configuration files used to run the template in a dev container environment.
- **infra** - A folder containing starter Bicep files for the template's infrastructure as code. If you selected the Terraform starter template, this folder contains Terraform files instead.
- **azure.yaml** - A file that describes how the parts of your application map to services in Azure.
- **.gitignore** - A starter .gitignore file for excluding unwanted files from git version control.
- **README.md** - A starter README file that provides general guidance for the end user of the template.

This starter template contains most of what you need to create your own `azd` template. Over the next several units, you'll learn how to update these existing files and add new assets to build a complete template.
