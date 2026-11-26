> [!IMPORTANT]
> To complete this exercise, you need:
> - A browser, Git, Visual Studio Code, and PowerShell.
> - GitHub Copilot Chat and Agent mode available in VS Code, with sufficient usage allowance.
> - For the Azure DevOps option, an Azure DevOps Services organization with permission to create a private project, import a repository, and create pipelines, plus available Ubuntu hosted-agent capacity.
> - For the GitHub option, a GitHub account with permission to create a repository, run Actions, and open pull requests, plus available Ubuntu hosted-runner capacity.
>
> The hosted agent or runner performs the .NET and Docker builds. A local .NET SDK, Docker engine, Azure subscription, or Foundry deployment isn't required. Copilot requests and hosted builds can incur charges.

In this exercise, you create continuous integration (CI) for EShopOnWebDN11, a sample retail application with a .NET 11 Web storefront. To help customers, the web app provides a separate ChatApi service using Microsoft Foundry. You build, test, and publish both applications, then use GitHub Copilot to add Docker packaging for ChatApi. You review the generated YAML, diagnose an intentionally incorrect Dockerfile path using build logs, and verify automatic CI after merging your changes.

## Choose your DevOps platform

Choose the option that matches your preferred DevOps platform. Both options cover the same CI, Docker packaging, and Copilot-assisted authoring and troubleshooting skills. Each option is standalone; no previous lab is required.

Allow approximately **60 minutes per option**, excluding repository setup and hosted-job queue time. Completing both takes approximately **120 minutes**, plus setup and queue time.

### Option 1: Azure DevOps with Azure Pipelines

Import the course repository into a private Azure DevOps project and clone it into VS Code. Create an Azure Pipelines YAML definition to build, test, and publish Web and Chat. Use Copilot to add Docker build and image-save tasks, correct a controlled build failure, and enable automatic CI when changes merge into `main`.

[![Button to launch the Azure DevOps exercise.](../media/launch-exercise.png)](https://go.microsoft.com/fwlink/?LinkId=2390119)

### Option 2: GitHub with GitHub Actions

Clone the course repository and push your copy to a GitHub lab repository. Create a GitHub Actions workflow to build, test, and publish Web and Chat. Use Copilot to add Docker build and image-save steps, correct a controlled build failure, and enable automatic CI when changes merge into `main`.

[![Button to launch the GitHub exercise.](../media/launch-exercise.png)](https://go.microsoft.com/fwlink/?LinkId=2390120)

> [!IMPORTANT]
> Work in your own lab repository and review Copilot's changes before committing. Correct the deliberately broken Dockerfile path before merging.
>
> This exercise builds and packages the applications; it doesn't deploy them to Azure or call a live Foundry model.

When you select either launch exercise button, your browser opens a public GitHub page containing the instructions for that option.

When you finish your selected exercise, return here to continue with the module's knowledge check and summary.
