GitHub Actions helps you automate your software development workflows from within GitHub. You can deploy workflows in the same place where you store code and collaborate on pull requests and issues. In GitHub Actions, a *workflow* is an automated process that you set up in your GitHub repository. You can build, test, package, release, or deploy any project on GitHub with a workflow.

Each workflow is made up of individual actions that run after a specific event (like a pull request) occur. The individual actions are packaged scripts that automate software development tasks.

With GitHub Actions for Azure, you can create workflows to build, test, package, release, and deploy to Azure. GitHub Actions for Azure supports Azure services, including Azure App Service, Azure Functions, and Azure Key Vault.

> [!NOTE]
> GitHub Actions also include support for utilities, including Azure Resource Manager templates, Azure CLI, and Azure Policy.

## Why use GitHub Actions for Azure

Microsoft developed GitHub Actions for Azure and designed them be used with Azure. You can get a complete list of GitHub Actions for Azure in the [GitHub Marketplace](https://github.com/marketplace?category=&type=actions&verification=&query=publisher%3Aazure+). Learn more about  [finding and customizing actions](https://docs.github.com/en/actions/learn-github-actions/finding-and-customizing-actions) and incorporating actions into your workflows.

## Connect GitHub Actions and Azure

Depending on the action, you can use service principal or publish profile to connect to Azure from GitHub. For example: 

* The [Azure Login](https://github.com/marketplace/actions/azure-login) action uses a service principal. When you use a service principal, you can use OpenID Connect or a secret stored in your repository.
* The [Azure App Service](https://github.com/marketplace/actions/azure-webapp) action supports using either a publish profile or a service principal. 

You can use the Azure Login action in combination with other GitHub Actions for Azure. You can also use Azure Login with community-contributed actions not supported by Microsoft.