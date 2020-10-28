In order to build an automation runbook, you need to first create an automation account. The image below shows this process in the Azure portal, after selecting Azure Automation from the Azure Marketplace.

:::image type="content" source="../media/module-66-automation-final-18.png" alt-text="Creating an Automation Account in the Azure portal":::

Note that this process can optionally create an Azure Run As account, which creates a service principal in your Azure Active Directory. This service principal provides authentication for Azure Automation to access Azure Resources.

In this example runbook, you are going to connect to an Azure SQL Database using PowerShell. This means you need to import modules to support those cmdlets. Before you create your runbook, you will import modules into your Azure Automation account. In order to do this import, navigate to the Shared Resources section of the main blade for your automation account and click Modules Gallery. The first module you will import, is **Az.Accounts** as the **Az.SQL** module is dependent on it.

:::image type="content" source="../media/module-66-automation-final-19.png" alt-text="Modules Gallery Search for Az.Accounts Module":::

You will search for the module in the gallery, and search for the module you are looking for as shown in the image above. After you click on the module, you will have the option to import it, as shown in the image below.

:::image type="content" source="../media/module-66-automation-final-20.png" alt-text="automation":::

This will import the module into your account. In this example, the process was repeated for the Az.SQL and SqlServer PowerShell modules.

Next, you can optionally create a credential that your runbook can utilize. You can create a credential by clicking on Credentials in the Shared Resources section of the main blade of your automation account as shown in the image below. You do not have to create a credential in order to use Azure Automation, but this example does refer to one.

:::image type="content" source="../media/module-66-automation-final-21.png" alt-text="Create Credential in Azure Automation":::

Next, you will create a runbook after navigating to the Process Automation section of the automation blade and clicking Runbooks. Your account will come with three sample runbooks (one for each type of runbook).

:::image type="content" source="../media/module-66-automation-final-22.png" alt-text="Runbook Creation in Azure portal":::

When you are creating the runbook, you provide a name, the type of runbook, and optionally a description. Because this example specified PowerShell as the type, a PowerShell editor opens.

:::image type="content" source="../media/module-66-automation-final-23.png" alt-text="Sample Azure Automation Runbook":::

The image above shows the edit runbook screen, which is where you define the code you are executing. In this example, the runbook is connecting to the Azure subscription, getting information about an Azure SQL Database, running a query, and then returning the results. In this example, in lines 1-21, you are executing a series of cmdlets to connect to the Azure account. You are then getting the database name from the `Get-AzSQLDatabase` cmdlet, and then use the `get-AutomationPSCredentail` cmdlet to assign your credential to a variable. Finally, you are assigning the `invoke-sqlcmd` cmdlet to execute a query against the Azure SQL Database, and using the `write-output` cmdlet to return the results of the query.

After you have completed your code in the portal, you click on "Test Pane" in the code editor in the Azure portal. This allows you to test your code in the context of Azure Automation. A typical development process is to create your PowerShell code locally and then test it within the automation environment. This allows you to separate any PowerShell errors from errors that might be generated from the context of automation execution. Always test your code within automation, to ensure there are no errors in the code itself.

:::image type="content" source="../media/module-66-automation-final-24.png" alt-text="Successfully Completed Test Runbook":::

The image above shows the results of the completed runbook. Note the informational bubble on the left side of the screen referring to hybrid runbooks. Hybrid runbooks are used when you need to execute cmdlets inside of a virtual machine. You'll need a configuration on the virtual machines and in the Azure Automation account. This concept can be a bit confusing, but the easiest way to think about it is to think of Azure resources as boxes that are managed by Azure Resource Manager. Without a hybrid runbook you can manage the state of those boxes, but you cannot access or manage anything within the boxes. Hybrid runbooks give you the option to control what’s inside of the box.

After you have successfully tested your runbook, you can then click publish in the runbook editor screen. A runbook must be published in order to be executed by the service. After you have published the runbook, you can create a schedule, by clicking on schedules in the Shared Resources section of the automation account blade.

:::image type="content" source="../media/module-66-automation-final-25.png" alt-text="Create Schedule Screen in Azure Automation":::

The image above shows the creation process for a new schedule. The default settings are for there to be no recurrence of the job. In the above example, the job has been configured to run once daily at 4:30 PM Eastern Time. Once you have created a schedule, you can link it to a runbook, by navigating back to the runbook and clicking Link to schedule in the runbook page as shown in the image below.

:::image type="content" source="../media/module-66-automation-final-26.png" alt-text="Link to Schedule in Azure Automation Runbook":::

## Configuration management

Azure Automation also supports using PowerShell Desired State Configuration (DSC) to manage changes in configuration across VMs in your environment. DSC operates as an extension to VMs and provides a consistent configuration state across all of the VMs that the configuration is applied to. Azure Automation integrates with DSC, allowing you to automatically update configuration across physical and virtual machines, and includes reporting capabilities.
