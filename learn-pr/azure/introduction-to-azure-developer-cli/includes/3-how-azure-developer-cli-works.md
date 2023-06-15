The Azure Developer CLI (`azd`) is built around developer-friendly commands and foundational application templates. `azd` provides a set of commands that help onboard and manage your application on Azure using standardized project templates. These templates include all of the necessary source code and configuration assets to provision and deploy your app to Azure. You can start using `azd` by either working off of one of the existing and extensible sample templates or by building your own.

## Explore `azd` commands

The Azure Developer CLI includes an approachable set of commands that map to common development workflow stages, such as provisioning and deploying resources. Some `azd` commands such as `azd up` also handle multiple stages at once to further streamline these tasks.

For example, a typical `azd` workflow using an existing template includes the following steps:

1. Run the `azd init` command with the `--template` parameter to clone an existing template. The `azd init` command will also prompt you to perform a few initial configurations, such as setting an environment name.

    ```azurecli
    azd init --template todo-nodejs-mongo
    ```

2. Run the `azd auth login` command to sign in to your Azure subscription.

    ```dotnetcli
    azd auth login
    ```

3. Run the `azd up` command to provision and deploy the template resources to Azure.

    ```dotnetcli
    azd up
    ```

4. Once your environment is setup in Azure, you can modify the application features or Azure resource templates and then run `azd up` again to provision your changes.

Other `azd` commands are available to complete additional tasks and expand on this workflow. `azd` is designed to have a minimal number of commands with a small number of parameters for ease of use. Some of the most common `azd` commands you'll use include:

* **azd init** - Initialize a new application.
* **azd up** - Provision Azure resources and deploy your project with a single command.
* **azd provision** - Provision the Azure resources for an application.
* **azd deploy** - Deploy the application code to Azure.
* **azd pipeline** - (Beta) Manage and configure your deployment pipelines.
* **azd auth** - Authenticate with Azure.
* **azd config** - Manage azd configurations (e.g. default Azure subscription, location).
* **azd down** - Delete Azure resources for an application.

## Explore `azd` templates

The Azure Developer CLI commands are designed to work with standardized project templates. Each template is a code repository that adheres to certain file and folder conventions with everything `azd` needs to provision and deploy your application. When you run a command such as `azd up`, the tool uses the project template assets to execute various workflow steps, such as provisioning or deploying resources to Azure.

There are two main approaches to working with `azd` templates:

* **Extend an existing `azd` template** - A large library of `azd` templates already exists to cover common local application stacks, scenarios and architectures. You can browse many of the templates on the [Awesome AZD template gallery](https://azure.github.io/awesome-azd/) site. If you find a template that maps to your local application stack or desired architecture, you can use it as a starting point by replacing the source code directory and modifying the configuration or infrastructure files to meet your needs.

* **Convert your own app into an `azd` template** - You can also convert an existing app into an `azd template` by following the [Make your project compatible with `azd`](/azure/developer/azure-developer-cli/make-azd-compatible?pivots=azd-create) guide. Creating your own template is often more work initially, but allows for the most control and produces a reusable solution for future development work on the app.

Regardless of which approach you choose, the resulting template structure will be the same. All `azd` templates include the following assets:

* **`infra` folder** - Contains all of the Bicep files for the `azd` template. Bicep is an infrastructure as code language that is used to create and configure Azure resources through a declarative syntax. Bicep files are executed by `azd` to create the Azure resources required to host your app.
* **`azure.yaml` file** - A configuration file that defines one or more services in your project and maps them to Azure resources for deployment. For example, you might define an API service and a web front-end service, each with attributes that map them to different Azure resources for deployment.
* **`src folder`** - Contains all of the source code for you app.
* **`.azure` folder** - Contains essential Azure configurations, such as the location to deploy resources or other subscription information.

    :::image type="content" source="../azd-template-structure.png" alt-text="A screenshot showing the Azure Developer CLI template structure.":::

Most `azd` templates also optionally include one or more of the following folders:

* **`.devcontainer` folder** - This folder allows you to setup a Dev Container environment for your application. This is a common development environment approach that is not specific to `azd`.
* **`.azdo` folder** - If you decide to use Azure Pipelines for CI/CD, define the workflow configuration files in this folder.
* **`.github` folder** - If you decide to use GitHub Actions for CI/CD, define the workflow configuration files in this folder.
