We can fail over protected resources in three ways. Using the portal, using PowerShell, or automating the failover with an Azure Automation runbook.

With all our resources protected, we'd like to run a real failover of our patient-records VM. With the disaster recovery drill complete, we'll do the failover with PowerShell and the portal. Once completed, we'll be in a better position to recommend which approach our company should use.

In this exercise, we'll complete failover for a VM using PowerShell, and failback the VM using the Azure portal.

## Fail over a VM to a secondary region using PowerShell

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true) with your own credentials.

1. Start a Cloud Shell and switch it to PowerShell.

1. Run the following commands.

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

    The PowerShell commands above:
    - Store the Azure Site Recovery vault in a variable
    - Set the context for the session to your vault
    - Store the protected parent-records from the vault
    - Get a list of all the recovery points
    - Trigger a failover for the latest recovery point
    - Show the result of the failover

1. The failover can take a couple of minutes. While the script is running, leave the cloud shell open and navigate to the _asr-vault_.

1. On the left, under **Monitoring**, select **Site Recovery jobs**.

    > [!NOTE]
    > You can view the progress of the failover job at the same time as the script is running.

1. In the portal, select **Virtual machines** to check that the parent-record VM has been failed over to the east coast region.

1. There are now three VMs, with two named **patient-records**.

## Reprotect the VM using PowerShell

1. Once the failover has completed successfully, we can reprotect the VM.

1. Run the following commands.

    ```powershell
    $RecoveryFabric = Get-AsrFabric -Name "asr-a2a-default-eastus2"
    $RecoveryProtContainer = Get-ASRProtectionContainer -Fabric $RecoveryFabric
    $ProtectionContainerMapping = Get-AzRecoveryServicesAsrProtectionContainerMapping -ProtectionContainer $RecoveryProtContainer -Name eastus2-westus2-24-hour-retention-policy
    $StorageAccount = New-AzStorageAccount -ResourceGroupName "east-coast-rg" -AccountName "reprotectcache" -Location eastus2 -SkuName Standard_GRS
    $ResourceGroup = Get-AzResourceGroup -Name "west-coast-rg"

    $ReprotectJob = Update-AzRecoveryServicesAsrProtectionDirection -AzureToAzure -ProtectionContainerMapping $ProtectionContainerMapping -ReplicationProtectedItem $ReplicationProtectedItem -LogStorageAccountId $StorageAccount.ID -RecoveryResourceGroupId $ResourceGroup.ResourceId
    ```

    The PowerShell commands above:
    - Setup variables that will be used by the Update-AzRecoveryServicesAsrProtectionDirection command
    - A storage account is needed to store the reprotected logs and data. This storage needs to be in the same region as the VM that is being protected
    - The last line starts the reprotect job, and stores a reference to it

## Monitor and test using PowerShell

The job to reprotect the VM can take around approximately 10 minutes to complete.

1. We can monitor the job using this PowerShell command:

    ```powershell
    Get-AzRecoveryServicesAsrJob -Job $ReprotectJob
    ```

1. This command will return the status of the job. The output will look like this example:

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
    > The State is **Succeeded**, and the StateDescription is **Completed**.

## Failback to the West US region using the portal

1. Close the Cloud Shell so that we can use the Azure portal more easily.

1. Select **All resources** in the upper left-hand side of the portal.

1. Select the **Recovery Services vault** by selecting **asr-vault**.

1. Under **Protected items**, select **Replicated items**.

1. Select the **patient-records**.

    We can't failback the VM until the replication has completed, and synchronization is 100% completed. Please note that the synchronization process can take several minutes to complete.

1. Once synchronization completes, select **failover**.

1. Select the latest processed (low RTO) for the Recovery Point.

1. Select **OK** to begin the failback.

## Monitor the failback

1. Select **All resources** in the upper left-hand side of the portal.

1. Select the **Recovery Services vault** by selecting **asr-vault**.

1. Under **Monitoring**, select **Site Recovery jobs**.

1. Select the in progress **Failover** job.
