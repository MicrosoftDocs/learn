In this unit, you'll review Azure Migrate and how to use it to migrate specific workloads to Azure.

## Virtual machine replication
Add Azure Migrate: Server Migration to your Azure Migrate dashboard, which carries over machines and insights from the assessment completed during the Cloud Adoption Framework Plan module. You can begin your replication by clicking Replicate in the tool window. Azure Migrate performs concurrent replication for up to 500 virtual machines (VMs) and can manage up to 200 concurrent migrations. If you need to do more, it’s recommended to create multiple batches. Times for replication will vary based on number and size of virtual machines along with connection speeds between your datacenter and Azure.

During the replication setup phase, you can use the migration settings that your earlier Azure Migrate assessment has suggested in terms of Azure virtual machines sizes or you can specify the settings yourself.  This step gives you the option to configure the VM size and storage disk settings that you feel is appropriate to the workload being migration. 

Also at this stage you are asked to specify which subscription, resource group, and virtual network your VMs will reside in after migration.  You are also able to configure availability options such as Availability Zones or Availability Sets, helping to protect your apps and data from datacenter outages and maintenance events.

Once the replication has been started, you are able to track and monitor the replication of each of your VMs.

:::image type="content" source="../media/6-vm-replication.png" alt-text="Screenshot of the Azure Migrate Servers page in Azure Admin center" border="false":::
_Figure 1: Screenshot of the Azure Migrate Servers page in Azure Admin center_

## Test migrated virtual machines

Once all your targeted virtual machines are replicated and into Azure, before you migrate them into production, you can test your virtual machines to ensure everything works. 
The process runs a prerequisite check, prepares for the test, creates a new test virtual machine, and starts it. This process will take a few minutes.

The test migration functionality within Azure Migrate: Server Migration runs without impacting on-premises machines.  It allows you to test the migration process and perform any app testing, and address any issues before a full migration.

Testing your migration is a great feature that allows you to become comfortable regarding the migration process and understand any tasks that need to be carried out post migration.  You can carry out this test migration as many times as you need in order to refine the process and confirm the steps.

One thing to note is that after the test migration, ensure you clean up the test resources to ensure you don't incur any additional costs.

## Migrating the virtual machines into production

Once you’re ready for the production migration, select **Migrate** from the replicating machines window. 

The process will prompt you to shutdown the machine before migration, which is an optional stage.  If you shutdown the machine Azure Migrate will perform a planned migration with zero data loss (minimum data loss if using agent based replication for the machine).  If you choose not to shutdown the machine, a final sync will be performed before the migration but any changes that happen on the machine after the final sync is started will not be replicated.  Termination of the source machine is an important step. But, you should evaluate which option is best suited to each workload.

Since this step could impact production systems, migration should be completed during off peak business hours to minimize disruption to the business.

:::image type="content" source="../media/6-vm-machines.png" alt-text="Screenshot of the Server migration replicating machines page in Azure Admin center" border="false":::

Now it will run through the production migration process and you can check the status as it validates the pre-requisites, prepares for migration, creates the Azure VM, and starts the Azure VM.

## Release steps

After the migration has taken place, you can release production traffic to the VM by rerouting network traffic to the machine. Before rerouting traffic, you should evaluate the workloads to ensure each has a completed business change plan, technical validation, and business validation.

**Business change plan:** Ensure that the following aspects of the business change plan are properly communicated to avoid business disruption:

- End-user training is completed (or at least planned).
- Any outage windows have been communicated and approved.
- Production data has been synchronized and validated by end users.
- Validate promotion and adoption timing; ensure timelines and changes have been communicated to end users.

**Technical validation:** In additional to the business change plan, you'll want to consider validation of the technical readiness for your workloads. The following are a few suggested tests to complete:

- **Network isolation testing.** Test and monitor network traffic to ensure proper isolation and no unexpected network vulnerabilities. Also validate that any network routing to be severed during cutover is not experiencing unexpected traffic.
- **Dependency testing.** Ensure that all workload application dependencies have been migrated and are accessible from the migrated assets.
- **Business continuity and disaster recovery (BCDR) testing.** Validate that any backup and recovery Service Level Agreements (SLAs) are established. If possible, perform a full recovery of the assets from the BCDR solution. At minimum, you will want to add a backup schedule using Azure Backup. For more advanced SLAs, you may also want to consider replication to a second region using Azure Site Recovery.
- **End-user route testing.** Validate traffic patterns and routing for end-user traffic. Ensure that network performance aligns with expectations.
- **Final performance check.** Ensure that performance testing has been completed and approved by end users. Execute any automated performance testing.
- **Additional technical readiness** Restrict network access for unused services by using network security groups. Deploy Azure Disk Encryption to secure the disks from data theft and unauthorized access.

**Final business validation** After the business change plan and technical readiness have been validated, the following final steps can complete the business validation:

- **Cost validation (plan versus actual).** Testing is likely to produce changes in sizing and architecture. Ensure that actual deployment pricing still aligns with the original plan.
- **Communicate and execute cutover plan.** Prior to cutover, communicate the cutover and execute accordingly.

Complete clean-up tasks for the remaining on-premises servers. Such tasks may include removing the servers from local backups and removing their raw disk files from storage-area network (SAN) storage to free up space. Update documentation related to the migrated servers to reflect their new IP addresses and locations in Azure.

Once the final step in the list above is completed, the VM and supported workload are considered released, completing the final phase or discipline of migration for that workload.
