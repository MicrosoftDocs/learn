Azure Site Recovery enables your organization to have flexibility, either manually failing over to a secondary Azure region, or to failback to a source machine. 

You would now like to run through a full failover of a protected VM to a secondary region in your subscription, once this has completed successfully. You'd like to then failback that machine.

In this unit, you'll explore the key parts of failover and failback, how to reprotect the secondary VM and monitoring the status of any Site Recovery jobs.

## What is failover

Failover is formal process that happens on your infrastructure when a decision is made to execute a DR plan for your organization. The process happens when an existing production environment, protected by ASR, is moved to a replicated environment. This replica environment then, for all intents and purposes, becomes the defacto production environment taking the place as the environment your organizations production services run on.

## What is reprotection and why is it important

When a VM is failed over, the protection provided by ASR does not get replicated. This then requires you to re-enable the protection on the VM. This is super important as firstly the secondary VM is in an unprotected state but secondly, without re-enabling this protection the secondary VM that will become the primary is not replicating. This would automatically stop any potential failback.

It is important to know however that reprotecting a VM takes anywhere between 45 minutes to 2 hours dependant on the size and type of machine.

## What is failback

Failback is the opposite of failover, this process is where a failover has completed to a secondary VM which has now become the prime production environment. The source VM subsequently becomes the replica. In a failback scenario ASR will perform a failover back to the original virtual machine and subsequently change the secondary VM back to the replica.

The process to complete a failback scenario are exactly the same as a failover.

## Flexible failovers

ASR can run failovers on demand, the test failover isolation means no production service is impacted. This flexibility allows for a failover to be run during a planned outage of a live service, meaning that users of the system wouldn't notice any interruption, as they would automatically be switched over to using the replicated environment. The flexibility works the other way too, allowing failback on demand either as part of a planned test or as part of a fully invoked DR scenario.

The recovery plans in ASR also allow for the customization and sequencing of failover and failback of virtual machines and the applications that run on them.

## Monitoring Azure Site Recovery

The ASR dashboard can be used to monitor recovery operations which includes test DR drills. The dashboard is accessed from with the Recovery Services Vault by clicking **Overview**, tabs are then visible to monitor both Site Recovery and Backup operations.

The dashboard allows replicated items and test failovers to be monitored which a distinct state category for both:

- **Backup or Site Recovery**: To alter between the backup and site recovery dashboards.
- **Replicated items**: Displays a health status split into Healthy, Warning or Critical.
- **Failover test success**: Displays a status to show whether tests are Recommended, have been Performed successfully or that a test is Not applicable.
- **Configuration issues**: Displays a status for ASR configurations and pre-requisites of Missing configurations, Missing resources, Subscription quota or Software Updates.
