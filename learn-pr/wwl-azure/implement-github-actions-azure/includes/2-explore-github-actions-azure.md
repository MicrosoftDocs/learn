GitHub Actions helps you automate software development workflows from the repository where you store code and collaborate on pull requests and issues. A *workflow* is an automated process defined in a YAML file in the `.github/workflows` directory. A workflow contains one or more jobs that run in response to events such as a push, pull request, or manual request. Each job contains steps that run commands or reusable actions.

GitHub Actions for Azure provides actions and workflow patterns for building, testing, packaging, releasing, and deploying applications to Azure. You can combine GitHub actions with Azure actions to create a continuous integration and continuous delivery (CI/CD) process for services such as Azure App Service and Azure Functions. You can also use authenticated Azure CLI commands when a dedicated deployment action doesn't support the task you need.

## Why use GitHub Actions for Azure

GitHub Actions keeps your workflow definition with your application code, so you can review changes to the application and its delivery process together. Workflow runs provide logs and status information for each job and step. This visibility helps teams diagnose failed builds and deployments without maintaining a separate automation system.

Microsoft publishes actions that handle common Azure authentication and deployment tasks. These actions reduce the amount of service-specific scripting in a workflow and provide inputs for common deployment settings. You can browse Microsoft-published actions in the [GitHub Marketplace](https://github.com/marketplace?category=&type=actions&verification=&query=publisher%3Aazure+) and learn how to [find and customize actions](https://docs.github.com/actions/learn-github-actions/finding-and-customizing-actions).

## Understand an Azure deployment workflow

An Azure deployment workflow usually separates application validation from deployment. This separation prevents a failed build or test from changing an Azure environment. Although the exact steps depend on the application and target service, a workflow commonly moves through the following stages:

* **Trigger the workflow:** Repository events, a schedule, or a manual dispatch determine when the workflow runs. Branch and path filters can limit deployments to intended changes.
* **Build and test the application:** The workflow checks out the repository, configures the required toolchain, restores dependencies, and runs automated tests.
* **Create a deployable artifact:** A build job packages the application, container image, or infrastructure files. Passing an artifact to a separate deployment job ensures that the workflow deploys the same content that it tested.
* **Authenticate and deploy:** The deployment job obtains access to Azure and uses a service-specific action or authenticated command to update the target resource.
* **Verify the deployment:** The workflow can run health checks or smoke tests and record the result in the workflow run.

Jobs can depend on earlier jobs, which lets the deployment job run only after validation succeeds. You can also reuse the same build artifact across development, test, and production jobs instead of rebuilding the application for each environment.

## Choose actions for Azure tasks

You can select actions according to the operation and the Azure service that owns the resource. A service-specific action usually provides the clearest inputs and handles deployment conventions for that service. A general-purpose action provides flexibility when no dedicated action supports the operation.

* **Authentication actions:** The [Azure Login](https://github.com/marketplace/actions/azure-login) action establishes an authenticated Azure session that later steps can use. The next unit explains the supported authentication methods and how to configure the Azure identity.
* **Service-specific deployment actions:** Actions such as [Azure WebApp](https://github.com/marketplace/actions/azure-webapp) and [Azure Functions](https://github.com/marketplace/actions/azure-functions-action) accept deployment inputs for their target services. You can use a service-specific action when it supports the artifact and deployment options your application requires.
* **General Azure actions:** After Azure Login, you can use Azure CLI to run management commands that don't have a suitable dedicated action. This approach is useful for targeted configuration or verification, but you need to handle command behavior and error checking in the workflow.

Before adding an action, you can review its publisher, documentation, required permissions, supported authentication methods, inputs, outputs, and release history. You can use a version reference recommended by the action's publisher. You can limit workflow and Azure permissions to the operations that the job performs.

## Control deployments with environments

[GitHub environments](https://docs.github.com/actions/deployment/targeting-different-environments/using-environments-for-deployment) represent deployment targets such as development, test, and production. A deployment job can reference an environment and use its environment-specific variables and secrets. Environments help you use the same workflow structure while keeping target settings separate.

Environment protection rules can restrict deployment branches or require approval before a job proceeds. When an environment requires approval, the job can't access that environment's secrets until a required reviewer approves the deployment. These controls are useful for production workflows because they place authorization between successful validation and access to deployment credentials.

## Connect GitHub Actions and Azure

Authentication proves the workflow's identity, while Azure role-based access control determines what that identity can do. Choose the authentication method supported by the action and assign the identity only the permissions required at the narrowest practical Azure scope. The next unit provides the detailed identity and role configuration.

The Azure Login action supports OpenID Connect with a Microsoft Entra application or user-assigned managed identity. It also supports a service principal secret and managed identity authentication on eligible self-hosted runners. For GitHub-hosted runners, OpenID Connect exchanges short-lived tokens without storing a client secret.

Some service-specific actions support other credentials. For example, Azure WebApp can use an App Service publish profile directly. When you use OpenID Connect, managed identity, or service principal authentication, you first establish an authenticated session with Azure Login and then run the deployment action or Azure command.
