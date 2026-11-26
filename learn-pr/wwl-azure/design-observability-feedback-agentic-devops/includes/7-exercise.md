> [!IMPORTANT]
> To complete this exercise, you need:
> - A browser, Git, Visual Studio Code, PowerShell 7.4 or later, Azure CLI, and Azure Developer CLI (`azd`).
> - The .NET 11 SDK, Node.js, and Docker with a running Linux container engine that supports Linux/amd64 images.
> - GitHub Copilot Chat and Agent mode available in VS Code, with sufficient usage allowance.
> - An Azure subscription with Owner access and quota for B1 Linux App Service, Container Apps, ACR, Log Analytics, Application Insights, and a Foundry model in the selected regions.
> - Microsoft Entra permissions to create app registrations and service principals. Azure subscription Owner access doesn't automatically grant these directory permissions.
> - Permission to read workspace logs and create Azure Monitor workbooks and alerts in the dedicated lab resources.
> - A GitHub account or Azure DevOps Services organization with permission to create your own repository and feedback items. The lab includes repository setup.
>
> Deployment uses your interactive Microsoft Entra sign-in through Azure CLI and azd. The application workloads use managed identities; no deployment client secret or pipeline OIDC configuration is required. Azure resources, telemetry ingestion, model inference, and Copilot requests can incur charges.

In this exercise, you deploy EShopOnWebDN11, a sample retail application with a .NET 11 Web storefront on Azure App Service and a separate ChatApi service on Azure Container Apps. ChatApi uses a Microsoft Foundry model to answer questions about the storefront's catalog.

Use azd to deploy the sample with optional OpenTelemetry instrumentation and workspace-based Application Insights. Follow a successful chat across Web, ChatApi, and Foundry dependencies, verify source attribution, and distinguish completed answers from HTTP success and platform liveness.

## Complete the exercise

This is **one exercise for both Azure DevOps and GitHub learners**. Choose your repository and feedback platform during setup; the deployment and monitoring activities are the same. No pipeline is created, and completing an earlier build or deployment exercise isn't required.

Allow approximately **45 guided minutes**, excluding repository and identity setup, builds, Azure provisioning, telemetry ingestion waits, and cleanup.

During the exercise, you:

- Verify correlated request, dependency, and chat-outcome telemetry in Log Analytics.
- Review Copilot-assisted KQL against the supplied queries and actual evidence.
- Create a scoped workbook and an alert for repeated failed chat answers.
- Introduce a reversible Foundry deployment-name configuration fault, investigate its effects, and restore the original setting.
- Verify recovery using both a complete catalog answer and fresh correlated telemetry.
- Review a Copilot-assisted runbook and create a verified feedback item in GitHub Issues or Azure Boards.

Where available, you can optionally compare an on-demand Azure Copilot Observability Agent investigation with your KQL findings. No autonomous-agent resource or Azure SRE Agent deployment is required.

[![Select this button to launch the observability exercise.](../media/launch-exercise.png)](https://go.microsoft.com/fwlink/?LinkId=2390016)

> [!IMPORTANT]
> Use only dedicated lab resources and synthetic catalog questions. Don't include customer conversations, credentials, tokens, or complete log exports in Copilot prompts or feedback items. Review generated queries and runbook changes before accepting them.
>
> Missing, stale, or incorrectly attributed telemetry is **unknown**, not healthy. HTTP 200, healthy liveness probes, or an alert resolving don't prove that chat answers completed successfully.
>
> Restore the original model setting and follow the lab's cleanup steps to remove its Azure resources and dedicated Chat API Entra registration. Don't delete shared resources or registrations.

When you select the launch exercise button, your browser opens a public GitHub page containing the lab instructions.

When you finish the exercise, return here to continue with the module's knowledge check and summary.
