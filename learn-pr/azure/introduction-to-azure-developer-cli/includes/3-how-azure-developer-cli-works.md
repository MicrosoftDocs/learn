The Azure Developer CLI (`azd`) is built around developer-friendly commands and foundational application templates. `azd` provides a set of commands that help onboard and manage your application on Azure using standardized project templates. These templates include all of the necessary source code and configuration assets to provision and deploy your app to Azure. You can start using `azd` by either working off of one of the existing and extensible sample templates or by building your own.

## Explore `azd` commands

The Azure Developer CLI includes an approachable set of commands that map to common development workflow stages, such as provisioning and deploying resources. Some `azd` commands such as `azd up` also handle multiple stages at once to further streamline these tasks.

For example, a typical `azd` workflow using an existing template includes the following steps:

1. Run the `azd init` command with the `--template` parameter to clone an existing template and set an environment name when prompted.

    ```azdeveloper
    azd init --template todo-nodejs-mongo
    ```

2. Run the `azd auth login` command to sign in to your Azure subscription.

    ```azdeveloper
    azd auth login
    ```

3. Run the `azd up` command to provision and deploy the template resources to Azure.

    ```azdeveloper
    azd up
    ```

4. Once your environment is set up in Azure, you can locally modify the application features or Azure resource templates and then run `azd up` again to provision your changes.

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

The Azure Developer CLI commands are designed to work with standardized project templates. Each template is a code repository that adheres to specific file and folder conventions. The templates contain the assets `azd` needs to provision Azure resources and optionally deploy application source code. Some templates may not include application source code under the assumption you will add your own. When you run a command such as `azd up`, the tool uses the project template assets to execute various workflow steps, such as provisioning or deploying resources to Azure.

There are two main approaches to working with `azd` templates:

* **Extend an existing `azd` template** - A large library of `azd` templates already exists to cover common local application stacks, scenarios and architectures. You can browse many of the templates on the [Awesome AZD template gallery](https://azure.github.io/awesome-azd/) site. If you find a template that maps to your local application stack or desired architecture, you can use it as a starting point by replacing the source code directory and modifying the configuration or infrastructure files to meet your needs.

* **Convert your own app into an `azd` template** - You can also convert an existing app into an `azd template` by following the [Make your project compatible with `azd`](/azure/developer/azure-developer-cli/make-azd-compatible?pivots=azd-create) guide. Creating your own template is often more work initially, but allows for the most control and produces a reusable solution for future development work on the app. The core steps to create your own template are as follows:

    - Initialize the project template with `azd init`
    - Create the infrastructure as code files using Bicep or Terraform
    - Update the `azure.yaml` file to tie the app services together with the Azure resources
    - Provision & deploy with `azd up`
    
        :::image type="content" source="../media/azd-workflow.png" alt-text="A diagram showing the Azure Developer CLI template creation workflow.":::

Regardless of which approach you choose, the resulting template structure will be the same. All `azd` templates include the following assets:

* **`infra` folder** - Contains all of the Bicep or Terraform infrastructure as code files for the `azd` template. Infrastructure as code allows you to define infrastructure resources and configurations in declarative definition files that reliably generate the same environments every time they are deployed. Terraform works across multiple cloud platforms, while Bicep is specific to Azure. These files are executed by `azd` to create the Azure resources required to host your app. You can learn more about infrastructure as code in the [What is infrastructure as code?](/devops/deliver/what-is-infrastructure-as-code) training module.
* **`azure.yaml` file** - A configuration file that defines one or more services in your project and maps them to Azure resources for deployment. For example, you might define an API service and a web front-end service, each with attributes that map them to different Azure resources for deployment.
* **`.azure` folder** - Contains essential Azure configurations and environment variables, such as the location to deploy resources or other subscription information.
* **`src folder`** - Contains all of the deployable app source code. Some `azd` templates only provide infrastructure assets and leave the `src` directory empty for you to add your own application code.

    :::image type="content" source="../media/azd-template-structure.png" alt-text="A screenshot showing the Azure Developer CLI template structure.":::

Most `azd` templates also optionally include one or more of the following folders:

* **`.devcontainer` folder** - Allows you to set up a Dev Container environment for your application. This is a common development environment approach that is not specific to `azd`.
* **`.github` folder** - Holds the CI/CD workflow files for GitHub Actions, which is the default CI/CD provider for `azd`.
* **`.azdo` folder** - If you decide to use Azure Pipelines for CI/CD, define the workflow configuration files in this folder.
