You most likely use the Windows 10 GUI interface to change configuration settings and perform management tasks on Windows 10 workstations. However, you might be able to perform some tasks quicker by opening a PowerShell console and running a cmdlet.

The **Microsoft.PowerShell.Management** module includes many built-in cmdlets that can be used to obtain information and perform specific operations on a local computer. To review the cmdlets included in this module, you can enter the following:

```powershell
Get-command -module Microsoft.PowerShell.Management

```

The following table lists some of the more common cmdlets included in the **Microsoft.PowerShell.Management** module.

*Table 1: Cmdlets included in the Microsoft.PowerShell.Management module*

| **Cmdlet**           | **Description**                                                                                            |
| -------------------- | ---------------------------------------------------------------------------------------------------------- |
| **Get-ComputerInfo** | Retrieves all system and operating system properties from the computer                                     |
| **Get-Service**      | Retrieves a list of all services on the computer                                                           |
| **Get-EventLog**     | Retrieves events and event logs from local and remote computers (only available in Windows PowerShell 5.1) |
| **Get-Process**      | Retrieves a list of all active processes on a local or remote computer                                     |
| **Stop-Service**     | Stops one or more running services                                                                         |
| **Stop-Process**     | Stops one or more running processes                                                                        |
| **Stop-Computer**    | Shuts down local and remote computers                                                                      |
| **Clear-EventLog**   | Deletes all of the entries from the specified event logs on the local computer or on remote computers      |
| **Clear-RecycleBin** | Deletes the content of a computer's recycle bin                                                            |
| **Restart-Computer** | Restarts the operating system on local and remote computers                                                |
| **Restart-Service**  | Stops and then starts one or more services                                                                 |

## Running management cmdlets

The following cmdlets are examples of how to use some of the management cmdlets in Windows 10:

 -  To retrieve detailed information about the local computer, run the following command:
    
    ```powershell
    Get-ComputerInfo
    
    ```
 -  To retrieve the latest five error entries from the Application log, run the following command:
    
    ```powershell
    Get-EventLog -LogName Application -Newest 5 -EntryType Error
    
    ```
 -  To clear the Application log on the local computer, run the following command:
    
    ```powershell
    Clear-EventLog -LogName Application
    
    ```
    
    **Additional reading:** For more information on the cmdlets available in the **Microsoft.PowerShell.Management** module, refer to [Microsoft.PowerShell.Management](https://aka.ms/microsoft-powershell-management).
