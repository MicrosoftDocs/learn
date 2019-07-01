Disaster recovery (DR) drills are a crucial process to test your organization's ability to recover from an outage without impacting any production service.

Now you understand more about Azure Site Recovery and its configuration, you need to explore how to run a disaster recovery drill in a safe manner without impacting the production environment. You'd like to learn more about this approach using ASR and run some quality assurance on the configuration to ensure your ASR solution is working correctly.

In this unit, you'll learn about Azure Site Recovery disaster drills, what you need to consider and how to run test processes to ensure your environment has been correctly configured.

## What is a disaster recovery drill

A DR drill is effectively a sanity check to ensure you have configured you solution properly, it's a tried and tested method to ensure that, in the event of a disaster, your solution works correctly and your infrastructure is properly protected. This is crucial to get right to avoid any downtime for live business services. Typically your organization will set a recovery time objective (RTO) which is a timeframe for recovering infrastructure in a disaster or outage scenario. In tandem with this usually comes a recovery point objective (RPO) defining at which point in time the infrastructure is recovered from i.e. hours, minutes or seconds. Both of these will be defined in any BCDR plan and help to ensure minimum downtime for business services.

## Why should you run a DR drill

A DR drill is super important to ensure the solution setup meets the BCDR requirements, not only this but also to ensure the replication works properly. This combined with RTO and RPO need to be tested thoroughly to ensure replication and failover happen in the desired timeframe. For example, if your RTO is set to 1 hour and your RPO set to 30 minutes, as in business operations can continue for 1 hour without major impact and systems backup every 30 minutes, thats 30 minutes of lost time with a recovery of 1 hour. Imagine now your actual recovery time is 2 hours but your backup only completes every hour, that's an extra 30 minutes of data loss and and additional hour of serious business harm which could potentially have grave consequences for your organization.

## Test failover

A test failover allows you to run a DR to test the solution setup. This method enables you to choose a recovery point typically either the last processed, the latest app-consistent point or a custom recovery point (any available). This process is initiated with a single click on **Test Failover** aside the replicated VM in ASR on the Azure portal. The steps proceeding that are as follows:

1. Select the recovery point
1. Choose the target virtual network to which the replicated VMs in the secondary region will be connected
1. Clicking **OK** on the failover dialogue.
1. This will then run a test failover on the replicated VM you chose and allow you to track its progress through site recovery jobs.
1. Once complete the VM failed over will appear in the portal (under Virtual Machines). You can then check the VM is running, is sized and connected as expected mirroring the source VM but in a secondary Azure region.
1. Following this check the VMs replicated can be deleted by selecting **Cleanup test failover**. You can also store notes about the failover at this point.

## Flexible failover

ASR gives you the ability to run a full DR test scenario without touching your production environment. Recovery plans are created within ASR to allow for task automation and modelling of specific applications, such as an AD or DNS requirement. Failovers can be run as many times as you like and allow for a flexible policy to determine what will trigger an automatic failover.

## Difference between a drill and production failover

Running a production failover in ASR is pretty much the same procedure as it is for a drill. There are some exceptions the first being that **Failover** is selected. You can choose to shut down the source VM before starting the failover, this does not stop the failover in the event the shutdown fails. ASR will not clean up the source environment once the failover is complete.

When the failover is completed, monitor through the **jobs** page, validate the VM is working as expected. ASR gives you the ability to change the recovery point at this stage. When you are happy the failover has completed successfully you simply **Commit** the failover, ASR will then delete all source VM recovery points and completes the failover. The new VM in the secondary region will then need to be re-protected.
