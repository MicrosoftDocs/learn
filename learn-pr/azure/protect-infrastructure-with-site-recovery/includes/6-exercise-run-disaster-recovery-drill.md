Azure Site Recovery is flexible enough to support many different recovery scenarios. You can choose to failover individual machines or our entire infrastructure with recovery plans. The flexibility enables you to simulate various disasters, like losing only part of your infrastructure. Multiple recovery plans can be defined to allow for all the different kinds of disaster drills you want to run.

With Site Recovery in place, the head of Ops has asked you to test how long it takes to fail over all your infrastructure. You've investigated the different options, and decided to create a recovery plan so that you can fail over all the VMs. With the plan in place, you'll run a test failover, and monitor its progress.

In this exercise, you'll complete the steps needed to run a DR drill using a recovery plan on the portal.

> [!NOTE]
> For Azure Site Recovery to efficiently function, a minimum memory of 1 GB is required on each VM.

## Create a recovery plan

1. Sign in to the [Azure portal](https://portal.azure.com) with your credentials.

1. On the home page, select **All resources**.

1. From the list of resources, select the Recovery Services vault named *asr-vault*.

1. On the left menu pane, under **Manage**, select **Recovery Plans (Site Recovery)**.

1. In the top menu bar, select **Recovery plan**. The **Create recovery plan** pane appears.

1. Enter the following values for each setting:

    | Setting | Value |
    |---|---|
    | Name | asr-dr-drill |
    | Source | West US 2 |
    | Target | East US 2 |

1. Select the **Select items** link. The **Select items** pane appears.

1. Select your company's two VMs, and then select **OK**. The **Create recovery plan** reappears.

    :::image type="content" source="../media/6-create-recovery-plan.png" alt-text="Screenshot showing the create recovery plan panes, including the selection screen for virtual machines." lightbox="../media/6-create-recovery-plan.png":::

1. Select **Create**. The **Recovery Plans (Site Recovery)** pane reappears.

    > [!NOTE]
    > It can happen that the configuration fails. If the configuration fails, delete the plan and create a new plan.

## Run a test failover using a recovery plan

1. View the details of the recovery plan you previously created by selecting **asr-dr-drill**.

    :::image type="content" source="../media/6-view-dr-plans.png" alt-text="Screenshot showing the created disaster recovery plan." lightbox="../media/6-view-dr-plans.png":::

    The **Recovery Services vault** pane named *asr-dr-drill* appears.

1. In the top menu bar, select **Test failover**.

    :::image type="content" source="../media/6-recovery-plan-details.png" alt-text="Screenshot showing the recovery plan details, highlighting the Test failover button." lightbox="../media/6-recovery-plan-details.png":::

    The **Test failover** pane appears.

1. Enter the following values for each setting:

    > [!IMPORTANT]
    > The network configuration failover support for each VM can take several minutes to auto-configure as each VM also needs to complete an initial synchronization. Running a failover test may not be available immediately.

    For **Failover direction**:

    | Setting | Value |
    |---|---|
    | From | West US 2 |
    | To*| East US 2 |

    For **Recovery Point**:

    | Setting | Value |
    |---|---|
    | Choose a recovery point | From the dropdown list, select **Latest app-consistent** |
    | Azure virtual network | From the dropdown list, select **asr-vnet-asr**. |

1. To begin the failover, select **OK**.

    :::image type="content" source="../media/6-starting-dr-drill.png" alt-text="Screenshot of the test failover options." lightbox="../media/6-starting-dr-drill.png":::

    The **Recovery Plans (Site Recovery)** pane for the **Recovery Services vault** named *asr-vault* reappears.

## Monitor failover progress

1. In the left menu pane, under **Monitoring**, select **Site Recovery jobs**.

    :::image type="content" source="../media/6-site-recovery-monitoring.png" alt-text="Screenshot showing the list of recovery plans created." lightbox="../media/6-site-recovery-monitoring.png":::

1. From the list, select **Test failover**.

    :::image type="content" source="../media/6-dr-drill-job-list.png" alt-text="Screenshot of the list of Site Recovery jobs." lightbox="../media/6-dr-drill-job-list.png":::

1. The **Test failover** pane appears where you can view the status of the jobs.

    :::image type="content" source="../media/6-dr-drill-results.png" alt-text="Screenshot of the test failover jobs showing their status." lightbox="../media/6-dr-drill-results.png":::

    You'll use the information on this pane to report back to the Ops manager that an Azure failover for your company's current infrastructure will take less than three minutes to complete. These jobs are running in parallel (rather than a simple sum of all of jobs), to work out the total of time taken.

1. After all the jobs have completed successfully, on the far left, select **Virtual machines**.

    :::image type="content" source="../media/6-listing-all-vms.png" alt-text="Screenshot showing all the current VMs, the original patient-records, and hr-records. Also the newly created patient-records-test and hr-records-test." lightbox="../media/6-listing-all-vms.png":::

1. Select one of the new test VMs.

1. In the left menu pane, under **Settings**, select **Networking**, and then select **Topology**.

    :::image type="content" source="../media/6-dr-infrastructure.svg" alt-text="Screenshot showing the network topology of the new failed over VMs." lightbox="../media/6-dr-infrastructure.svg":::

    > [!NOTE]
    > Both the patient-records and hr-records VMs have been failed over by Site Recovery. The VMs are running in their own disaster recovery virtual network.

1. After you're satisfied with the test results, make sure to capture any notes about the test outcome. You'll now switch back to your **asr-dr-drill** site recovery plan, and in the top menu bar, select **Cleanup test failover** to delete the replicated VMs.

    :::image type="content" source="../media/5-test-success.png" alt-text="Screenshot showing text." lightbox="../media/5-test-success.png":::

1. To complete the cleanup process, select the **Testing is complete** checkbox, and then select **OK**. This step can take up to three minutes to complete.
