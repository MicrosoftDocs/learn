
Defender for Cloud collects data from your Azure virtual machines (VMs), Virtual Machine Scale Sets, IaaS containers, and non-Azure (including on-premises) machines to monitor for security vulnerabilities and threats. Some Defender plans require monitoring components to collect data from your workloads.

Data collection is required to provide visibility into missing updates, misconfigured OS security settings, endpoint protection status, and health and threat protection. Data collection is only needed for compute resources such as VMs, Virtual Machine Scale Sets, IaaS containers, and non-Azure computers.<br>

You can benefit from Microsoft Defender for Cloud even if you don’t provision agents. However, you'll have limited security and the capabilities listed above aren't supported.<br>

Data is collected using:<br>

 -  Azure Monitor Agent (AMA)<br>
 -  Microsoft Defender for Endpoint (MDE)
 -  Log Analytics agent
 -  Azure Policy Add-on for Kubernetes

## Why use Defender for Cloud to deploy monitoring components?

Visibility into the security of your workloads depends on the data that the monitoring components collect. The components ensure security coverage for all supported resources.

To save you the process of manually installing the extensions, Defender for Cloud reduces management overhead by installing all required extensions on existing and new machines. Defender for Cloud assigns the appropriate Deploy if not exists policy to the workloads in the subscription. This policy type ensures the extension is provisioned on all existing and future resources of that type.

## What plans use monitoring components?

These plans use monitoring components to collect data:

**Defender for Servers**<br>

 -  Azure Arc agent (For multicloud and on-premises servers)
 -  Microsoft Defender for Endpoint
 -  Vulnerability assessment
 -  Azure Monitor Agent or Log Analytics agent

**Defender for SQL servers on machines**

 -  Azure Arc agent (For multicloud and on-premises servers)
 -  Azure Monitor Agent or Log Analytics agent
 -  Automatic SQL server discovery and registration

**Defender for Containers**

 -  Azure Arc agent (For multicloud and on-premises servers)
 -  Defender profile, Azure Policy Extension, Kubernetes audit log data

## Availability of extensions

The Azure Preview Supplemental Terms include additional legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

## Azure Monitor Agent (AMA)

:::image type="content" source="../media/azure-monitor-agent-example-3dab0a98.png" alt-text="Table showing Azure Monitor agent aspects and details.":::


## Log Analytics agent

:::image type="content" source="../media/log-analytics-agent-example-3bd596c5.png" alt-text="Table showing Log Analytics agent aspects and details.":::


## Supported operating systems for the Log Analytics agent

Defender for Cloud depends on the Log Analytics agent. Ensure your machines are running one of the supported operating systems for this agent as described on the following pages:<br>

 -  Log Analytics agent for Windows supported operating systems<br>
 -  Log Analytics agent for Linux supported operating systems

Also ensure your Log Analytics agent is properly configured to send data to Defender for Cloud

## Deploying the Log Analytics agent in cases of a pre-existing agent installation

The following use cases explain how deployment of the Log Analytics agent works in cases when there's already an agent or extension installed.

**Log Analytics agent is installed on the machine, but not as an extension (Direct agent)** \- If the Log Analytics agent is installed directly on the VM (not as an Azure extension), Defender for Cloud will install the Log Analytics agent extension and might upgrade the Log Analytics agent to the latest version. The installed agent will continue to report to its already configured workspaces and to the workspace configured in Defender for Cloud. (Multi-homing is supported on Windows machines.)<br>

If the Log Analytics is configured with a user workspace and not Defender for Cloud's default workspace, you'll need to install the "Security" or "SecurityCenterFree" solution on it for Defender for Cloud to start processing events from VMs and computers reporting to that workspace.<br>

For Linux machines, Agent multi-homing isn't yet supported. If an existing agent installation is detected, the Log Analytics agent won't be deployed.<br>

For existing machines on subscriptions onboarded to Defender for Cloud before 17 March 2019, when an existing agent will be detected, the Log Analytics agent extension won't be installed and the machine won't be affected. For these machines, see to the "Resolve monitoring agent health issues on your machines" recommendation to resolve the agent installation issues on these machines.<br>

**System Center Operations Manager agent is installed on the machine** \- Defender for Cloud will install the Log Analytics agent extension side by side to the existing Operations Manager. The existing Operations Manager agent will continue to report to the Operations Manager server normally. The Operations Manager agent and Log Analytics agent share common run-time libraries, which will be updated to the latest version during this process.<br>

**A pre-existing VM extension is present:**<br>

 -  When the Monitoring Agent is installed as an extension, the extension configuration allows reporting to only a single workspace. Defender for Cloud doesn't override existing connections to user workspaces. Defender for Cloud will store security data from the VM in the workspace already connected, if the "Security" or "SecurityCenterFree" solution has been installed on it. Defender for Cloud may upgrade the extension version to the latest version in this process.<br>
 -  To see to which workspace the existing extension is sending data to, run the test to Validate connectivity with Microsoft Defender for Cloud. Alternatively, you can open Log Analytics workspaces, select a workspace, select the VM, and look at the Log Analytics agent connection.
 -  If you have an environment where the Log Analytics agent is installed on client workstations and reporting to an existing Log Analytics workspace, review the list of operating systems supported by Microsoft Defender for Cloud to make sure your operating system is supported.

## Microsoft Defender for Endpoint

:::image type="content" source="../media/microsoft-defender-for-endpoint-example-8a92a008.png" alt-text="Table showing Microsoft Defender for Endpoint aspects and details.":::


## Vulnerability assessment<br>

:::image type="content" source="../media/vulnerability-assessment-aspect-and-details-af522b67.jpg" alt-text="Table showing vulnerability assessment aspects and details in Defender for Cloud.":::
