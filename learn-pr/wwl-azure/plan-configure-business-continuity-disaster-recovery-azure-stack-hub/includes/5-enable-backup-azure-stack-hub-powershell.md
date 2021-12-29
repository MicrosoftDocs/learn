Enable the Infrastructure Backup Service with Windows PowerShell to take periodic backups of:

 -  Internal identity service and root certificate.
 -  User plans, offers, subscriptions.
 -  Compute, storage, and network user quotas.
 -  User Key Vault secrets.
 -  User role-based access control (RBAC) roles and policies.
 -  User storage accounts.

You can access the PowerShell cmdlets to enable backup, start backup, and get backup information via the operator management endpoint.

Provide the backup share, credentials, and encryption key to enable backup.

In the same PowerShell session, edit the following PowerShell script by adding the variables for your environment. Run the updated script to provide the backup share, credentials, and encryption key to the Infrastructure Backup Service.

:::row:::
  :::column:::
    **Variable**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `$username`
  :::column-end:::
  :::column:::
    Type the Username using the domain and username for the shared drive location with sufficient access to read and write files. For example, Contoso\\backupshareuser.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `$password`
  :::column-end:::
  :::column:::
    Type the Password for the user.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `$sharepath`
  :::column-end:::
  :::column:::
    Type the path to the Backup storage location. Use a Universal Naming Convention (UNC) string for the path to a file share hosted on a separate device. A UNC string specifies the location of resources such as shared files or devices. To ensure availability of the backup data, the device should be in a separate location.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `$frequencyInHours`
  :::column-end:::
  :::column:::
    The frequency in hours determines how often backups are created. The default value is 12. Scheduler supports a maximum of 12 and a minimum of 4.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `$retentionPeriodInDays`
  :::column-end:::
  :::column:::
    The retention period in days determines how many days of backups are preserved on the external location. The default value is 7. Scheduler supports a maximum of 14 and a minimum of 2. Backups older than the retention period get automatically deleted from the external location.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `$encryptioncertpath`
  :::column-end:::
  :::column:::
    Parameter is available in Azure Stack Hub Module version 1.7 and later. The encryption certificate path specifies the file path to the .CER file with public key used for data encryption.
  :::column-end:::
:::row-end:::


## Enable backup using certificate

```
# Example username:
  $username = "domain\backupadmin"

  # Example share path:
  $sharepath = "\\serverIP\AzSBackupStore\contoso.com\seattle"

  $password = Read-Host -Prompt ("Password for: " + $username) -AsSecureString

  # Create a self-signed certificate using New-SelfSignedCertificate, export the public key portion and save it locally.

$cert = New-SelfSignedCertificate `
    -DnsName "www.contoso.com" `
    -CertStoreLocation "cert:\LocalMachine\My"

New-Item -Path "C:\" -Name "Certs" -ItemType "Directory"

#make sure to export the PFX format of the certificate with the public and private keys and then delete the certificate from the local certificate store of the machine where you created the certificate

Export-Certificate `
    -Cert $cert `
    -FilePath c:\certs\AzSIBCCert.cer

# Set the backup settings with the name, password, share, and CER certificate file.
  Set-AzsBackupConfiguration -BackupShare $sharepath -Username $username -Password $password -EncryptionCertPath "c:\temp\cert.cer"

```

## Confirm backup settings

In the same PowerShell session, run the following commands:

```
Get-AzsBackupConfiguration | Select-Object -Property Path, UserName

```

The result should look like the following example output:

```
Path                        : \\serverIP\AzsBackupStore\contoso.com\seattle
UserName                    : domain\backupadmin

```

### Update backup settings

In the same PowerShell session, you can update the default values for retention period and frequency for backups.

```
#Set the backup frequency and retention period values.
$frequencyInHours = 10
$retentionPeriodInDays = 5

Set-AzsBackupConfiguration -BackupFrequencyInHours $frequencyInHours -BackupRetentionPeriodInDays $retentionPeriodInDays

Get-AzsBackupConfiguration | Select-Object -Property Path, UserName, AvailableCapacity, BackupFrequencyInHours, BackupRetentionPeriodInDays

```

The result should look like the following example output:

```
Path                        : \\serverIP\AzsBackupStore\contoso.com\seattle
UserName                    : domain\backupadmin
AvailableCapacity          : 60 GB
BackupFrequencyInHours      : 10
BackupRetentionPeriodInDays : 5


```
