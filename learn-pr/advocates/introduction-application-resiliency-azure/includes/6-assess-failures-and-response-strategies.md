Generally, you can't test resiliency in the same way that you test application functionality. Instead, you must test how the end-to-end workload performs under failure conditions that only occur intermittently. 

Testing is an iterative process. Test the application, measure the outcome, analyze, and address any failures that result, and repeat the process. 

> [!IMPORTANT]
> Begin fault-injection testing in an isolated, nonproduction environment. Define the expected behavior, affected resources, monitoring, recovery steps, and conditions for stopping the test. Start with a limited scope and expand only after recovery is proven. Production experiments require explicit safeguards and coordination with the workload owners.

**Fault injection testing**. Test the resiliency of the system during failures, either by triggering actual failures or by simulating them. Here are some common failure scenarios to test: 

- Shut down VM instances.
- Crash processes.
- Expire certificates.
- Change access keys.
- Shut down the DNS service on domain controllers.
- Limit available system resources, such as RAM or number of threads.
- Unmount disks.
- Redeploy a VM.

Measure the recovery times and verify that your business requirements are met. Test combinations of failure modes as well. Make sure that failures don't cascade and are handled in an isolated way. 

## Load testing

Load testing is crucial for identifying failures that only happen under load, such as the backend database being overwhelmed or service throttling. Test for peak load, using production data or synthetic data that's as close to production data as possible. The goal is to see how the application behaves under real-world conditions.

## Disaster recovery drills

A disaster recovery plan must be tested periodically. For Azure VMs protected by Azure Site Recovery, use Test failover to create recovery VMs in an isolated, nonproduction virtual network without interrupting ongoing replication or the source VMs. Keep test instances from changing production dependencies. Validate the application and its dependencies, record the recovery results, and run Cleanup test failover afterward.

With the cross-region restore feature provided by Azure Backup, you can conduct business continuity and disaster recovery (BCDR) drills for audit or compliance purposes with the secondary region data. This enables you to restore backed-up data in the secondary region.

> [!NOTE]
> For Azure VM backups, Cross Region Restore requires a geo-redundant Recovery Services vault with Cross Region Restore enabled in a supported region. Recovery is to the paired secondary region. Enable and test this capability before an incident, and account for secondary-region replication delay when evaluating your RPO.
