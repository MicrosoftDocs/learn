PowerShell is designed for managing and administering resources from the command line. You can use PowerShell when you want to build automated tools that use the Azure Resource Manager model. A PowerShell module can be defined as a set of PowerShell functions that are grouped to manage all aspects of a particular area. To work with Azure Stack Hub, you need to juggle various sets of PowerShell cmdlets.

This unit helps you orient yourself to the variety of PowerShell modules that are used in Azure Stack Hub. When you use PowerShell in Azure Stack Hub, you can interact with any of four sets of APIs, as shown in the following table:

:::row:::
  :::column:::
    **API**
  :::column-end:::
  :::column:::
    **PowerShell reference**
  :::column-end:::
  :::column:::
    **REST reference**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Global Azure Resource Manager
  :::column-end:::
  :::column:::
    [Azure PowerShell modules](https://docs.microsoft.com/powershell/azure/new-azureps-module-az?view=azps-7.0.0&amp;preserve-view=true).
  :::column-end:::
  :::column:::
    REST API browser.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Stack Hub Resource Manager
  :::column-end:::
  :::column:::
    Manage API version profiles in Azure Stack Hub.
  :::column-end:::
  :::column:::
    [Manage API version profiles in Azure Stack Hub](https://docs.microsoft.com/azure-stack/user/azure-stack-version-profiles?view=azs-2008&amp;preserve-view=true).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Stack Hub administrator endpoints
  :::column-end:::
  :::column:::
    Azure Stack Hub admin module.
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Stack Hub privileged endpoint
  :::column-end:::
  :::column:::
    [Use the privileged endpoint in Azure Stack Hub](https://docs.microsoft.com/azure-stack/operator/azure-stack-privileged-endpoint?view=azs-2008&amp;preserve-view=true).
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::


Each interface contacts resource providers in global Azure or Azure Stack Hub. Resource providers enable Azure capabilities. For example, the Azure Compute resource provider gives you programmatic access to the creation and management of virtual machines and their supporting resources.

Resource providers provide both functionality and controls for managing and configuring the resource. You can programmatically access the resource providers by using Azure Resource Manager. In turn, the interface provides a surface for PowerShell, the Azure CLI, and your own REST clients.
