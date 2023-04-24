
Azure Update Management is a service included as part of your Azure subscription. With Update Management, you can assess your update status across your environment and manage your Windows Server and Linux server updates from a single location—for both your on-premises and Azure environments.

Update Management is available at no additional cost (you pay only for the log data that Azure Log Analytics stores), and you can easily enable it for Azure and on-premises VMs. To try it, navigate to your **VM** tab in Azure, and then enable Update Management for one or more of your VMs. You can also enable Update Management for VMs directly from your Azure Automation account. Making updates easy, is one of the key factors in maintaining good security hygiene.

## Azure Update Management overview

Computers that Update Management manages use the following configurations to perform assessment and update deployments:

 -  Microsoft Monitoring Agent (MMA) for Windows or Linux
 -  Desired State Configuration (DSC) in Windows PowerShell for Linux
 -  Hybrid Runbook Worker in Azure Automation
 -  Microsoft Update or Windows Server Update Services (WSUS) for Windows computers

Azure Automation uses runbooks to install updates. You can't view these runbooks, and they don’t require any configuration. When an update deployment is created, it creates a schedule that starts a master update runbook at the specified time for the included computers. The master runbook starts a child runbook on each agent to install the required updates.

The following diagram is a conceptual depiction of the behavior and data flow together with how the solution assesses and applies security updates to all connected Windows Server and Linux computers in a workspace.

:::image type="content" source="../media/az500-update-steps-00698ad0.png" alt-text="Update management steps outlined in the text.":::


## Manage updates for multiple machines

You can use the Update Management solution to manage updates and patches for your Windows and Linux virtual machines. From your Azure Automation account, you can:

 -  Onboard virtual machines
 -  Assess the status of available updates
 -  Schedule installation of required updates
 -  Review deployment results to verify that updates were applied successfully to all virtual machines for which Update Management is enabled

The Log Analytics agent for Windows and Linux needs to be installed on the VMs that are running on your corporate network or other cloud environment in order to enable them with Update Management.

After you enable Update Management for your machines, you can view machine information by selecting **Computers**. You can view information about machine name, compliance status, environment, OS type, critical and security updates installed, other updates installed, and update agent readiness for your computers.

:::image type="content" source="../media/az500-update-management-9c66cbfb.png" alt-text="Screenshot of the update management page.":::


Computers that have recently been enabled for Update Management might not have been assessed yet. The compliance state status for those computers is **Not assessed**.

## Update inclusion

Azure Update Management provides the ability to deploy patches based on classifications. However, there are scenarios where you may want to explicitly list the exact set of patches. Common scenarios include allowing specific patches after canary environment testing and zero-day patch rollouts.

With update inclusion lists you can choose exactly which patches you want to deploy instead of relying on patch classifications.
