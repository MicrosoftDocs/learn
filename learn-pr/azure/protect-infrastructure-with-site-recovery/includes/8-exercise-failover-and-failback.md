You can fail over protected resources in three ways: using the portal, using PowerShell, or automating the failover with an Azure Automation runbook.

With all your resources protected, you can run a real failover of your *patient-records* VM. With the DR drill complete, you'll do the failover with PowerShell and the portal. After completion, you'll be in a better position to recommend which approach your company should use.

In this exercise, you'll complete failover for a VM using PowerShell, and fail back the VM using the Azure portal.

## Fail over a VM to a secondary region using PowerShell

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true) with your own credentials.

1. Start a Cloud Shell and switch it to PowerShell.

1. Run the following commands:

    ```powershell
        $vault = Get-AzRecoveryServicesVault -Name "asr-vault"
        Set-AzRecoveryServicesAsrVaultContext -Vault $vault
        $PrimaryFabric = Get-AsrFabric -Name "asr-a2a-default-westus2"
        $PrimaryProtContainer = Get-ASRProtectionContainer -Fabric $PrimaryFabric
        $ReplicationProtectedItem = Get-ASRReplicationProtectedItem -ProtectionContainer $PrimaryProtContainer -FriendlyName "patient-records"
        $RecoveryPoints = Get-ASRRecoveryPoint -ReplicationProtectedItem $ReplicationProtectedItem
        $Job_Failover = Start-ASRUnplannedFailoverJob -ReplicationProtectedItem $ReplicationProtectedItem -Direction PrimaryToRecovery -RecoveryPoint $RecoveryPoints[-1]

        do {
                $Job_Failover = Get-ASRJob -Job $Job_Failover;
                sleep 30;
        } while (($Job_Failover.State -eq "InProgress") -or ($JobFailover.State -eq "NotStarted"))

        $Job_Failover.State
        $CommitFailoverJob = Start-ASRCommitFailoverJob -ReplicationProtectedItem $ReplicationProtectedItem
        Get-ASRJob -Job $CommitFailoverJob
    ```

    These PowerShell commands:
    - Store the Azure Site Recovery vault in a variable.
    - Set the context for the session to your vault.
    - Store the protected patient records from the vault.
    - Get a list of all the recovery points.
    - Trigger a failover for the latest recovery point.
    - Show the failover result.

1. The failover can take a couple of minutes. While the script is running, leave Cloud Shell open, and go to the **asr-vault**.

1. On the left menu pane, under **Monitoring**, select **Site Recovery jobs**.

    > [!NOTE]
    > You can view the progress of the failover job at the same time as the script is running.

1. When the failover completes, select **Virtual machines** from the Azure home page to check that the *patient-record* VM has been failed over to the east coast region.

1. There are now three VMs, with two named **patient-records**.

## Reprotect the VM using PowerShell

1. After the failover has completed successfully, you can reprotect the VM.

1. Run the following commands:

    ```powershell
    $RecoveryFabric = Get-AsrFabric -Name "asr-a2a-default-eastus2"
    $RecoveryProtContainer = Get-ASRProtectionContainer -Fabric $RecoveryFabric
    $ProtectionContainerMapping = Get-AzRecoveryServicesAsrProtectionContainerMapping -ProtectionContainer $RecoveryProtContainer -Name eastus2-westus2-24-hour-retention-policy
    $StorageAccount = New-AzStorageAccount -ResourceGroupName "east-coast-rg" -AccountName "reprotectcache$(Get-Random)" -Location eastus2 -SkuName Standard_GRS
    $ResourceGroup = Get-AzResourceGroup -Name "west-coast-rg"

    $ReprotectJob = Update-AzRecoveryServicesAsrProtectionDirection -AzureToAzure -ProtectionContainerMapping $ProtectionContainerMapping -ReplicationProtectedItem $ReplicationProtectedItem -LogStorageAccountId $StorageAccount.ID -RecoveryResourceGroupId $ResourceGroup.ResourceId
    ```

    These PowerShell commands:
    - Set up variables that the `Update-AzRecoveryServicesAsrProtectionDirection` command will use.
    - Require a storage account to store the reprotected logs and data. This storage needs to be in the same region as the VM that is being protected.
    - Start the reprotect job using the last line, and store a reference to it.

## Monitor and test using PowerShell

The job to reprotect the VM can take approximately 10 minutes to complete.

1. You can monitor the job running this PowerShell command:

    ```powershell
    Get-AzRecoveryServicesAsrJob -Job $ReprotectJob
    ```

1. This command returns the status of the job. The output looks like this example:

    ```powershell
    Name             : 0993fa3c-6ac1-4d96-920d-df06830d49f2
    ID               : /Subscriptions/3dd370ad-858c-49f0-8f7a-ee6cc0d841de/resourceGroups/east-coast-rg/providers/Microsoft.RecoveryServices/vaults/asr-vault/replicationJobs/0993fa3c-6ac1-4d96
                       -920d-df06830d49f2
    Type             : Microsoft.RecoveryServices/vaults/replicationJobs
    JobType          : SwitchReplicationGroupProtection
    DisplayName      : Reprotect
    ClientRequestId  :
    State            : Succeeded
    StateDescription : Completed
    StartTime        : 7/22/19 10:25:49 AM
    EndTime          : 7/22/19 10:35:07 AM
    TargetObjectId   : 28542035-9d78-58c9-a3ec-0ad29b0a88d8
    TargetObjectType : ProtectionEntity
    TargetObjectName : patient-records
    AllowedActions   :
    Tasks            : {}
    Errors           : {}
    ```

    > [!NOTE]
    > When the reprotection is complete, the State is **Succeeded** and the StateDescription is **Completed**.

## Failback to the West US region using the portal

1. Close Cloud Shell to use the Azure portal more easily.

1. On the home page, select **All resources**.

1. Select **asr-vault**.

1. In the left menu pane, under **Protected items**, select **Replicated items**.

1. Select **patient-records**.

    You can't fail back the VM until the replication has completed, and synchronization is 100% completed. The synchronization process can take several minutes to complete.

1. After synchronization completes, select **Failover**.

1. For the Recovery Point, select **Latest processed (low RTO)**.

1. To begin the failback, select **OK**.

## Monitor the failback

1. On the home page, select **All resources**.

1. Select **asr-vault**.

1. In the left menu pane, under **Monitoring**, select **Site Recovery jobs**.

1. Select the in-progress **Failover** job.
