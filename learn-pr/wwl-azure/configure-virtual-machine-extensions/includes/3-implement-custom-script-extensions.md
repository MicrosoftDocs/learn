Custom Script Extension(CSE) can be used to automatically launch and execute virtual machine customization tasks post configuration. Your script extension may perform simple tasks such as stopping the virtual machine or installing a software component. However, the script could be more complex and perform a series of tasks.

You can install the CSE from the Azure portal by accessing the virtual machines **Extensions** blade. Once the CSE resource is created, you will provide a PowerShell script file. Your script file will include the PowerShell commands you want to execute on the virtual machine. Optionally, you can pass in arguments, such as param1, param2. After the file is uploaded, it executes immediately. Scripts can be downloaded from Azure storage or GitHub, or provided to the Azure portal at extension run time.

:::image type="content" source="../media/custom-script-extensions-4ddc2c99.png" alt-text="Screenshot of the Install Custom Script extension page is shown. There are two text boxes. The script file information is required. The arguments information is optional.":::


You could also use the PowerShell **Set-AzVmCustomScriptExtension** command. This command requires the URI for the script in the blob container.

```PowerShell
Set-AzVmCustomScriptExtension -FileUri https://scriptstore.blob.core.windows.net/scripts/Install_IIS.ps1 -Run "PowerShell.exe" -VmName vmName -ResourceGroupName resourceGroup -Location "location"

```

## Considerations

 -  **Timeout**. Custom Script extensions have 90 minutes to run. If your deployment exceeds this time, it is marked as a timeout. Keep this in mind when designing your script. Your virtual machine must be running to perform the tasks.
 -  **Dependencies**. If your extension requires networking or storage access, make sure that content is available.
 -  **Failure events**. Be sure to account for any errors that might occur when running your script. For example, running out of disk space, or security and access restrictions. What will the script do if there is an error?
 -  **Sensitive data**. Your extension may need sensitive information such as credentials, storage account names, and storage account access keys. How will you protect/encrypt this information?

> [!NOTE]
> Can you think of any custom script extensions that you might want to create?
