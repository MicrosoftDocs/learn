To run `Get-AzureStackLog` on an integrated system, you need to have access to the privileged endpoint (PEP). Here's an example script you can run using the PEP to collect logs. If you are canceling a running log collection to start a new one, wait 5 minutes before starting new log collection and enter `Remove-PSSession -Session $session`.

```
$ipAddress = "<IP ADDRESS OF THE PEP virtual machine>" # You can also use the machine name instead of IP here.

$password = ConvertTo-SecureString "<CLOUD ADMIN PASSWORD>" -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential ("<DOMAIN NAME>\CloudAdmin", $password)

$shareCred = Get-Credential

$session = New-PSSession -ComputerName $ipAddress -ConfigurationName PrivilegedEndpoint -Credential $cred

$fromDate = (Get-Date).AddHours(-8)
$toDate = (Get-Date).AddHours(-2) # Provide the time that includes the period for your issue

Invoke-Command -Session $session { Get-AzureStackLog -OutputSharePath "<EXTERNAL SHARE ADDRESS>" -OutputShareCredential $using:shareCred -FilterByRole Storage -FromDate $using:fromDate -ToDate $using:toDate}

if ($session) {
    Remove-PSSession -Session $session
}

```

### Examples

**Collect all logs for all roles:**

```
Get-AzureStackLog -OutputSharePath "<path>" -OutputShareCredential $cred


```

**Collect logs from VirtualMachines and BareMetal roles:**

```
Get-AzureStackLog -OutputSharePath "<path>" -OutputShareCredential $cred -FilterByRole VirtualMachines,BareMetal

```

**Collect logs from VirtualMachines and BareMetal roles, with date filtering for log files for the past 8 hours:**

```
Get-AzureStackLog -OutputSharePath "<path>" -OutputShareCredential $cred -FilterByRole VirtualMachines,BareMetal -FromDate (Get-Date).AddHours(-8)

```

**Collect logs from VirtualMachines and BareMetal roles, with date filtering for log files for the time period between 8 hours ago and 2 hours ago:**

```
Get-AzureStackLog -OutputSharePath "<path>" -OutputShareCredential $cred -FilterByRole VirtualMachines,BareMetal -FromDate (Get-Date).AddHours(-8) -ToDate (Get-Date).AddHours(-2)

```

**Collect logs from tenant deployments running self-managed Kubernetes clusters (AKS engine) on Azure Stack. Kubernetes logs should be stored in a tenant storage account in a format that will enable the collection time range to be applied to them as well.**

```
Get-AzureStackLog -OutputPath <Path> -InputSasUri "<Blob Service Sas URI>" -FromDate "<Beginning of the time range>" -ToDate "<End of the time range>"

```

For example:

```
Get-AzureStackLog -OutputPath C:\KubernetesLogs -InputSasUri "https://<storageAccountName>.blob.core.windows.net/<ContainerName><SAS token>" -FromDate (Get-Date).AddHours(-8) -ToDate (Get-Date).AddHours(-2)

```

**Collect logs for the value-add RPs. The general syntax is:**

```

```

**To collect logs for SQL RP:**

```
Get-AzureStackLog -FilterByResourceProvider SQLAdapter

```

**To collect logs for MySQL RP**:

```
Get-AzureStackLog -FilterByResourceProvider MySQLAdapter

```

**To collect logs for Event Hubs:**

```
Get-AzureStackLog -FilterByResourceProvider eventhub

```

**Collect logs and store them in the specified Azure Storage blob container. The general syntax for this operation is as follows:**

```
Get-AzureStackLog -OutputSasUri "<Blob service SAS Uri>"

```

For example:

```
Get-AzureStackLog -OutputSasUri

```
