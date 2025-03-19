Azure NetApp Files provides two quality of service (QoS) types: manual and automatic. This module provides information about performance optimization and management for both QoS types. 

Throughput limits for Azure NetApp Files can be determined by the combination of the quota assigned to the volume and the selected service level for a volume with automatic QoS. For volumes with manual QoS, the throughput limit can be defined individually. 

## Quota and throughput

Throughput limits are a combination of read and write speed. The performance considerations that contribute to the total performance delivered include read and write mix, the transfer size, random or sequential patterns, and many other factors.

- Metrics are reported as aggregates of multiple data points collected during a five-minute interval.
- The maximum empirical throughput that has been observed in testing is 4,500 MiB/s. At the Premium storage tier, an automatic QoS volume quota of 70.31 TiB provisions a throughput limit high enough to achieve this performance level. 
- For automatic QoS volumes, if you're considering assigning volume quota amounts beyond 70.31 TiB, additional quota may be assigned to a volume for storing more data. However, the added quota doesn't result in a further increase in actual throughput.
- The same empirical throughput ceiling applies to volumes with manual QoS. The maximum throughput can assign to a volume is 4,500 MiB/s.

## Automatic QoS volume quota and throughput 

If a workload’s performance is throughput-limit bound, it's possible to overprovision the automatic QoS volume quota to set a higher throughput level and achieve higher performance.

>[!NOTE]
>If you consistently overprovision a volume for higher throughput, consider using the manual QoS volumes or using a higher service level instead.

You can dynamically increase or decrease volume quota to instantaneously adjust the throughput limit.

- The volume quota can be increased or decreased without any need to pause I/Os.
- You can adjust the quota during an active I/O transaction against a volume. 
- When you change a volume quota, the corresponding adjustment in throughput limit is nearly instantaneous.
- The change does not interrupt or impact the volume access or I/O.
- Adjusting volume quota might require a change in capacity pool size.
- The capacity pool size can be adjusted dynamically and without impacting volume availability or I/O.

## Manual QoS volume quota and throughput

If you use manual QoS volumes, you don’t have to overprovision the volume quota to achieve a higher throughput because the throughput can be assigned to each volume independently. The throughput of a capacity pool is provisioned according to its size and service level. However, you still need to ensure that the capacity pool is pre-provisioned with sufficient throughput for your performance needs. 

## Monitoring volumes for performance

Azure NetApp Files volumes can be monitored using available Performance metrics for volumes. 
When volume throughput reaches its maximum (as determined by the QoS setting), the volume response times (latency) increase. Increasing the volume QoS setting (manual QoS) or increasing the volume size (auto QoS) increases the allowable volume throughput. 

You can monitor the volume throughput by checking if the maximum throughput limit has been reached by monitoring the [throughput limit reached](/azure/azure-netapp-files/azure-netapp-files-metrics#volumes) metric.
