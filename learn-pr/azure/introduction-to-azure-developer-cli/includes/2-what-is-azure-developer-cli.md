
The Azure Developer CLI (`azd`) is an open-source command-line tool that reduces the time it takes for you to get your application from a local development environment to Azure. `azd` provides best practice, developer-friendly commands that map to key stages in your workflow, whether you’re working in the terminal, your integrated development environment (IDE), or CI/CD (continuous integration/continuous deployment) pipelines.

You can install `azd` locally on your machine or use it in other environments such as GitHub Codespaces. Visit the [install page](/azure/developer/azure-developer-cli/install-azd) for a full list of supported installation methods and environments. For example, to install `azd` locally on Windows or Mac, you could use one of the following commands:

# [Windows](#tab/windows)

```powershell
winget install microsoft.azd
```

# [Mac](#tab/mac)

```bash
brew tap azure/azd && brew install azd
```

---

The Azure Developer CLI relies on extensible templates that include everything you need to get an application up and running on Azure. These templates include reusable infrastructure as code (IaC) assets using Azure Bicep and proof-of-concept application code that can be replaced with your own app code. The combination of `azd` commands and templates allows you to streamline many common development workflow stages and tasks:

* **Build and package application code** - `azd` will auto-detect the language or framework of your application and build and package the code for deployment.

* **Provision resources in Azure** - `azd` can create the Azure services and resources your application needs to run in the cloud in a repeatable, automated way. Reusable `azd` templates ensure that the same resources and configurations will be created the same way for everyone who uses the project.

* **Deploy resources to Azure** - `azd` also deploys your packaged application code to the resources that were provisioned in Azure. `azd` templates support projects that contain multiple apps in a single codebase and handles deploying the correct code to the correct Azure resources.

* **Monitor resources** - You can also monitor your deployed resources using `azd` and Azure Application Insights services. This feature lets you use live metrics, logs, and other data to analyze the status of your app.

* **Remove resources** - `azd` can also tear down all of the Azure resources that were deployed to host your app. This ensures a reliable clean up process to avoid unwanted costs.
