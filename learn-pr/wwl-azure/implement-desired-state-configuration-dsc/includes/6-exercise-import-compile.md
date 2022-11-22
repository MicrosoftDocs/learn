After creating your DSC configuration file, you must import it and compile it to the DSC pull server. Compiling will create the MOF file. Read more about it at [Compiling a DSC Configuration with the Azure portal](/azure/automation/automation-dsc-compile#compiling-a-dsc-configuration-with-the-azure-portal).

## Import and compile configurations

To import and compile a configuration, complete the following high-level steps:

1.  Create a configuration file by creating a file on your local machine. Then, copy and paste the following PowerShell code into the file, and name it **LabConfig.ps1**. This script configuration will ensure the IIS web-server role is installed on the servers:
    
    ```powershell
    configuration LabConfig
    {
        Node WebServer
        {
            WindowsFeature IIS
            {
                Ensure = 'Present'
                Name = 'Web-Server'
                IncludeAllSubFeature = $true
            }
        }
    }
    
    ```

2.  In Azure Automation, account under **Configuration Management** &gt; **State configuration (DSC)**, select the **Configurations** tab, and select **+Add**.

    :::image type="content" source="../media/dsc3-4b5adb3a.png" alt-text="Screenshot of Azure Automation pane, highlighting Configuration Management, State Configuration, Configurations tab and the Add button.":::


3.  Point to the configuration file you want to import, and then select **OK**.

    :::image type="content" source="../media/dsc4-46183006.png" alt-text="Screenshot of the Import Configuration pane. In the Import dialog box, the Configuration file is set to LabConfig.ps1.":::


4.  Once imported, double click the file, select **Compile**, and then confirm by selecting **Yes**.

    :::image type="content" source="../media/dsc5-c57caacb.png" alt-text="Screenshot of the LabConfig properties pane with the Compile button selected.":::


5.  Once compiled, verify that the file has a status of completed.

    :::image type="content" source="../media/dsc6-7baaafd1.png" alt-text="Screenshot of the LabConfig properties pane. Under Compilation jobs, a status of completed displays.":::


> [!NOTE]
> If you prefer, you can also use the **PowerShell Start-AzAutomationDscCompilationJob** cmdlet. More information about this method is available at [Compiling a DSC Configuration with Windows PowerShell](/azure/automation/automation-dsc-compile#compiling-a-dsc-configuration-with-windows-powershell).
