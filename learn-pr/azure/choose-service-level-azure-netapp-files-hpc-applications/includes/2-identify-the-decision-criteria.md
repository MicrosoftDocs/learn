# Goal

You will examine the key factors that determine Azure NetApp Files performance. You will also learn how to calculate the required bandwidth of your applications.

## Storage Hierarchy

Below is the diagram of Azure NetApp files storage hierarchy showing the relationship between subscriptions, accounts, capacity pools and volumes.

![Diagram of Azure NetApp files storage hierarchy showing the relationship between subscriptions, accounts, capacity pools and volumes.](../media/storagehierarchy.png)

### Azure NetApp account

Azure NetApp Files account is primarily an administrative concept and is in regional scope.

### Capacity Pool

A single Azure NetApp account can have up to 25 Capacity Pools. The provisioned size of each Pool can then be assigned to Volumes within it.

In above example, we provisioned 4 TiB to Capacity Pool 1. This Pool is also assigned a "Premium" service level, which we'll discuss in next section.

Please note that Azure NetApp Files is charged based on the provisioned size of Capacity Pools. Size of Pools can vary from 4 TiB to 500 TiB each.

### Volume

Volumes are the actual constructs that will be mounted from your VM(s) and being consumed. Volume quota can be assigned in range from 100 GB to 100 TB. And the total Volume capacity cannot exceed the size of the Capacity Pool.

In above example, there are two Volumes within Capacity Pool 1 and the total quota limit cannot exceed 4 TiB. All Volumes in a Pool will have the same service level, Premium in this example.

## Service Levels

The first important concept in determining performance with Azure NetApp Files is the Service Level. The service levels define the maximum throughput allowed on a normalized basis relative to volume quota. For example on Premium service level, you can achieve up to 64 MB/s of throughput for every TB of quota in the volume.  

Azure NetApp Files offers three service levels suited to different workload types: Standard, Premium, and Ultra.

![Diagram showing how your performance will be a function of the service level times the volume quota.](../media/servicelevel.png)

## Performance Sizing

Performance for Azure NetApp Files is simple to design and easy to configure. There are 2 key factors involved: the service level, which we just introduced, establishes the baseline level of performance.

The second is the Volume quota.

The gross performance limit of the Volume is the product of these two factors.

![Screenshot of the performance sizing options in the Azure NetApp Files Performance Calculator.](../media/performancesizing.png)

Let's walk through an example:

- If I choose the Premium Tier, I get 64 MB per second for every 1TB of quota within the Volume.

- If I provision a Volume with a 2-TB quota, then that Volume can deliver up to 128MB per second of throughput.  

Note that:

1. The limit of maximum throughput of an Azure NetApp Files Volume is 4,500 MiB/s.

2. The gross throughput is set by the quota of the Volume, not the actual capacity consumed in the Volume.

3. You can resize the Volume quota in anytime, even it is mounted. And changes to QoS will take effect in near real time. You do not need to reboot your VM nor to remount the Volume.

And keep in mind that in real-world, storage performance is impacted by a wide range of factors, including the Read/Write mix, block size mix, and access patterns like random or sequential access.

## Calculate Required Bandwidth

How do you know the needed bandwidth of throughput? If you know both the IOPS and the transfer size of your workload, you can calculate the bandwidth required by multiplying them together.

For example, if your workloads need 100,000 IOPS and have an averaged transfer size of 16KB, then the bandwidth required is 1.53 GB per second.

- 100,000 IOPS * 16 KB = 1,600,000 KB/s = 1.53 GB/s
