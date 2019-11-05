Azure Site Recovery is flexible enough to support many different recovery scenarios. We can choose to failover individual machines or our entire infrastructure with recovery plans. The flexibility allows us to simulate various disasters, like losing only part of our infrastructure. Multiple recovery plans can be defined to allow for all the different kinds of disaster drills you want to run.

With Azure Site Recovery in place, the head of Ops has asked you to test how long it takes to failover all your infrastructure. You've investigated the different options and decided to create a recovery plan so that you can failover all the VMs. With the plan in place, you'll run a test failover, and monitor its progress.

In this exercise, we'll complete the steps needed to run a disaster recovery drill using a recovery plan on the portal.

## Create a recovery plan

1. Sign into the [Azure portal](https://portal.azure.com) with your credentials.

1. On the left of the portal, select **All resources**.

1. From the list of resources, select the Recovery Services vault, **asr-vault**.

1. Under **Manage**, select **Recovery Plans (Site Recovery)**.

1. Select **+ Recovery Plan**.

1. Enter **asr-dr-drill** in the **Name** field on the _Create recovery plan_ pane.

1. Select **West US 2** as the **Source** value.

1. Select **East US 2** as the **Target** value.

1. Select **Resource Manager** as the **Allow items with deployment model**.

    ![Screenshot showing the create recovery plan panes, including the selection screen for virtual machines](../media/6-create-recovery-plan.png)

1. Click on **Select items** and choose your company's two VMs, then select **OK**.

1. Select **OK** at the bottom of the pane.

    > [!NOTE]
    > It can happen that the configuration fails. If the configuration fails, delete the plan and create a new plan.

## Run a test failover using a recovery plan

1. View the details of the recovery plan you created above by selecting **asr-dr-drill**.

    ![Screenshot showing the created disaster recovery plan](../media/6-view-dr-plans.png)

1. On the recovery plan details pane, at the top, select **Test failover**.

    ![Screenshot showing the recovery plan details, highlighting the Test failover button](../media/6-recovery-plan-details.png)

    **Important**: The network configuration failover support for each VM can take several minutes to auto configure as each VM also needs to complete an initial synchronization. Running a failover test may not be available immediately.

1. Select **West US 2** as the **From** region value.

1. Select **East US 2** as the **To** region value.

1. Select **Latest app-consistent** as the **Recovery Point** value.

1. Select **asr-vnet-asr** as the **Azure virtual network** value.

1. Select **OK** to begin the failover.

    ![Screenshot of the test failover options](../media/6-starting-dr-drill.png)


## Monitor failover progress

1. In the navigation slug at the top of the pane, select **asr-vault - Recovery Plans (Site Recovery)**.

    ![Screenshot showing the list of recovery plans created](../media/6-site-recovery-monitoring.png)

1. Under Monitoring, select **Site Recovery jobs**.

    ![Screenshot of the list of Site Recovery jobs](../media/6-dr-drill-job-list.png)

1. Select **Test failover** to view the status of the jobs.

    ![Screenshot of the test failover jobs showing their status](../media/6-dr-drill-results.png)

    We'll use the information on this page to report back to the Ops manager that an Azure failover for our company's current infrastructure will take less than three minutes to complete. These jobs are running in parallel, so it isn't a simple sum of all of them to work out the total the time taken.

1. Once all the jobs have finished successfully, on the far left select **Virtual machines**.

    ![Screenshot showing all the current VMs, the original patient-records, and hr-records. Also the newly created patient-records-test and hr-records-test](../media/6-listing-all-vms.png)

1. Select one of the new test VMs, then on the left under **Settings**, select **Networking**, then select **Topology**.

    ![Screenshot showing the network topology of the new failed over VMs](../media/6-dr-infrastructure.svg)

    > [!NOTE]
    > Both the patient-records and hr-records VMs have been failed over by Azure Site Recovery. The machines are running in their own disaster recovery virtual network.

1. Once we're satisfied with the test results, make sure to capture any notes about the test outcome. We'll now switch back to our **asr-dr-drill** site recovery plan and select the **Cleanup test failover** option to delete the replicated VMs.

    ![text](../media/5-test-success.png)

1. Select the **Testing is complete** checkbox and then select the **OK** button to complete the cleanup process. This step can take up to three minutes to complete.
