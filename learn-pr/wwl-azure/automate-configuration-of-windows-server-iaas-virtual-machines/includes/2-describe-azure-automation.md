*Azure Automation* automates frequent, time-consuming, and error-prone administrative tasks. Contoso IT administrators can use it to manage resources in Azure, on-premises datacenters, and other cloud environments. A *runbook* implements an administrative procedure as code. Where that code runs determines which local resources and network endpoints it can access.

## What is Azure Automation?

Azure Automation runs administrative procedures through scripts and workflows. Use Azure Machine Configuration for the desired-configuration and drift-remediation workflow covered later in this module.

For updates and inventory, use the following complementary services rather than the retired Automation integrations:

| Service | Capability and dependencies |
| --- | --- |
| **Azure Update Manager** | Assesses and installs operating system updates through its Azure VM or Azure Arc extension architecture. It doesn't require an Automation account, a Log Analytics workspace, or Azure Monitor Agent. |
| **Change Tracking and Inventory with Azure Monitor Agent** | Collects supported software, service, file, and registry information using Azure Monitor Agent (AMA), the Change Tracking extension, data collection rules, and a Log Analytics workspace. It reports changes rather than enforcing a desired configuration. |

The Runbooks gallery in the Azure portal provides sample runbooks. Review their code, runtime requirements, and permissions before importing and testing them.

## Azure Automation architecture

An Automation account contains related runbooks, runtime settings, and shared assets. You can create multiple accounts per Azure subscription, for example, to separate development and production environments. The following components support your runbooks:

|Asset|Description|
|------------|------------------------------------------------------------|
|**Runtime environments and packages**|Define the runbook language, supported runtime version, and dependencies. Packages must be compatible with that runtime.|
|**Modules**|PowerShell modules provide cmdlets and activities. Account-level module changes are reflected in the corresponding system-generated Runtime environment. Customer-created environments manage their own dependencies.|
|**Schedules**|By using schedules, you can execute runbooks automatically rather than on demand, either once at a designated date and time, or in a recurring manner.|
|**Certificates**|This category consists of certificates uploaded to an Azure Automation account. One common reason for using certificates is to facilitate certificate-based authentication.|
|**Connections**|Store connection and authentication information for services or applications that require it.|
|**Variables**|This category contains values that you want to reference in your scripts. By using variables, you avoid the need to modify your runbooks directly (potentially multiple times) if the referenced value changes.|
|**Credentials**|Store a username and password for services that require this authentication method.|

## Overview of Azure Automation runbooks

Runbooks use shared assets to perform a custom process. You can implement them with PowerShell scripts, Python runbooks using a runtime supported by Azure Automation and its runtime-support policy, or Windows PowerShell workflows. Each execution is a *job*.

An Automation runbook combines code with a Runtime environment. For new textual PowerShell runbooks, use the supported PowerShell 7.6 runtime where it's available in your target Azure cloud, with tested Az and other dependency versions. Test the runbook in its selected environment before publishing it.

### Where runbooks execute

Choose the execution location according to the resources your job needs:

- **Azure sandbox.** A cloud job can manage resources through accessible service APIs. It doesn't run inside every VM it manages or automatically gain access to that VM's files and private network.
- **Hybrid Runbook Worker.** For local operating system access or private-network resources, use a supported extension-based Hybrid Runbook Worker and select its worker group when starting the job. An available member of that group picks up the job, so every eligible member must have the resources and permissions it requires. The worker host needs compatible runtimes and modules, network routes, and permissions. Non-Azure hosts also require the supported Azure Arc and worker-extension prerequisites; onboarding these hosts is outside this module's Azure VM walkthrough.

Use a managed identity for supported Azure-resource authentication and grant only the roles the runbook needs. The worker machine's identity, the job's local process account, its Azure authentication identity, and its network access are separate concerns. Private connectivity doesn't automatically give a cloud sandbox access to a private network.

