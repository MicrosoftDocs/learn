    Using PowerShell:

    - Failover the virtual machine(s) to the secondary region
    - Reprotect the virtual machines
    - Monitor the failover and test connectivity to virtual machines, (Ping, RDC)

    Using the Azure portal:
    - Failback from secondary to primary region
    - Monitor the failback

Think about your organizations BCDR plan, you need to now run a disaster recovery drill on your Azure infrastructure.

In the unit, you'll complete the steps needed for a test disaster recovery drill using the portal.

## Failover a VM to a secondary region using PowerShell

1. List out powershell steps and code.

$RecoveryPoints = Get-ASRRecoveryPoint -ReplicationProtectedItem $ReplicationProtectedItem

"{0} {1}" -f $RecoveryPoints[0].RecoveryPointType, $RecoveryPoints[-1].RecoveryPointTime

$Job_Failover = Start-ASRUnplannedFailoverJob -ReplicationProtectedItem $ReplicationProtectedItem -Direction PrimaryToRecovery -RecoveryPoint $RecoveryPoints[-1]

do {
        $Job_Failover = Get-ASRJob -Job $Job_Failover;
        sleep 30;
} while (($Job_Failover.State -eq "InProgress") -or ($JobFailover.State -eq "NotStarted"))

$Job_Failover.State

$CommitFailoverJOb = Start-ASRCommitFailoverJob -ReplicationProtectedItem $ReplicationProtectedItem

Get-ASRJOb -Job $CommitFailoverJOb

## Reprotect the VM using PowerShell

1. List out powershell steps and code.

$WestUSCacheStorageAccount = New-AzStorageAccount -Name "a2acachestoragewestus" -ResourceGroupName "A2AdemoRG" -Location 'West US' -SkuName Standard_LRS -Kind Storage

Update-AzRecoveryServicesAsrProtectionDirection -ReplicationProtectedItem $ReplicationProtectedItem -AzureToAzure
-ProtectionContainerMapping $RecoveryProtContainer -LogStorageAccountId $WestUSCacheStorageAccount.Id -RecoveryResourceGroupID $sourceVMResourcegroup.Id

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
