The combination of the quota assigned to the volume and the selected service level determines the throughput limit for a volume with automatic QoS. For volumes with manual QoS, the throughput limit can be defined individually.

Ensure you choose the correct service level and volume quota size for the expected performance level. Throughput limits are a combination of read and write speed.

The metrics used in analyzing the performance of Azure NetApp Files are: 

* **Average I/O Requests/second**
    Corresponds to the sum of average Read I/O requests/second and average write I/O requests/second from the load profile section
* **Average I/O MB/second**
    Corresponds to the sum of average read I/O MB/second and average write I/O MB/second from the load profile section
* **Average read latency**
    Corresponds to the average latency of the Oracle Wait Event "db file sequential read" in microseconds
* **Number of threads/schema**
    Corresponds to the number of SLOB (Silly Little Oracle Benchmarks) threads per user schema

## More resources 

Visit Azure NetApp Files documentation to learn about [performance best practices](/azure/azure-netapp-files/performance-linux-direct-io).

Learn more about performance benchmark testing done in Azure NetApp Files:

- [Azure NetApp Files performance benchmarks for Linux](/azure/azure-netapp-files/performance-benchmarks-linux)
- [Azure NetApp Files large volume performance benchmarks for Linux](/azure/azure-netapp-files/performance-large-volumes-linux)
- [Performance impact of Kerberos on Azure NetApp Files NFSv4.1 volumes](/azure/azure-netapp-files/performance-impact-kerberos)
- [Oracle database performance on Azure NetApp Files single volumes](/azure/azure-netapp-files/performance-oracle-single-volumes)
- [Oracle database performance on Azure NetApp Files multiple volumes](/azure/azure-netapp-files/performance-oracle-multiple-volumes)
- [Azure NetApp Files datastore performance benchmarks for Azure VMware Solution](/azure/azure-netapp-files/performance-benchmarks-azure-vmware-solution)
- [Azure VMware Solution datastore performance considerations for Azure NetApp Files](/azure/azure-netapp-files/performance-azure-vmware-solution-datastore)
- [Performance considerations for Azure NetApp Files with cool access](/azure/azure-netapp-files/performance-considerations-cool-access)
