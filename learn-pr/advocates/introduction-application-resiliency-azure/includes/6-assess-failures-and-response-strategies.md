Generally, you can't test resiliency in the same way that you test application functionality. Instead, you must test how the end-to-end workload performs under failure conditions that only occur intermittently. 

Testing is an iterative process. Test the application, measure the outcome, analyze, and address any failures that result, and repeat the process. 

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

Load testing is crucial for identifying failures that only happen under load, such as the backend database being overwhelmed or service throttling. Test for peak load, using production data or synthetic data that is as close to production data as possible. The goal is to see how the application behaves under real-world conditions.

## Disaster recovery drills

It isn't enough if you have a good disaster recovery plan in place. You need to test it periodically to ensure your recovery plan works fine when it matters. For Azure virtual machines, you can use Azure Site Recovery to replicate and perform disaster recovery drills without impacting production applications or ongoing replication.

With the cross-region restore feature provided by Azure Backup, you can conduct business continuity and disaster recovery (BCDR) drills for audit or compliance purposes with the secondary region data. This enables you to perform a restore of backed up data in the secondary region.
