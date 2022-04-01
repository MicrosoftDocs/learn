Azure Automation runbooks are provided to help eliminate the time it takes to build custom solutions.

The runbooks have already been built by Microsoft and the Microsoft community.

You can use them with or without modification.

Also, you can import runbooks from the runbook gallery at Azure Automation Github in the runbooks repository [Azure Automation - Runbooks](https://github.com/azureautomation/runbooks).

> [!NOTE]
> A new Azure PowerShell module was released in December 2018, called the **Az** PowerShell module. It replaces the **AzureRM** PowerShell module and is now the intended PowerShell module for interacting with Azure. This new **Az** module is currently supported in Azure Automation. For more general details on the new Az PowerShell module, go to [Introducing the new Azure PowerShell Az module](/powershell/azure/new-azureps-module-az).

## Choosing items from the runbook gallery

In the Azure portal, you can import directly from the runbook gallery using the following high-level steps:

1.  Open your Automation account, and then select **Process Automation** &gt; **Runbooks**.
2.  In the runbooks pane, select **Browse gallery**.
3.  From the runbook gallery, locate the runbook item you want, select it, and select **Import**.

When browsing through the runbooks in the repository, you can review the code or visualize the code.

You can also check information such as the source project and a detailed description, ratings, and questions and answers.

For more information, see [Azure Automation](https://github.com/azureautomation).

:::image type="content" source="../media/runbook-gallery-azure-automation-70bd55e6.png" alt-text="Screenshot of Star Azure V2 VMs runbook in the runbook gallery in Azure Automation. Both the Import and View Source Project options are highlighted. A graphical diagram of the runbook also displays.":::


> [!NOTE]
> Python runbooks are also available from the Azure Automation Github in the runbooks repository. To find them, filter by language and select **Python**.

> [!NOTE]
> You can't use PowerShell to import directly from the runbook gallery.
