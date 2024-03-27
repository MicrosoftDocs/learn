SAP HANA Dynamic Tiering 2.0 (DT 2.0) offers the ability to offload less frequently accessed data from memory into extended storage. SAP HANA Dynamic Tiering 2.0 isn't supported by SAP BW or S/4HANA. Its primary use cases consist of native HANA applications.

There's a set of mandatory requirements that must be followed to ensure supportability for DT 2.0 on Azure Virtual Machines:

- DT 2.0 must be installed on a dedicated Azure Virtual Machine. It may not run on the same virtual machine where SAP HANA runs.
- SAP HANA and DT 2.0 virtual machines must be deployed within the same Azure virtual network.
- The SAP HANA and DT 2.0 virtual machines must be deployed with Azure accelerated networking enabled.
- Storage type for the DT 2.0 virtual machines must be Azure Premium Storage.
- Multiple Azure disks must be attached to the DT 2.0 virtual machine.
- It's required to create a striped volume (either via LVM or MDADM) across the Azure disks.

At the time of authoring, customers can use the following two virtual machine sizes to run SAP HANA DT 2.0:

- M64-32ms
- E32sv3

Given the basic premise of DT 2.0, which is to offload "warm" data to save costs, it typically makes sense to use the following virtual machine sizes:

| SAP HANA VM type | DT 2.0 VM type |
|-|-|
| M128ms | M64-32ms |
| M128s | M64-32ms |
| M64ms | E32sv3 |
| M64s | E32sv3 |

However, there's no strict rule about the possible combinations. The choice is dependent on the specific customer workload and all combinations of SAP HANA-certified M-series virtual machines with supported DT 2.0 virtual machines (M64-32ms and E32sv3) are supported.

Installing DT 2.0 on a dedicated virtual machine requires network throughput between the DT 2.0 virtual machine and the SAP HANA virtual machine of 10 Gb minimum. Therefore, it's mandatory to place all virtual machines within the same Azure virtual network and enable Azure accelerated networking.

According to DT 2.0 best practice guidance, the disk IO throughput should be minimum 50 MB/sec per physical core. According to the specifications of the two Azure Virtual Machine types that support DT 2.0, their maximum disk IO throughput values are:

- E32sv3 : 768 MB/sec (uncached) which means a ratio of 48 MB/sec per physical core
- M64-32ms : 1000 MB/sec (uncached) which means a ratio of 62.5 MB/sec per physical core

Depending on size requirements, there are different options to reach the maximum throughput of a virtual machine. The following table contains data volume disk configurations for both DT 2.0 virtual machine types that achieve the upper virtual machine throughput limit. The E32sv3 virtual machine should be considered as an entry level for smaller workloads. As the M64-32ms virtual machines have more memory, the IO load might not reach the limit, especially for read-intensive workloads. Therefore, fewer disks in the stripe set might be enough depending on the customer-specific workload:

| VM SKU | Disk Config 1 | Disk Config 2 | Disk Config 3 | Disk Config 4 | Disk Config 5 |
|-|-|-|-|-|-|
| M64-32ms | 4 x P50 -&gt; 16 TB | 4 x P40 -&gt; 8 TB | 5 x P30 -&gt; 5 TB | 7 x P20 -&gt; 3.5 TB | 8 x P15 -&gt; 2 TB |
| E32sv3 | 3 x P50 -&gt; 12 TB | 3 x P40 -&gt; 6 TB | 4 x P30 -&gt; 4 TB | 5 x P20 -&gt; 2.5 TB | 6 x P15 -&gt; 1.5 TB |

Based on heuristics, the recommended size of the log volume is 15% of the data volume size. The creation of the log volume can be accomplished by using different Azure disk types depending on cost and throughput requirements. If using the virtual machine type M64-32ms Write Accelerator should be enabled.

As with for SAP HANA scale-out, the **/hana/shared** directory must be shared between the SAP HANA virtual machine and the DT 2.0 virtual machine. The recommendation is to use the same architecture as for SAP HANA scale-out, which relies on dedicated virtual machines acting as a highly available NFS server. The identical design can be used in order to provide a shared backup volume. It's up to the customer to decide if HA is necessary or if it's enough to use a dedicated virtual machine with enough storage capacity to act as a backup server.
