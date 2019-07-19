Azure Site Recovery enables your organization to have flexibility, either manually failing over to a secondary Azure region, or to failback to a source machine. By defualt this is a manually supported in the Azure portal. There are options to enable automation if your company wants to automate triggering a failover. These options include technologies like scripting via powershell, or setting up runbooks in Azure Automation to orchestrate failovers. 

You would now like to run through a full failover of a protected VM to a secondary region in your subscription. Once this has completed successfully, you'll then failback that machine.

In this unit, you'll explore failover and failback, how to reprotect a failed over VM, and monitor the status of the reprotection.

## What is failover

![Diagram showing a source region being unavailable, and a new target environment being failed over to](../media/failover.png)

Failover happens when a decision is made to execute a DR plan for your organization. The existing production environment, protected by Azure Site Recovery, is replicated to a different region. The target environment, in effect becomes the defacto production environment, taking the place as the environment your organizations production services run on. At that point the source environment should no longer be used, and you can enforce this by leaving the source VMs stopped.

There is another advantage to shutting down the source VMs. This will result in minimal data loss, as Azure Site Recovery will wait until all the data is written to disk before triggering the failover. To use this data and have the lowest possible RPO, select the **Latest (lowest RPO)** recovery point. 

![Screenshot showing the failover options](../media/failover-options.png)

Once the machines have 

## What is reprotection and why is it important

When a VM is failed over, the protection provided by Azure Site Recovery does not get replicated. To regain the protection and restart the replication, you have to re-enable the protection for each VM. Luckily you already have the infrastructure, in a different region, to use. Your original source environment. Reprotection enables Azure Site Protection to start replicating the target back to the source environment.

The flexibility of failing over single VMs, or failover using a recovery plan, is available to reprotect your infrastructure. So, each VM can be reprotected in isolation, or you can reprotect multiple VMs using a recovery plan.

> [!NOTE]
> Reprotecting takes anywhere between 45 minutes to 2 hours dependant on the size and type of VM. Unlike the other Site Recovery processes that can be montiored by watching the progress of the jobs, reprotection progress has to be viewed at the VM level. This is because the synchronization phase isn't listed as a site recovery job.

![Screenshot showing the status of the patient-records VM, with the percentage synchronized highlighted](../media/reprotection-progress.png)

The above image shows the status of the protected item, with the percentage synchronized highlighted.

## What is failback

Failback is the reverse of a failover. It's where a completed failover to a secondary region has been committed, and is now the production environment. Reprotection has completed for the failed over environment, and subsequently the source environment is now its replica. In a failback scenario, Azure Site Recovery will fail over back to the source VMs.

The process to complete a failback is exactly the same as a failover, even down to reusing the recovery plan. Selecting failover on your recovery plan will now have **from** set to the target region, and the **to** set to the source region.

## Flexible failovers

Azure Site Recovery can run failovers on demand, test failovers are isolated meaning they don't impact production services. This flexibility allows for a failover to be run during a planned outage of a live service, meaning that users of the system wouldn't notice any interruption. The flexibility works the other way too, allowing failback on demand either as part of a planned test, or as part of a fully invoked DR process.

The recovery plans in Azure Site Recovery also allow for the customization and sequencing of failover and failback. Giving you options of how to group machines and workload together.

Flexibility also applies to how you trigger the failover process. Manual failovers are easy to do manually via the Azure portal. Automation is supported by powershell scripting, or using runbooks in Azure Automation.