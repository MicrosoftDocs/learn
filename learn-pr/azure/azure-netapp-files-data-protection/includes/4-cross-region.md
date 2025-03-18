The Azure NetApp Files replication functionality provides data protection through cross-region volume replication. You can asynchronously replicate data from an Azure NetApp Files volume (source) in one region to another Azure NetApp Files volume (destination) in another region. 

## Service-level objectives 

Azure NetApp Files cross-region replication enables you to fail over your critical application if a region-wide outage or disaster happens.  

The two main considerations are recovery point object (RPO) and recovery time objective (RTO).

### Recovery Point Objective

RPO indicates the point in time to which data can be recovered. The RPO target is typically less than twice the replication schedule, but it can vary. In some cases, it can go beyond the target RPO based on various factors.  

Cross-region replication supports three replication schedules: 10 minutes, hourly, and daily.

- For the replication schedule of 10 minutes, the typical RPO is less than 20 minutes.
- For the hourly replication schedule, the typical RPO is less than two hours.
- For the daily replication schedule, the typical RPO is less than two days.

### Recovery Time Objective

RTO indicates the maximum tolerable business application downtime. RTO is determined by factors in bringing up the application and providing access to the data at the second site.

## Cost model for cross-region replication

With Azure NetApp Files cross-region replication, you pay only for the amount of data you replicate. There's no setup charge or minimum usage fee.  

The replication price is based on the replication frequency and the region of the destination volume you choose during the initial replication configuration. 

For pricing information, see [Cost models for cross-region replication](/azure/reliability/cross-region-replication-azure#cost-model-for-cross-region-replication).