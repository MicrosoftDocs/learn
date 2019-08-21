Azure Site Recovery is flexible enough to support many different recovery scenarios. You can choose to failover individual machines, or your entire infrastructure with recovery plans. The flexibility allows you to simulate different disasters, like loosing only part of your infrastructure. Multiple recovery plans can be defined to allow for all the different kinds of disaster drill you want to run.

With Azure Site Recovery in place, the head of Ops has asked you to test how long it takes to failover all your infrastructure. You've investigated the different options, and decided to create a recovery plan so that you can failover all the VMs. With the plan in place, you'll run a test failover, and monitor its progress.

In this exercise, you'll complete the steps needed to run a disaster recovery drill using a recovery plan on the portal.

## Create a recovery plan

1. Sign into the [Azure portal](https://portal.azure.com) with your own credentials.
1. On the left of the portal, select **All resources**.
1. From the list of resources, select the Recovery Services vault, **asr-vault**.
1. Under **Manage**, select **Recovery Plans (Site Recovery)**.
1. Select **+ Recovery Plan**.
1. On the Create recovery plan pane, in Name, enter **asr-dr-drill**.
1. For **Source**, select **West US 2**.
1. For **Target**, select **East US 2**.
1. For **Allow items with deployment model**, select **Resource Manager**.

    ![Screenshot showing the create recovery plan panes, including the selection screen for virtual machines](../media/6-create-recovery-plan.png)

1. After clicking on **Select items**, choose your companies two VMs, then select **OK**.
1. Select **OK** at the bottom of the pane.

## Run a test failover using a recovery plan

![Screenshot showing the created disaster recovery plan](../media/6-view-dr-plans.png)

1. View the details of the recovery plan you created above by selecting **asr-dr-drill**.

    ![Screenshot showing the recovery plan details, highlighting the Test failover button](../media/6-recovery-plan-details.png)

1. On the recovery plan details pane, at the top, select **Test failover**.

    ![Screenshot of the test failover options](../media/6-starting-dr-drill.png)

1. Select **West US 2** for the **From** region.
1. select **East US 2** for the **To** region.
1. For **Recovery Point**, select **Latest app-consistent**.
1. For **Azure virtual network**, select **asr-vnet-asr**.
1. Select **OK** to begin the failover.

## Monitor failover progress

1. In the navigation slug at the top of the pane, select **asr-vault - Recovery Plans (Site Recovery)**.

    ![Screenshot showing the list of recovery plans that have been created](../media/6-site-recovery-monitoring.png)

1. Under Monitoring, select **Site Recovery jobs**.

    ![Screenshot of the list of Site Recovery jobs](../media/6-dr-drill-job-list.png)


1. Select **Test failover** to view the status of the jobs.

    ![Screenshot of the test failover jobs showing their status](../media/6-dr-drill-results.png)

1. You can use the information on this page to report back to the Ops manager that an Azure failover for your company's current infrastructure will take less than three minutes to complete. These jobs are running in parallel, so it isn't a simple sum of all of them to work out the total the time taken.

1. Once all the jobs have finished successfully, on the far left select **Virtual machines**.

    ![Screenshot showing all the current VMs, the original patient-records, and hr-records. Also the newly created patient-records-test and hr-records-test](../media/6-listing-all-vms.png)

1. Select one of the new test VMs, then on the left under **Settings**, select **Networking**, then select **Topology**.

    ![Screenshot showing the network topology of the new failed over VMs](../media/6-dr-infrastructure.png)

> [!NOTE]
> Both the patient-records and hr-records VMs have been failed over by Azure Site Recovery. The machines are running in their own disaster recovery virtual network.