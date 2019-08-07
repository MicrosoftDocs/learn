Disaster recovery drills enable you to test your company's ability to recover from a disaster without impacting production services.

After you've produced a BCDR plan, you've been asked to explore the options for how the system can be tested without interrupting live service. You wish to learn more about recovery drills and how they can verify your Site Recovery solution is set up and will work correctly.

In this unit, you'll gain an understanding of recovery time and recovery point objectives. You'll see how you can then use a recovery drill to test that Azure Site Recovery has been configured correctly to meet these objectives.

## Disaster recovery drill

Azure Site Recovery allows you to do a full disaster recovery test without impacting your existing live environment. Recovery plans are created within Site Recovery and allow for the automation of recovery tasks, model-specific applications around its dependencies, such as it needing Active Directory or DNS to function. Recovery plans also allows you to test your disaster recovery.

Once a recovery plan is created on the Azure portal, it can be executed for test purposes. Follow these steps:

- In the **Site Recovery** section of the Azure portal, select **Recovery Plans** > your recovery plan name > **Test Failover**.
- Select the recovery point from the options presented, including options for **Latest processed**, which is the latest recovery point that has been processed by Site Recovery.
- Select the Azure virtual network on which the virtual machine will be created. Use an isolated network from the live environment to prevent any impact to production environments.
- Progress can be tracked in the **Jobs** tab and also in the recovery dashboard.

## Monitoring a test recovery

The Site Recovery dashboard can be used to monitor recovery operations, including recovery drills started under test circumstances. The dashboard is accessed from with the Recovery Services Vault by clicking **Overview**, tabs are then visible to monitor both Site Recovery and Backup operations.

From within the dashboard replicated items and test failovers can be monitored, each replicated item under both categories will be placed into a particular **state** for easy viewing of a healthy item compared to one with issues. See below:

![Site Recovery overview](../media/4-site-recovery-overview.png)

**(1) Backup or Site Recovery** - This enables you to switch between the Back or the Site Recovery dashboards. In the above example, you are on the Site Recovery tab.

**(2) Replicated items** - **Healthy** means that replication is running normally with no warnings. **Warning** means that one or more issues have been identified that could affect replication have been detected. **Critical** means that one or more critical replication errors have been identified.

**(3) Failover test success** - **Test Recommended** means that specific machines have not had a failover since Site Recovery protection was enabled. **Performed successfully** means that one or more machines replicated successfully. **Not applicable** means that machines are not currently eligible for a test failover.

**(4) Configuration issues** - **Missing configurations** means that a necessary setting is missing. **Missing resources** means that a specified resource can't be found or isn't available. For example, a deleted resource such as a virtual network. **Subscription quota** means that available amount of resource available for your subscription and whether there's enough to do a failover. **Software Updates** the availability of new software updates and information about out-of-date software.

**(5) Error Summary** - Any errors will be shown here for easy access, enabling you to quickly identify any issues in your environment.

**(6) Infrastructure view** - Here you will see a visualization of your replication infrastructure and a display of health.

**(7) Recovery Plans** - View recovery plans for your infrastructure.

**(8) Jobs - Last 24 hours** - Easily see the status of any jobs that may be in progress, waiting, or that have failed.
