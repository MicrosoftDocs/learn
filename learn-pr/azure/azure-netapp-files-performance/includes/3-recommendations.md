You should test performance with a variety of workload patterns to simulate real-world scenarios. This section provides information about testing and recommendations based on those tests. 

## Azure NetApp Files volume sizing

Ensure that you choose the correct service level and volume quota size for the expected performance level.

### Virtual network recommendations

You should perform the benchmark testing in the same virtual network (VNet) as Azure NetApp Files. The example below demonstrates the recommendation:

:::image type="content" source="../media/3-virtual-network-diagram.png" alt-text="Diagram of a VNet configuration." lightbox="../media/3-virtual-network-diagram.png":::

## Performance benchmarking tools

Let’s look at tools for performance benchmarking. 

| Tool | Description |
| --- | ------ |
| SQL Storage Benchmark (SSB) | SQL Storage Benchmark (SSB) is an open-source benchmark tool written in Python. It is designed to generate a "real-world" workload that emulates database interaction in such a way to measure the performance of the storage subsystem. SSB aims to allow organizations and individuals to measure the performance of their storage subsystem under the stress of a SQL database workload. |
| Flexible I/O Tester (FIO) | FIO is a free and open-source disk I/O tool used both for benchmark and stress/hardware verification. FIO is available in binary format for both Linux and Windows. |

## Volume metrics

Azure NetApp Files performance data is available through Azure Monitor counters.
You can view historical data for the following information:

- Average read latency
- Average write latency
- Read IOPS (average)
- Write IOPS (average)
- Volume logical size (average)
- Volume snapshot size (average)

The counters are available using the Azure portal and REST API GET requests.

## Azure Monitor

You can access Azure NetApp Files counters on a per-volume basis from the Metrics page.

:::image type="content" source="../media/3-metrics.png" alt-text="Screenshot of volume metrics." lightbox="../media/3-metrics.png":::

You can also create a dashboard in Azure Monitor for Azure NetApp Files by going to the Metrics page, filtering for NetApp, and specifying the volume counters of interest.

:::image type="content" source="../media/3-metric-resource.png" alt-text="Screenshot showing how to filter volume metrics." lightbox="../media/3-metric-resource.png":::

## More resources 

Visit Azure NetApp Files documentation to learn about [performance best practices](/azure/azure-netapp-files/performance-linux-direct-io).


Learn more about performance benchmark testing done in Azure NetApp Files by visiting here:

- [Azure NetApp Files performance benchmarks for Linux](/azure/azure-netapp-files/performance-benchmarks-linux)
- [Azure NetApp Files large volume performance benchmarks for Linux](/azure/azure-netapp-files/performance-large-volumes-linux)
- [Performance impact of Kerberos on Azure NetApp Files NFSv4.1 volumes](/azure/azure-netapp-files/performance-impact-kerberos)
- [Oracle database performance on Azure NetApp Files single volumes](/azure/azure-netapp-files/performance-oracle-single-volumes)
- [Oracle database performance on Azure NetApp Files multiple volumes](/azure-netapp-files/performance-oracle-multiple-volumes)
- [Azure NetApp Files datastore performance benchmarks for Azure VMware Solution](/azure/azure-netapp-files/performance-benchmarks-azure-vmware-solution)
- [Azure VMware Solution datastore performance considerations for Azure NetApp Files](/azure/azure-netapp-files/performance-azure-vmware-solution-datastore)
