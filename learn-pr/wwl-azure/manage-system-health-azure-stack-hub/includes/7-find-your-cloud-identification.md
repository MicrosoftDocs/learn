This unit covers how to get your Cloud ID by using the Administrator portal or the privileged endpoint (PEP). The Cloud ID is the unique ID for tracking support data uploaded from a specific scale unit. When diagnostic logs are uploaded for support analysis, the Cloud ID is how the logs are associated with that scale unit.

## Use the administrator portal

1.  Open the Administrator portal.
2.  Select **Region management**.
    
    :::image type="content" source="../media/find-cloud-identification-image-1-4036e60c.png" alt-text="Screenshot of the Dashboard":::
    

3.  Select **Properties** and copy the **Stamp Cloud ID**

## Use the privileged endpoint

1.  Open an elevated PowerShell session and run the following script. Replace the IP address of the PEP virtual machine and Cloud Admin credentials as needed for your environment.

```
$ipAddress = "<IP ADDRESS OF THE PEP virtual machine>" # You can also use the machine name instead of IP here.

$password = ConvertTo-SecureString "<CLOUD ADMIN PASSWORD>" -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential ("<DOMAIN NAME>\CloudAdmin", $password)
$session = New-PSSession -ComputerName $ipAddress -ConfigurationName PrivilegedEndpoint -Credential $cred

$stampInfo = Invoke-Command -Session $session { Get-AzureStackStampInformation }
if ($session) {
    Remove-PSSession -Session $session
}

$stampInfo.CloudID

```
