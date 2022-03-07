This unit provides an overview of the issues you may encounter when setting up an Azure Virtual Desktop environment and provides ways to resolve the issues.

## Report issues

To report issues or suggest features for Azure Virtual Desktop with Azure Resource Manager integration, visit the [Azure Virtual Desktop Tech Community](https://techcommunity.microsoft.com/t5/Windows-Virtual-Desktop/bd-p/WindowsVirtualDesktop).

:::image type="content" source="../media/azure-virtual-desktop-tech-community-afcd0e82.png" alt-text="View of the Azure Virtual Desktop technical community site.":::


You can use the Tech Community to discuss best practices or suggest and vote for new features.

When you create a post, describe your issue in as much detail as possible. Detailed information can help other users answer your question or understand the feature you're proposing a vote for.

## Escalation tracks

Before doing anything else, make sure to check the [Azure status page](https://status.azure.com/status) and [Azure Service Health](https://azure.microsoft.com/features/service-health/) to make sure your Azure service is running properly.

Use the following table to identify and resolve issues you may encounter when setting up an environment using Remote Desktop client. Once your environment's set up, you can use our new [Diagnostics service](/azure/virtual-desktop/diagnostics-role-service) to identify issues for common scenarios.

:::row:::
  :::column:::
    **Issue**
  :::column-end:::
  :::column:::
    **Suggested Solution**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Session host pool Azure Virtual Network (VNET) and Express Route settings.
  :::column-end:::
  :::column:::
    [Open an Azure support request](https://azure.microsoft.com/support/create-ticket/), then select the appropriate service (under the Networking category).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Session host pool Virtual Machine (VM) creation when Azure Resource Manager templates provided with Azure Virtual Desktop aren't being used.
  :::column-end:::
  :::column:::
    [Open an Azure support request](https://azure.microsoft.com/support/create-ticket/), then select **Azure Virtual Desktop** for the service.

For issues with the Azure Resource Manager templates that are provided with Azure Virtual Desktop, see Azure Resource Manager template errors section of Host pool creation.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Managing Azure Virtual Desktop session host environment from the Azure portal.
  :::column-end:::
  :::column:::
    [Open an Azure support request](https://azure.microsoft.com/support/create-ticket/).

For management issues when using Remote Desktop Services/Azure Virtual Desktop PowerShell, see Azure Virtual Desktop PowerShell or [open an Azure support request](https://azure.microsoft.com/support/create-ticket/), select **Azure Virtual Desktop** for the service, select **Configuration and management** for the problem type, then select **Issues configuring environment using PowerShell** for the problem subtype.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Managing Azure Virtual Desktop configuration tied to host pools and application groups. (app groups)
  :::column-end:::
  :::column:::
    See Azure Virtual Desktop PowerShell, or [open an Azure support request](https://azure.microsoft.com/support/create-ticket/), select **Azure Virtual Desktop** for the service, then select the appropriate problem type.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Deploying and manage FSLogix Profile Containers.
  :::column-end:::
  :::column:::
    See Troubleshooting guide for FSLogix products and if that doesn't resolve the issue, [Open an Azure support request](https://azure.microsoft.com/support/create-ticket/), select **Azure Virtual Desktop** for the service, select **FSLogix** for the problem type, then select the appropriate problem subtype.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Remote desktop clients malfunction on start
  :::column-end:::
  :::column:::
    See Troubleshoot the Remote Desktop client and if that doesn't resolve the issue, [Open an Azure support request](https://azure.microsoft.com/support/create-ticket/), select **Azure Virtual Desktop** for the service, then select **Remote Desktop clients** for the problem type.

If it's a network issue, your users need to contact their network administrator.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Connected but no feed
  :::column-end:::
  :::column:::
    Troubleshoot using the User connects but nothing is displayed (no feed) section of Azure Virtual Desktop service connections.

If your users have been assigned to an app group, [open an Azure support request](https://azure.microsoft.com/support/create-ticket/), select **Azure Virtual Desktop** for the service, then select **Remote Desktop Clients** for the problem type.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Feed discovery problems due to the network
  :::column-end:::
  :::column:::
    Your users need to contact their network administrator.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Connecting clients
  :::column-end:::
  :::column:::
    See Azure Virtual Desktop service connections and if that doesn't solve your issue, see Session host virtual machine configuration.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Responsiveness of remote applications or desktop
  :::column-end:::
  :::column:::
    If issues are tied to a specific application or product, contact the team responsible for that product.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Licensing messages or errors
  :::column-end:::
  :::column:::
    If issues are tied to a specific application or product, contact the team responsible for that product.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Issues with third-party authentication methods or tools
  :::column-end:::
  :::column:::
    Verify that your third-party provider supports Azure Virtual Desktop scenarios.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Issues using Log Analytics for Azure Virtual Desktop
  :::column-end:::
  :::column:::
    For issues with the diagnostics schema, [open an Azure support request](https://azure.microsoft.com/support/create-ticket/).

For queries, visualization, or other issues in Log Analytics, select the appropriate problem type under Log Analytics.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Issues using Microsoft 365 apps
  :::column-end:::
  :::column:::
    Contact the Microsoft 365 admin center with one of the Microsoft 365 admin center help options.
  :::column-end:::
:::row-end:::
