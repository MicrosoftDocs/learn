> [!IMPORTANT]
> To complete this exercise, you need:
> - A browser, Git, Visual Studio Code, Azure CLI, and PowerShell 7.4 or later.
> - GitHub Copilot Chat and Agent mode available in VS Code, with sufficient usage allowance.
> - An Azure subscription with Owner access, a dedicated empty lab resource group, and B1 App Service, Container Apps, and Foundry model quota in the selected regions.
> - Microsoft Entra permissions to create app registrations and service principals. Azure subscription Owner access doesn't automatically grant these directory permissions.
> - For the Azure DevOps option, an Azure DevOps Services organization with permission to create a private project and administer pipelines, service connections, and environments, plus available Ubuntu hosted-agent capacity.
> - For the GitHub option, a GitHub account with permission to create a repository, run Actions, and configure environments with required reviewers under your plan, plus available Ubuntu hosted-runner capacity.
> - An authorized reviewer for the Chat deployment.
>
> Both options include identity setup and use OIDC workload identity federation with Microsoft Entra ID, without client secrets. Azure resources, model inference, Copilot requests, and hosted jobs can incur charges.

In this exercise, you deploy EShopOnWebDN11, a sample retail application with a .NET 11 Web storefront and a separate ChatApi service for Foundry-powered catalog assistance. Use the supplied CI to build and package both applications, then use GitHub Copilot to create separate Web and Chat deployment stages or jobs. Deploy the infrastructure, release Web to Azure App Service with chat disabled, then approve and deploy Chat to Azure Container Apps. Test the storefront and a live catalog chat response.

## Choose your DevOps platform

Choose the option that matches your preferred DevOps platform. Both options cover federated authentication, Web-first deployment, environment approval, and Copilot-assisted pipeline authoring. Each option is standalone and includes precreated CI; completing the build exercise isn't required.

Allow approximately **45 minutes per option**, excluding identity and repository setup, CI execution, Azure provisioning, and cleanup. Completing both takes approximately **90 minutes**, plus setup and execution wait time.

### Option 1: Azure DevOps with Azure Pipelines

Import the course repository into a private Azure DevOps project and use its supplied pipeline. Configure a Microsoft Entra OIDC service connection and Chat environment approval. Use Copilot to split deployment into Web and Chat stages, deploy Web first, then approve Chat deployment and verify the live application.

[![Button to launch the Azure DevOps exercise.](../media/launch-exercise.png)](https://go.microsoft.com/fwlink/?LinkId=2390313)

### Option 2: GitHub with GitHub Actions

Clone the course repository, push your copy to a GitHub lab repository, and activate the supplied workflow. Configure Microsoft Entra OIDC trust for the deployment environments and a required Chat reviewer. Use Copilot to create Web and Chat jobs, deploy Web first, then approve Chat deployment and verify the live application.

[![Select this button to launch the GitHub exercise.](../media/launch-exercise.png)](https://go.microsoft.com/fwlink/?LinkId=2390015)

> [!IMPORTANT]
> Deploy only to your dedicated lab resource group. Keep the deployment identity's permissions scoped to that group, review Copilot's changes, and use the configured environment approval before releasing Chat.
>
> Follow the lab's cleanup steps to remove its Azure resources and dedicated identities when finished. Don't delete shared resources or registrations.

When you select either launch exercise button, your browser opens a public GitHub page containing the instructions for that option.

When you finish your selected exercise, return here to continue with the module's knowledge check and summary.
