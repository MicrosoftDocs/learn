You can use Windows PowerShell to automate the implementation of Storage Replica.

## Implement Storage Replica by Using Windows PowerShell

Similar to the Windows Admin Center procedure described in the previous unit, before you proceed with the implementation of Storage Replica, validate that all Storage Replica prerequisites are in place:

1. Use the `Test-SRTopology` cmdlet to determine whether the source and destination volumes meet the Storage Replica requirements. You can use the cmdlet in requirements-only mode by specifying the `IgnorePerfTests` parameter first, and if that's successful, rerun the cmdlet in the performance evaluation mode without the `IgnorePerfTests` parameter, as in the following example:

    ```powershell
    Test-SRTopology -SourceComputerName 'SEA-SVR1.contoso.com' -SourceVolumeName S: -SourceLogVolumeName L: -DestinationComputerName 'SEA-SVR2.contoso.com' -DestinationVolumeName S: -DestinationLogVolumeName L: -DurationInMinutes 1 -ResultPath C:\Temp
    } -Authentication Credssp -Credential $cred
    ```

1. Review the results of the test stored in the `C:\temp` folder on SEA-SVR1 and verify that there are no issues that need to be addressed.
1. Use the `New-SRPartnership` cmdlet to create a Storage Replica partnership. Specify the source and destination disks, the source and destination logs, the source and destination cluster names, and optionally, the log size, as in the following example:

    ```powershell
    New-SRPartnership -SourceComputerName 'SEA-SVR1' -SourceRGName 'RG01' -SourceVolumeName S: -SourceLogVolumeName L: -DestinationComputerName 'SEA-SVR2' -DestinationRGName 'RG02' -DestinationVolumeName S: -DestinationLogVolumeName L:
    ```

    > [!NOTE]
    > The default log size is 8 GB. To set it to a different value, use the *LogSizeInBytes* parameter.

1. To track the replication progress on the source server, run the following command, and then examine events **5015**, **5002**, **5004**, **1237**, **5001**, and **2200**:

    ```powershell
    Get-WinEvent -ProviderName Microsoft-Windows-StorageReplica -max 20
    ```

1. On the destination server, run the following command to review the Storage Replica events that depict the creation of the partnership. This event states the number of copied bytes and the corresponding time period:

    ```powershell
    Get-WinEvent -ProviderName Microsoft-Windows-StorageReplica | Where-Object {$_.ID -eq "1215"} | Format-List
    ```

1. Alternatively, you can run the following command on the destination server:

    ```powershell
    (Get-SRGroup).Replicas | Select-Object NumOfBytesRemaining
    ```

1. To track the replication progress on the destination server, run the following command, and then examine events **5009**, **1237**, **5001**, **5015**, **5005**, and **2200**:

    ```powershell
    Get-WinEvent -ProviderName Microsoft-Windows-StorageReplica | FL
    ```

    There should be no warnings or errors. You should receive a large number of **1237** events, which indicate progress.

1. To change direction of replication, run the following command:

    ```powershell
    Set-SRPartnership -NewSourceComputerName  -SourceRGName 'SEA-SVR2' -DestinationComputerName 'SEA-SVR1' -DestinationRGName 'RG02'
    ```

> [!NOTE]
> Storage Replica doesn't allow changing the direction of replication during the initial sync because this can lead to data loss.

## Demonstration

The following video demonstrates how to implement Storage Replica by using Windows PowerShell.

The main steps in the process are:

1. Create an AD DS environment:
    1. Create a single-domain AD DS forest that includes two domain member servers with four data disks each.
    1. Create a management workstation running Windows 10.
1. On each domain member server, initialize the source and destination disks:
    1. Create an ReFS-formatted volume on each disk and assign drive letters to each disk.
    1. On the domain member servers, use **Server Manager** to initialize the source and destination disks.
    1. Create an ReFS-formatted volume on each disk and assign drive letters to each disk.
1. Use **Windows PowerShell** to enable **CredSSP** on the two domain member servers.
1. Use **Windows PowerShell** to configure **Storage Replica** between the two domain member servers.
1. Use **Windows PowerShell** to validate the **Storage Replica** configuration.

 >[!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4MBcw]