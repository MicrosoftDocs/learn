To manually install the Log Analytics agent:

- Disable auto provisioning.

- Optionally, create a workspace.

- Enable Azure Defender on the workspace on which you're installing the Log Analytics agent:

  - From Security Center's menu, select Pricing & settings.

  - Set the workspace on which you're installing the agent. Make sure the workspace is in the same subscription you use in Security Center, and you have read/write permissions for the workspace.

  - Select Azure Defender on, and Save.

- To deploy agents on new VMs using a Resource Manager template, install the Log Analytics agent:

  - [Install the Log Analytics agent for Windows](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/oms-windows)

  - [Install the Log Analytics agent for Linux](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/oms-linux)

- To deploy agents on your existing VMs, follow the instructions in [Collect data about Azure Virtual Machines](https://docs.microsoft.com/en-us/azure/azure-monitor/learn/quick-collect-azurevm).

- To use PowerShell to deploy the agents, use the instructions from the virtual machines documentation:

  - [For Windows machines](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/oms-windows?toc=/azure/azure-monitor/toc.json)

  - [For Linux machines](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/oms-linux?toc=/azure/azure-monitor/toc.json)

