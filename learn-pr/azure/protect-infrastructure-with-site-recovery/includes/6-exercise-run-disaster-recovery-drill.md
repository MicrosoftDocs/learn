Think about your organizations BCDR plan, you need to now run a disaster recovery drill on your Azure infrastructure.

In the unit, you'll complete the steps needed for a test disaster recovery drill using the portal.

## Test Failover to a secondary region

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Select **All resources** in the upper left hand side of the portal.
1. Select the **Recovery Services vault** you created earlier.
1. Select **Settings** on the left hand side of the Recovery services blade.
1. Select **Replicated items**.
1. Select the **??** VM you configured for replication earlier and click **Test Failover**.
1. Select the target Virtual Network.
1. Click **OK** to begin the failover.

## Monitor failover progress

1. Select **All resources** in the upper left hand side of the portal.
1. Select the **Recovery Services vault** you created earlier.
1. Select **Settings** on the left hand side of the Recovery services blade.
1. Select **Jobs**.
1. Select **Site Recovery jobs**.
1. List things to look at here.

## Fix failover failures

1. Run through sample failures, list out steps.

In this unit you have run through a test disaster recovery drill for a replicated virtual machine, monitored its progress and fixed the failures.
