Security Center can monitor the security posture of your non-Azure computers, but first, you need to connect them to Azure.

You can connect your non-Azure computers in any of the following ways:

- Using Azure Arc enabled servers (recommended)

- From Security Center's pages in the Azure portal (Getting started and Inventory)

## Add non-Azure machines with Azure Arc

Azure Arc enabled servers is the preferred way of adding your non-Azure machines to Azure Security Center.  A machine with Azure Arc enabled servers becomes an Azure resource and appears in Security Center with recommendations like your other Azure resources.  In addition, Azure Arc enabled servers provides enhanced capabilities such as the option to enable guest configuration policies on the machine, deploy the Log Analytics agent as an extension, simplify deployment with other Azure services, and more.

### What is Azure Arc enabled servers?

Azure Arc enabled servers allows you to manage your Windows and Linux machines hosted outside of Azure, on your corporate network, or other cloud providers consistent with how you manage native Azure virtual machines. When a hybrid machine is connected to Azure, it becomes a connected machine and is treated as a resource in Azure. Each connected machine has a Resource ID, is included in a resource group, and benefits from standard Azure constructs such as Azure Policy and applying tags. Service providers who manage a customer's on-premises infrastructure can manage their hybrid machines, just like they do today with native Azure resources, across multiple customer environments, using Azure Lighthouse with Azure Arc.

To deliver this experience with your hybrid machines hosted outside of Azure, the Azure Connected Machine agent needs to be installed on each machine that you plan on connecting to Azure. **This agent does not deliver any other functionality, and it doesn't replace the Azure Log Analytics agent**. The Log Analytics agent for Windows and Linux is required when you want to proactively monitor the OS and workloads running on the machine, manage it using Automation runbooks or solutions like Update Management, or use other Azure services like Azure Security Center.

## Add non-Azure machines from the Azure portal

You can start the process of adding a non-Azure server from two different locations in Security Center:

1. From Security Center's menu, open the Getting started page.
1. Select the **Get started** tab.
1. Below Add non-Azure servers, select **Configure**.
1. From Security Center's menu, open the Inventory page. 
1. Select the **Add non-Azure servers** button

A list of your Log Analytics workspaces is shown. The list includes, if applicable, the default workspace created for you by Security Center when automatic provisioning was enabled. Select this workspace or another workspace you want to use.

You can add computers to an existing workspace or create a new workspace.  Optionally, to create a new workspace, select **Create new workspace**.

From the list of workspaces, select **Add Servers** for the relevant workspace. The Agents management page appears.

From here, choose the relevant procedure below depending on the type of machines you're onboarding:

- Onboard your Azure Stack VMs

- Onboard your Linux machines

- Onboard your Windows machines

### Onboard your Azure Stack VMs

To add Azure Stack VMs, you need the information on the Agents management page and to configure the Azure Monitor, Update and Configuration Management virtual machine extension on the virtual machines running on your Azure Stack.

1. From the Agents management page, copy the Workspace ID and Primary Key into Notepad.

1. Log into your Azure Stack portal and open the Virtual machines page.

1. Select the virtual machine that you want to protect with Security Center.

1. Select Extensions. The list of virtual machine extensions installed on this virtual machine is shown.

1. Select the **Add** tab. The New Resource menu shows the list of available virtual machine extensions.

1. Select the Azure Monitor, Update and Configuration Management extension and select **Create**. The Install extension configuration page opens.

1. On the Install extension configuration page, paste the Workspace ID and Workspace Key (Primary Key) that you copied into Notepad in the previous step.

1. When you complete the configuration, select **OK**. The extension's status will show as *Provisioning Succeeded*. It might take up to one hour for the virtual machine to appear in Security Center.

### Onboard your Linux machines

To add Linux machines, you need the WGET command from the Agents management page.

1. From the Agents management page, copy the WGET command into Notepad. Save this file to a location that is accessible from your Linux computer.

1. On your Linux computer, open the file with the WGET command. Select the entire content and copy and paste it into a terminal console.

1. When the installation completes, you can validate that the *omsagent* is installed by running the <pgrep> command. The command will return the omsagent PID. The logs for the Agent can be found at: /var/opt/microsoft/omsagent/<workspace id>/log/ It might take up to 30 minutes for the new Linux machine to appear in Security Center.

### Onboard your Windows machines

To add Windows machines, you need to read the information on the Agents management page and to download the appropriate agent file (32/64-bit).

1. Select the Download Windows Agent link applicable to your computer processor type to download the setup file.

1. From the Agents management page, copy the Workspace ID and Primary Key into Notepad.

1. Copy the downloaded setup file to the target computer and run it.

1. Follow the installation wizard (Next, I Agree, Next, Next).

1. On the Azure Log Analytics page, paste the Workspace ID and Workspace Key (Primary Key) that you copied into Notepad.

1. If the computer should report to a Log Analytics workspace in Azure Government cloud, select **Azure US Government** from the Azure Cloud dropdown list.

1. If the computer needs to communicate through a proxy server to the Log Analytics service, select **Advanced** and provide the proxy server's URL and port number.

1. When you've entered all of the configuration settings, select **Next**.

1. From the Ready to Install page, review the settings to be applied and select **Install**.

1. On the Configuration completed successfully page, select Finish.

When complete, the Microsoft Monitoring agent appears in Control Panel. You can review your configuration there and verify that the agent is connected.

