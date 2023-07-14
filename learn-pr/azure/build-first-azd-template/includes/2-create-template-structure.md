The Azure Developer CLI (`azd`) can assist you with building new templates for your apps through the use of the `azd init` command and preexisting starter templates.

1. In an empty directory on your local machine, run the `azd init` command.

```bash
azd init
```

1. `azd` will display a list of starter template options. Some of the templates include example source code and infrastructure files, while others only provide the basic structure of a template and certain essential files. For this module you'll learn to build your own template rather than relying on existing app code, so choose the **starter template** option from the list.

1. A set of folders will be created inside of the current directory that should resemble the following:

<image>

The generated folders provide all of the essential building blocks of an `azd` template:

* **.azdo** - A folder containing the starter `.yml` configuration files for CI/CD with Azure Pipelines.
* **.azure** - A folder containing essential settings for the template's Azure environment.
* **.devcontainer** - A folder containing configuration files used to run the template in a dev container environment.
* **.github** - A folder containing a starter `.yml` configuration template to setup a CI/CD pipeline through GitHub actions.
* **infra** - A folder containing starter Bicep files for the template's infrastructure as code. If you selected the Terraform starter template, this folder will contain Terraform files instead.
* **azure.yaml** - A file that describes how the parts of your application map to services in Azure.

This starter template contains most of what you need to create your own `azd` template. Over the next several units, you'll learn how to update these existing files and add new assets to build a complete template.
