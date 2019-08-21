Azure Site Recovery enables your organization to have flexibility, either manually failing over to a secondary Azure region, or to failback to a source machine. The simplest way to manage this process is manually on the Azure portal. You do have other options to enable automation, if your company wants to automate triggering a failover. These options include technologies like scripting via powershell, or setting up runbooks in Azure Automation to orchestrate failovers.

You would now like to run through a full failover of a protected VM to a secondary region in your subscription. Once this has completed successfully, you'll then failback that virtual machine.

In this unit, you'll explore failover and failback, how to reprotect a failed over VM, and monitor the status of the reprotection.

## What is failover

![Diagram showing a source region being unavailable, and a new target environment being failed over to](../media/2-failover.png)

Failover happens when a decision is made to execute a DR plan for your organization. The existing production environment, protected by Azure Site Recovery, is replicated to a different region. The target environment, in effect becomes the defacto production environment, taking the place as the environment your organizations production services run on. At that point the source environment should no longer be used, and you can enforce this by leaving the source VMs stopped.

There is another advantage to shutting down the source VMs. This will result in minimal data loss, as Azure Site Recovery will wait until all the data is written to disk before triggering the failover. To use this data and have the lowest possible RPO, select the **Latest (lowest RPO)** recovery point.

![Screenshot showing the failover options](../media/7-failover-options.png)

Once the machines have 

## What is reprotection and why is it important

When a VM is failed over, the replication that was being performed by Azure Site Recovery is no longer happening. To start protecting the failed over VM, you have to re-enable the protection. As you already have the infrastructure, in a different region, you can start replication back to the source region. Reprotection enables Azure Site Recovery to start replicating your new target environment back to the source environment where it came from.

The flexibility of failing over single VMs, or failover using a recovery plan, can be used to reprotect your failed over infrastructure. So, each VM can be reprotected individually, or you can reprotect multiple VMs using a recovery plan.

Reprotecting takes anywhere between 45 minutes to 2 hours dependant on the size and type of VM. Unlike the other Site Recovery processes that can be montiored by watching the progress of the jobs, reprotection progress has to be viewed at the VM level. This is because the synchronization phase isn't listed as a site recovery job.

![Screenshot showing the status of the patient-records VM, with the percentage synchronized highlighted](../media/7-reprotection-progress.png)

The above image shows the status of the protected item, with the percentage synchronized highlighted.

## What is failback

Failback is the reverse of a failover. It's where a completed failover to a secondary region has been committed, and is now the production environment. Reprotection has completed for the failed over environment, and subsequently the source environment is now its replica. In a failback scenario, Azure Site Recovery will fail over back to the source VMs.

The process to complete a failback is exactly the same as a failover, even down to reusing the recovery plan. Selecting failover on your recovery plan will now have **from** set to the target region, and the **to** set to the source region.

## Managing failovers

Azure Site Recovery can run failovers on demand, test failovers are isolated meaning they don't impact production services. This flexibility allows for a failover to be run during a planned outage of a live service, meaning that users of the system wouldn't notice any interruption. The flexibility works the other way too, allowing failback on demand either as part of a planned test, or as part of a fully invoked DR process.

The recovery plans in Azure Site Recovery also allow for the customization and sequencing of failover and failback. Giving you options of how to group machines and workload together.

Flexibility also applies to how you trigger the failover process. Manual failovers are easy to do manually via the Azure portal. Automation is supported by powershell scripting, or using runbooks in Azure Automation.

### Fixing issues with a failover

Even though Azure Site Recovery is automated, errors can still happen. Below is a list of the three most common issues you may see. For a full list of issues and how to troubleshoot them see the link in the summary unit.

#### Azure resource quota issues

Azure Site Recover needs to create resources in different regions. If your subscription isn't able to do this, the replication will fail. This error will also happen if your subscription doesn't have the right quota limits to create VMs that match the size of the source VMs.

The fix is to contact Azure billing support and ask them to enable creating the correct size VMs in the needed target region.

#### One or more disk(s) are available for protection

This error happens if you've been able to set up Azure Site Recovery for your VMs, but after the setup, you have added or initialized additional disks.

To fix this error you can either add replication for the newly added disks, or you can choose to ignore the disk warning.

#### Trusted root certificates

The latest root certificates need to be installed to allow Azure Site Recovery to securely communicate and authenticate VMs for replication. You could see this error if your VMs don't have the latest updates applied. Update Both Windows and Linux VMs before Azure Site Recovery can enable replication.

The fix is different for each OS. Windows is as simple as ensuring automatic Windows update is switched on, and updates have been applied. For each Linux distro, you'll need to follow the guidance provided by its distributor.
