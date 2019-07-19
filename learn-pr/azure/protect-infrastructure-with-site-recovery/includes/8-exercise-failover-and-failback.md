TODO

TODO

In this exercise, you'll complete a failover and failback of a single Azure VM using powershell and the Azure portal.

## Failover a VM to a secondary region using PowerShell

1. Sign into the [Azure portal](https://portal.azure.com) with your own credentials.
1. Start a Cloud Shell and switch it to PowerShell.
1. Run the following commands.
    ```powershell
        $vault = Get-AzRecoveryServicesVault -Name "lamna-vault"
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
        $CommitFailoverJOb = Start-ASRCommitFailoverJob -ReplicationProtectedItem $ReplicationProtectedItem
        Get-ASRJOb -Job $CommitFailoverJOb
    ```
1. The PowerShell commands above:
    - Store the Azure Site Recovery vault in a variable
    - Set the context for the session to your vault
    - Store the protected parent-records from the vault
    - Get a list of all the recovery points
    - Trigger a failover for the latest recovery point
    - Show the result of the failover
1. The failover can take a couple of minutes, while the script is running, leave the cloud shell open, but navigate to the lamna-vault.
1. On the left, under Monitoring, select **Site Recovery jobs**.

    > [!NOTE]
    > You can view the progress of the failover job at the same time as the script is running.

1. To check that the parent-record VM has been failed over to the east coast region, in the portal select **Virtual machines**.
1. Note that there are now three VMs, with two named **patient-records**.
    
## Reprotect the VM using PowerShell

1. List out powershell steps and code.

$WestUSCacheStorageAccount = Get-AzStorageAccount -Name "asrcache7311" -ResourceGroupName "west-coast-datacenter"
        $RecoveryFabric = Get-AsrFabric -Name "asr-a2a-default-eastus2"
        $RecoveryProtContainer = Get-ASRProtectionContainer -Fabric $RecoveryFabric

Update-AzRecoveryServicesAsrProtectionDirection -ReplicationProtectedItem $ReplicationProtectedItem -AzureToAzure -ProtectionContainerMapping $RecoveryProtContainer -LogStorageAccountId $WestUSCacheStorageAccount.Id -RecoveryResourceGroupID $sourceVMResourcegroup.Id

## Monitor and test using PowerShell

1. List out powershell steps and code.

$Job_Failover.State

$CommitFailoverJOb = Start-ASRCommitFailoverJob -ReplicationProtectedItem $ReplicationProtectedItem

Get-ASRJOb -Job $CommitFailoverJOb

## Failback using the portal

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Select **All resources** in the upper left hand side of the portal.
1. Select the **Recovery Services vault** you created earlier.
1. Select **Settings** on the left hand side of the Recovery services blade.
1. Select **Replicated items**.
1. Select the **??** VM you configured for replication earlier and click **Test Failover**.
1. Select the **??** recovery point, in the failover menu.
1. Click **OK** to begin the failover.

## Monitor the failback

1. Select **All resources** in the upper left hand side of the portal.
1. Select the **Recovery Services vault** you created earlier.
1. Select **Settings** on the left hand side of the Recovery services blade.
1. Select **Jobs**.
1. Select **Site Recovery jobs**.
1. List things to look at here.
1. Check VM is working by logging in, run through steps.
1. **Commit the failover**

In this unit you have run through a failback scenario both in the portal and using powershell for a replicated virtual machine, monitored its progress and then committed the failback.
