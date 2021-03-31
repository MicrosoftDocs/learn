# Goal

Recall that in the EDA simulation scenario. After identified the throughput or IOPS requirements of the application, we can then decide the most optimal and cost-effective Azure NetApp Files service level. We will use Azure NetApp Files Performance Calculator to achieve this goal.

## Performance Considerations

As you have learned in previous module that, the throughput limit for a volume is determined by a combination of the service level and the volume quota.

Recall the limit of maximum throughput of an Azure NetApp Files Volume is 4,500 MiB/s. At the Premium service level, a Volume quota of 70.31 TiB will provision a throughput limit that is high enough to achieve this level of performance.

- 64MiB/s * 70.31 = 4,500 MiB/s

That is, if we assign more than 70.31 TiB, extra quota will only be assigned for storing more data, but not result in a further increase in actual throughput.

Most importantly, we will also need to consider the cost structure of different service levels.

### Azure NetApp Files Performance Calculator

[Azure NetApp Files Performance Calculator](https://cloud.netapp.com/azure-netapp-files/tco?hs_preview=tIKQbfoF-41214739590) can be used to specify your throughput or IOPS requirements to help you choose the most cost-effective service level.

## Throughput requirement example

An HPC application needs at least 25 TiB size of volume storage, and need to ensure 1,500 MiB/s in throughput on 8 KiB random with 70/30 read/write.

The output of the Performance Calculator will like:

![Screenshot of the Azure NetApp Files Performance Calculator when specifying 1,500 MiB/s throughput requirement as requirement.](../media/throughputrequirement.png)

That is, in this example, Premium service will be the best choice as it achieves throughput requirements with lowest Capacity Pool cost.

## IOPS requirement example

Another HPC application needs at least 50 TiB size of volume storage, and require at least 140,000 IOPS on 8 KiB random with 70/30 read/write.

The output of the Performance Calculator will like:

![Screenshot of the Azure NetApp Files Performance Calculator when specifying 140,000 IOPS requirement as requirement.](../media/iopsrequirement.png)

In this case, Standard will be the best choice as it achieves that specific IOPS requirements and is also the most cost-effective.
