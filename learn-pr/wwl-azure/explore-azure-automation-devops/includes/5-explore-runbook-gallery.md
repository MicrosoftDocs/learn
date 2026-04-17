**Azure Automation runbooks** are provided to help eliminate the time it takes to build custom solutions. The runbooks have already been built by **Microsoft** and the **Microsoft** community. You can use them with or without modification.

You can also import runbooks from the runbook gallery at **Azure Automation GitHub** in the runbooks repository [Azure Automation - Runbooks](https://github.com/azureautomation/runbooks).

> [!NOTE]
> The **AzureRM PowerShell module** has been officially deprecated as of February 29, 2024. Users are advised to migrate from **AzureRM** to the **Az PowerShell module** to ensure continued support and updates. For more details on the new **Az PowerShell module**, go to [Introducing the new Azure PowerShell Az module](/powershell/azure/new-azureps-module-az).

## Importing from the runbook gallery

In the **Azure portal**, you can import directly from the runbook gallery using the following steps:

1.  Open your **Automation account**, and then select **Process Automation** > **Runbooks**.
2.  In the runbooks pane, select **Browse gallery**.
3.  From the runbook gallery, locate the runbook item you want, select it, and select **Import**.

## Exploring runbook details

When browsing through the runbooks in the repository, you can:

- **Review the code:** View the source code to understand how the runbook works.
- **Visualize the code:** For graphical runbooks, see a visual representation of the workflow.
- **Check information:** View the source project, detailed description, ratings, and questions and answers.

For more information, see [Azure Automation](https://github.com/azureautomation).

:::image type="content" source="../media/runbook-gallery-azure-automation-70bd55e6.png" alt-text="Screenshot of Star Azure V2 VMs runbook in the runbook gallery in Azure Automation. Both the Import and View Source Project options are highlighted. A graphical diagram of the runbook also displays.":::

## Finding Python runbooks

**Python runbooks** are also available from the **Azure Automation GitHub** in the runbooks repository. To find them, filter by language and select **Python**.

> [!NOTE]
> You can't use **PowerShell** to import directly from the runbook gallery. You must use the **Azure portal** for imports.
