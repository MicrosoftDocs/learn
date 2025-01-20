Learn about the best practices and benefits of Azure NetApp Files application volume group.  

## Best practices

Adhering to best practices improves the efficacy of your application volume group deployment. Below are some of the best practices you can allow while using application volume groups for Azure NetApp Files. 

### Define clear grouping criteria

You need to establish well defined criteria for grouping volumes within an application volume group. Definition ensures that the applied logic aligns with the specific needs and characteristics of the associated application. 

### Prepare for the deployment

You obtain application specific information before deploying the volumes by studying the performance capabilities of Azure NetApp Files volumes and by observing application volume sizes and performance data in the current (on-premises) implementation.

### Regularly monitor and optimize

You need to implement a proactive monitoring strategy to assess the performance of volumes within an application volume group. Regularly optimize resource allocations and policies based on changing application requirements. 

### Document and communicate

Another best practice is to maintain comprehensive documentation outlining application volume group configurations, policies, and any changes made over time. Effective communication regarding application volume group structures is vital for collaborative management.

## Benefits

Benefits of using application volume groups for Azure NetApp Files include:  

- Volumes deployed by application volume group are placed in the regional or zonal infrastructure to achieve optimized latency and throughput for the application VMs.
- Resulting volumes provide the same flexibility for resizing capacity and throughput as individually created volumes.  
- These volumes also support Azure NetApp Files data protection solutions including snapshots and cross-region/cross-zone replication.

## Application volume groups for SAP HANA and Oracle databases

Learn more about the use cases and key features of Azure NetApp Files application volume group for SAP HANA and Oracle databases.

- [Azure NetApp Files application volume group for SAP HANA](/azure/azure-netapp-files/application-volume-group-introduction)
- [Azure NetApp Files application volume group for Oracle](/azure/azure-netapp-files/application-volume-group-oracle-introduction)