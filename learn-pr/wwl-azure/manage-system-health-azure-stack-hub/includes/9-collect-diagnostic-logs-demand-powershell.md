**Send logs now** is an option where you manually collect and upload your diagnostic logs from Azure Stack Hub, usually before opening a support case.

There are two ways you can manually send diagnostic logs to Microsoft Support:

 -  Administrator portal (recommended)
 -  PowerShell

If Azure Stack Hub is connected to Azure, we recommend using the administrator portal because it's the simplest way to send the logs directly to Microsoft. If the portal is unavailable, you should instead send logs using PowerShell.

## Send logs now with the administrator portal

To send logs now using the administrator portal:

1.  Open **Help + support &gt; Log Collection &gt; Send logs now**.
2.  Specify the start time and end time for log collection.
3.  Choose the local time zone.
4.  Select **Collect and Upload**.

## Send logs now with PowerShell

If you're using the **Send logs now** method and want to use PowerShell instead of the administrator portal, you can use the `Send-AzureStackDiagnosticLog` cmdlet to collect and send specific logs.

 -  The **FromDate** and **ToDate** parameters can be used to collect logs for a particular time period. If these parameters aren't specified, logs are collected for the past four hours by default.
 -  Use the **FilterByNode** parameter to filter logs by computer name. For example:

```
Send-AzureStackDiagnosticLog -FilterByNode azs-xrp01

```

 -  Use the FilterByLogType parameter to filter logs by type. You can choose to filter by File, Share, or WindowsEvent. For example:

```
Send-AzureStackDiagnosticLog -FilterByLogType File

```

 -  Use the **FilterByResourceProvider** parameter to send diagnostic logs for value-add Resource Providers (RPs). The general syntax is:

```
Send-AzureStackDiagnosticLog -FilterByResourceProvider <<value-add RP name>>

```

**To send diagnostic logs for SQL RP:**

```
Send-AzureStackDiagnosticLog -FilterByResourceProvider SQLAdapter

```

**To send diagnostic logs for MySQL RP:**

```
Send-AzureStackDiagnosticLog -FilterByResourceProvider MySQLAdapter

```

**To send diagnostic logs for IoT Hub:**

```
Send-AzureStackDiagnosticLog -FilterByResourceProvider IotHub

```

**To send diagnostic logs for Event Hubs:**

```
Send-AzureStackDiagnosticLog -FilterByResourceProvider eventhub

```

**To send diagnostic logs for Azure Stack Edge:**

```
Send-AzureStackDiagnosticLog -FilterByResourceProvide databoxedge

```

Use the **FilterByRole** parameter to send diagnostic logs from VirtualMachines and BareMetal roles:

```
Send-AzureStackDiagnosticLog -FilterByRole VirtualMachines,BareMetal

```

**To send diagnostic logs from VirtualMachines and BareMetal roles, with date filtering for log files for the past 8 hours:**

```
Send-AzureStackDiagnosticLog -FilterByRole VirtualMachines,BareMetal -FromDate (Get-Date).AddHours(-8)

```

**To send diagnostic logs from VirtualMachines and BareMetal roles, with date filtering for log files for the time period between 8 hours ago and 2 hours ago:**

```
Send-AzureStackDiagnosticLog -FilterByRole VirtualMachines,BareMetal -FromDate (Get-Date).AddHours(-8) -ToDate (Get-Date).AddHours(-2)

```

### How the data is handled

By initiating diagnostic log collection from Azure Stack Hub, you acknowledge and consent to uploading those logs and retaining them in an Azure storage account managed and controlled by Microsoft. Microsoft Support can access these logs right away with the support case without having to engage with the customer for log collection.
