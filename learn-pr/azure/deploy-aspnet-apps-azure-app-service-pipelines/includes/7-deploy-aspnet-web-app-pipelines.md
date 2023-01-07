You've built and published the artifacts into Azure Pipelines and the required Azure resources are provisioned. You're now ready for the last part of the deployment process. That part involves deploying the package that contains the sample ASP.NET web app into Azure App Service, setting up its data store, and configuring a connection string that allows the web app to access the data store. Your implementation will comprise a separate Azure Pipeline stage containing Azure App Service deployment and configuration tasks.

## Azure Pipelines ASP.NET web app deployment tasks

Use the following process to deploy ASP.NET app build artifacts:

1. Download the build artifacts.
1. Deploy the build artifacts into the Azure App Service web app.
1. Configure the Azure App Service web app data store settings.

To implement these steps, use the following Azure Pipelines tasks:

1. **Download build artifacts**: Downloads files that were published into Azure Pipelines as artifacts following the successful build.
1. **Azure App Service deploy**: Deploys the downloaded artifacts to Azure App Service web app.
1. **Azure App Service Settings**: Configures Azure App Service web app settings.

> [!NOTE]
> Alternatively, you could set the connection string directly in the **Azure App Service deploy** task by using its XML transformation functionality.

> [!NOTE]
> You need to ensure that the download path of the **Download build artifacts** task matches the package location specified in the **Azure App Service deploy** task.

To simplify implementing these tasks with the YAML-based approach, you can use the task assistant. To target the same Azure resources that you provisioned in the previous exercise, you should reference the variables in the same variable group you used during the Azure resource provisioning stage.

## Azure Pipelines ASP.NET web app deployment agents

As the Azure resource deployment stage of the pipeline, this stage does not have specific operating system dependencies. Effectively, you have the option of using self-hosted agents or any of the Microsoft-hosted agents, which include those running Ubuntu or macOS X.

## Continuous integration and continuous deployment

The `trigger:` element of a YAML pipeline allows you to enable continuous integration, which triggers the build process following commits to the main branch of the GitHub repository hosting the sample ASP.NET app code. The multi-stage pipeline you authored also performs continuous deployment, automatically provisioning the target Azure environment and populating its resources with build artifacts.