For hybrid jobs, follow the current [managed-identity selection rules](/azure/automation/automation-hrw-run-runbooks#runbook-auth-managed-identities). Don't assume that an Automation account's user-assigned managed identity, supported for cloud jobs, can be used for hybrid execution.

> [!IMPORTANT]
> Azure sandbox jobs are subject to a three-hour fair-share runtime limit. PowerShell script runbooks and Python runbooks that exceed it are stopped rather than automatically resumed. For a procedure that needs longer, use a supported extension-based Hybrid Runbook Worker, or divide the work into shorter, independently restartable jobs. Hybrid jobs aren't subject to this three-hour limit, but host failures or restarts can still interrupt them. Make the operations safe to repeat and record progress durably when recovery requires it.

### PowerShell workflows

Windows PowerShell Workflow uses Windows Workflow Foundation, a .NET Framework technology. Workflow activities follow different authoring rules from ordinary PowerShell scripts. Checkpoints can preserve execution state, but recoverability depends on where you place checkpoints and how the workflow handles interruptions. Workflows also support parallel groups of commands, which can help with independent, time-consuming tasks.

In Azure Automation, Workflow and graphical runbook types use the system-generated Windows PowerShell 5.1 Runtime environment. They don't run as PowerShell 7.6 textual runbooks. Prefer a current textual runbook for new procedures unless you need a specific Workflow capability, such as checkpoints.

### Types of runbooks

Azure Automation supports two approaches to authoring runbooks:

- **Graphical.** Create and edit these runbooks in the Azure portal's graphical editor. Graphical runbooks represent PowerShell commands and workflows visually, including checkpoints and parallel processing for workflows.
- **Textual.** Create and edit these runbooks in the Azure portal's textual editor, or use an external tool and import the runbooks into Azure.

> [!CAUTION]
> You can't convert between graphical and textual runbooks. Selecting a different runtime doesn't convert a workflow into an ordinary PowerShell script.

You can convert between graphical PowerShell runbooks and graphical PowerShell workflows when importing them into an Automation account. Workflow-based runbooks take longer to start because they must be compiled first. You can also export and import both graphical and textual runbooks to copy them between Automation accounts.

## Managing Azure Automation runbooks

Any runbook residing in an Automation account has a specific authoring status depending on its stage of development:

- **New.** You can modify and test an unpublished runbook, but you can't schedule it. There's no published version to revert to.
- **Published.** After testing, publish the runbook to make it available for on-demand execution, schedules, and supported triggers.
- **In edit.** Editing a published runbook creates a draft that you can modify and test without affecting its published version. You can discard the draft changes and revert to the published version.

### Testing a runbook

To test a runbook, in the Azure portal, use the following procedure:

1. Select the appropriate Automation account, and then select **Runbooks**.
1. Select any runbook that you want to test.
1. On the runbook page, select **Edit**.
1. In the selected runbook, select **Test pane**.
1. Supply the runbook's required parameters using nonproduction values.
1. In **Run Settings**, choose **Azure** for a cloud test. If the job requires a worker's local resources, choose **Hybrid Worker** and select the intended test group.
1. Select **Start** to execute the draft.
1. Inspect the output, warnings, and errors in the **Output** pane, and confirm the intended effect on the test resource before publishing.

Use these steps from either the graphical or textual editor. Opening the Test pane doesn't run the draft, and testing doesn't replace the published version.

> [!CAUTION]
> Testing executes the edited runbook's activities and can change real resources. Use appropriate test resources, permissions, and input values.

After validation, publish the runbook from its editor in the Azure portal.

### Scheduling and starting a runbook

Link a published runbook to one or more schedules with recurrence settings (one time, hourly, daily, weekly, or monthly) and expiration dates. You can enable or disable individual schedules independently and configure the linked runbook's input parameters and run settings.

You can also start a published runbook on demand. Each invocation creates a separate job, and jobs can run simultaneously or on overlapping schedules.

Supported PowerShell runbooks can also start when you send an HTTP POST request to an Automation *webhook* URL. Create a webhook in the Azure portal or with Azure PowerShell. Webhooks can't start Python runbooks. Check runtime-specific webhook limitations and test input handling before selecting this trigger.

Native Automation webhooks also require local authentication to be enabled on the Automation account. If your account disables it, keep that control in place and use a Microsoft Entra-authenticated Azure Resource Manager job start instead. The runbook's managed identity controls its outbound access, not whether the webhook endpoint accepts the request.

For a supported webhook, an accepted POST means the job was queued. Inspect the job's final state and output separately before treating it as successful.

> [!CAUTION]
> A webhook URL contains a security token. Possession of that URL can be sufficient to invoke the linked runbook without another authentication step. Keep the URL secret, set an appropriate expiration, validate incoming data, and avoid sensitive request data that could be recorded with the job. Use an appropriately authenticated alternative when you need stronger caller validation. The runbook's managed identity authorizes its outbound resource access; it doesn't authenticate the webhook caller.
