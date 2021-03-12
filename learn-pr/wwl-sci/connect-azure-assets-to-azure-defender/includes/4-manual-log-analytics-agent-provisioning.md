To manually install the Log Analytics agent:

1. Disable auto provisioning.

1. Optionally, create a workspace.

1. Enable Azure Defender on the workspace on which you're installing the Log Analytics agent:

1. From Security Center's menu, select **Pricing & settings**.

1. Set the workspace on which you're installing the agent. Make sure the workspace is in the same subscription you use in Security Center, and you have read/write permissions for the workspace.

1. Select **Azure Defender on**, and **Save**.

- To deploy agents on new VMs using a Resource Manager template, install the Log Analytics agent:

  - [Install the Log Analytics agent for Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/oms-windows?azure-portal=true)

  - [Install the Log Analytics agent for Linux](https://docs.microsoft.com/azure/virtual-machines/extensions/oms-linux?azure-portal=true)

- To deploy agents on your existing VMs, follow the instructions in [Collect data about Azure Virtual Machines](https://docs.microsoft.com/azure/azure-monitor/learn/quick-collect-azurevm?azure-portal=true).

- To use PowerShell to deploy the agents, use the instructions from the virtual machines documentation:

  - [For Windows machines](https://docs.microsoft.com/azure/virtual-machines/extensions/oms-windows?toc=/azure/azure-monitor/toc.json?azure-portal=true)

  - [For Linux machines](https://docs.microsoft.com/azure/virtual-machines/extensions/oms-linux?toc=/azure/azure-monitor/toc.json?azure-portal=true)

