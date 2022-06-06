As we've explored how Azure Automation works, we'll look at the steps required to create an automation account and an automation runbook

In order to build an automation runbook, you need to first create an automation account. The image below shows this process in the Azure portal, after selecting Azure Automation from the Azure Marketplace.

:::image type="content" source="../media/module-66-automation-final-30.png" alt-text="Screenshot of how to create an Automation Account in the Azure portal.":::

In this example runbook, you're going to connect to an Azure SQL Database using PowerShell. This means you need to import modules to support those *cmdlets*. Before you create your runbook, you'll import modules into your Azure Automation account. In order to do this import, navigate to the Shared Resources section of the main blade for your automation account and select **Modules Gallery**. The first module you'll import, is **Az.Accounts** as the **Az.SQL** module is dependent on it.

:::image type="content" source="../media/module-66-automation-final-19.png" alt-text="Screenshot of the modules gallery search for the Account's module.":::

Search for the module in the gallery as shown in the image above. After you select the module, select **Import**, as shown in the image below.

:::image type="content" source="../media/module-66-automation-final-20.png" alt-text="Screenshot of how to import the module into your account.":::

This will import the module into your account. In this example, the process was repeated for the Az.SQL and SqlServer PowerShell modules.

Next, you can optionally create a credential that your runbook can use. You can create a credential by clicking on **Credentials** in the **Shared Resources** section of the main blade of your automation account as shown in the image below. You don't have to create a credential in order to use Azure Automation, but this example does refer to one.

:::image type="content" source="../media/module-66-automation-final-21.png" alt-text="Screenshot of how to create a credential for Azure Automation.":::

On the **Process Automation** section of your Automation Account, select **Runbooks**, to create a runbook. Your account will come with two sample runbooks.

:::image type="content" source="../media/module-66-automation-final-22.png" alt-text="Screenshot of the runbook creation in Azure portal.":::

To create a runbook, you must provide a name, the type of runbook, the runtime version, and optionally a description. Because this example specified PowerShell as the type, a PowerShell editor opens.

:::image type="content" source="../media/module-66-automation-final-23.png" alt-text="Screenshot of the sample Azure Automation runbook.":::

The image above shows the edit runbook screen, which is where you define the code you're executing. In this example, the runbook is connecting to the Azure subscription, getting information about an Azure SQL Database, running a query, and then returning the results. 

In the lines 1-21, you're executing a series of *cmdlets* to connect to the Azure account. You're then getting the database name from the `Get-AzSQLDatabase` cmdlet, and then using the `get-AutomationPSCredentail` *cmdlet* to assign your credential to a variable.

Finally, you're assigning the `invoke-sqlcmd` *cmdlet* to execute a query against the Azure SQL Database, and using the `write-output` *cmdlet* to return the results of the query.

After you've completed your code in the portal, select **Test pane** in the code editor in the Azure portal. This allows you to test your code in the context of Azure Automation. A typical development process is to create your PowerShell code locally, and then test it within the automation environment. This allows you to separate any PowerShell errors from errors that might be generated from the context of automation execution. Always test your code within automation, to ensure there are no errors in the code itself.

:::image type="content" source="../media/module-66-automation-final-23_1.png" alt-text="Screenshot of a successfully completed test runbook on Azure portal.":::

The image below shows the results of the completed runbook. Note the informational bubble on the left side of the screen referring to hybrid runbooks. Hybrid runbooks are used when you need to execute *cmdlets* inside of a virtual machine. You'll need a configuration on the virtual machines and in the Azure Automation account. This concept can be a bit confusing, but the easiest way to think about it's to think of Azure resources as boxes that are managed by Azure Resource Manager. Without a hybrid runbook you can manage the state of those boxes, but you can't access or manage anything within the boxes. Hybrid runbooks give you the option to control what’s inside of the box.

:::image type="content" source="../media/module-66-automation-final-24.png" alt-text="Screenshot of the results of the completed runbook on Azure portal.":::

After you've successfully tested your runbook, you can then select **Publish** in the runbook editor screen.

A runbook must be published in order to be executed by the Azure service. After you've published the runbook, you can create a schedule by selecting **Schedules** in the **Shared Resources** section of the automation account blade.

:::image type="content" source="../media/module-66-automation-final-25.png" alt-text="Screenshot of the create schedule page in Azure Automation.":::

The image above shows the creation process for a new schedule. The default settings are for there to be no recurrence of the job. In the above example, the job has been configured to run once daily at 4:00 PM Central Time.

Once you've created a schedule, you can link it to a runbook by navigating back to the runbook, and selecting **Link to schedule** in the runbook page as shown in the image below.

:::image type="content" source="../media/module-66-automation-final-26.png" alt-text="Screenshot of how to link a runbook to a schedule in Azure Automation.":::

