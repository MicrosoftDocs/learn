The SAPS metric makes up one of the major criteria for determining whether a virtual machine size offers the throughput requirement necessary for a given SAP workload. Effectively, it also represents one of the primary factors considered by Microsoft and SAP when certifying Azure Virtual Machines for SAP NetWeaver and SAP HANA. SAP uses that data to document it in [SAP Note \#1928533](https://me.sap.com/notes/1928533). This note is the official source of the information about SAPS ratings for SAP NetWeaver certified virtual machines. It lists the number of vCPUs, memory, and SAPS for each of the Azure Virtual Machine types that are certified to run the SAP NetWeaver workload.

Also, SAP makes its SAP Sales and Distribution Standard Application benchmarks for hyperscale clouds (including Azure) publicly available at [SAP Standard Application Benchmarks](https://www.sap.com/dmc/exp/2018-benchmark-directory/).

It's important to note that the listing doesn't include every certified Azure Virtual Machine type. And, also doesn't include the vCPU and memory definition of the virtual machine, but instead the theoretical capacity for the case when Intel Hyperthreading is configured on the host. Effectively, you shouldn't use it for sizing purposes or draw any conclusions regarding the number of vCPUs or the volume of memory for a given Azure Virtual Machine size.

> [!NOTE]
> To get that data, you need to check the Azure pricing information or [SAP Note \#1928533](https://me.sap.com/notes/1928533).

When comparing different Azure Virtual Machine sizes and calculating the ratio of SAPS to vCPU, it's worth noting that information provided by Microsoft and SAP always references vCPUs or CPU threads rather than CPU cores. An Intel CPU bare-metal core could represent one CPU thread in the case the Hyper-V host is configured without Hyperthreading or two CPU threads with Hyperthreading enabled.

Hyperthreading on bare-metal server improves the overall throughput. However, the increase isn't directly proportional to the number of CPU threads of the host. The throughput improvement by Hyperthreading under a typical SAP workload is ranging from 30-40%. As a result, one core with two hyperthreaded CPU threads on the host delivers 130-140% of the throughput the same processor core delivers without Hyperthreading. This means that a single CPU thread of a hyperthreaded core delivers between 65-70% of what a non-hyperthreaded core delivers with a single CPU thread.

The following NetWeaver and/or SAP HANA certified Azure Virtual Machine families are running on host hardware where Intel Hyperthreading is enabled:

- **D(S)v3**
- **E(S)v3**
- **M-Series**

When sizing your intended deployment, you must also consider whether you implement it by using the 2-tier or 3-tier architecture. This is reflected in the SAPS ratings for Azure Virtual Machine sizes documented in [SAP Note \#1928533](https://me.sap.com/notes/1928533), which provides distinct SAP numbers for both architecture type for each virtual machine size.

Virtual machine types have certain bandwidth limitations as well. In general, we can state that the smaller the virtual machine in a virtual machine family is, the smaller the storage and network bandwidth. In large virtual machines, like M128s or M128ms, or ES64v3 the virtual machine is the only virtual machine running on a host. As a result, it benefits from the complete network and storage bandwidth the host has available. In smaller virtual machines, the network and storage bandwidth need to be divided across multiple virtual machines. Especially for SAP HANA, but also for SAP NetWeaver, it's vitally important that a virtual machine running intensive workload doesn't affect CPU, memory, network and storage bandwidth capacity of other virtual machines running on the same host. As a result, in sizing a virtual machine, you also need to consider the required network and storage bandwidth. Detailed data of network and storage throughput for each virtual machine type can be found in [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes).

To maximize performance, Microsoft recommends applying other factors and considerations after conducting an SAP sizing analysis. Some factors aren't covered by SAP sizing techniques at all such as the use of SSD and large amounts of RAM.

There are several approaches to sizing SAP systems:

- **Reference-based sizing** – Sizing based on the comparison of ST03N and other actual production performance data of known systems with similar performance data and a known hardware configuration
- **Early Watch Alerts (EWA)** – EWA reports show existing hardware and current performance and growth for 12 months, letting you map it to similar Azure hardware (CPU type, core count, memory, etc.). Alternatively, EWA reports provide the hardware vendor/model, and you can look up SAPS for the old hardware
- **SAP Quick Sizer** – SAP tool that calculates SAPS, database size and RAM based on many inputs including business document volumes and number of users
- **T-Shirt** – Sizing based on the anticipated number of SAP users where precise information is unavailable

> [!NOTE]
> For more information on SAP sizing, see the [SAP documentation](https://www.sap.com/about/benchmark/sizing.html). When you look at the current utilization using either SAP Early Watch Alert reports or other tools, often peak CPU and memory utilization is much lower than the size of the current machines. The general guidance is to use an average target CPU utilization of 65%. If your average utilization is below 30%, the CPU is considered oversized. In Azure, rather than size each virtual machine for its peak workload, you can simply scale up the virtual machine when required and scale it back down again when the workload reduces.

You might have the option of evaluating performance of your existing Azure deployments by using load testing tools (such as LoadRunner by Micro Focus, available from Azure Marketplace).

Other sizing considerations applicable to scenarios involving migrating from anyDB to SAP HANA are documented in the following SAP notes:

- [SAP Note \#1872170 – Suite on HANA – S/4 sizing report](https://me.sap.com/notes/1872170)
- [SAP Note \#1995209 – Suite on HANA memory Sizing report – Advanced correction 1](https://me.sap.com/notes/1995209)
- [SAP Note \#2062017 – Suite on HANA memory Sizing report – Advanced correction 2](https://me.sap.com/notes/2062017)
- [SAP Note \#2080648 – Suite on HANA memory Sizing report – Advanced correction 3](https://me.sap.com/notes/2080648)
- [SAP Note \#2175150 – Suite on HANA memory Sizing report – Advanced correction 4](https://me.sap.com/notes/2175150)
- [SAP Note \#2213586 – Suite on HANA memory Sizing report – Advanced correction 5](https://me.sap.com/notes/2213586)
- [SAP Note \#2303847 – Suite on HANA memory Sizing report – Advanced correction 6](https://me.sap.com/notes/2303847)

In particular, [SAP Note \#1872170](https://me.sap.com/notes/1872170) documents reports (/SDF/HDB\_SIZING and ZNEWHDB\_SIZE) that facilitate estimating the memory and disk space requirements for the database tables of Business Suite on HANA, S/4HANA systems, and any other ABAP-based systems running on HANA, except for BW. The sizing process includes running an SAP report.
