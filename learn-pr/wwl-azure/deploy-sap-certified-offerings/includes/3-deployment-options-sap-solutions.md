With Microsoft Azure, you can reliably run your mission-critical SAP workloads and scenarios on a scalable, compliant, and enterprise-proven platform.

Microsoft Azure offers multiple ways to deploy VM-based solutions.

* **VM images and disks:** One of the primary considerations is the approach to installing the operating system and the associated SAP workloads. In general, there are three options to choose from.

* **Azure Marketplace images:** This approach involves deploying VMs based on Microsoft or third-party provided VM images from the Azure Marketplace. After you deployed your VM in Azure, you follow the same guidelines and tools to install the SAP software and/or DBMS inside your VM as you would do in an on-premises environment. The installation can be performed manually or in an automated manner, by using configuration management tools, such as PowerShell DSC, Custom Script, Ansible, Puppet, or Chef (most of which are available in the form of Azure VM Extensions).

There are three options for deploying SAP products in Azure:

* **Azure VMs**: There is a growing number of Azure VM SKUs certified for hosting SAP HANA including GS5 and a number of M family VM sizes (with M208ms_v2, featuring 5.7 TiB of memory and with M128s supporting scale-out configuration). There is also much larger selection of Azure VM SKUs that support non-HANA workloads (NetWeaver and non-NetWeaver products).

* **SAP HANA on Azure (Large Instances)**: There are several SKUs ranging from 2 TiB per node (S192 with scale-out support) to 20 TiB per node (S960m). Two different classes of hardware divide the SKUs into:

    * S72, S72m, S96, S144, S144m, S192, S192m, and S192xm, which are referred to as the "Type I class" of SKUs.

    * S384, S384m, S384xm, S384xxm, S576m, S576xm S768m, S768xm and S960m, which are referred to as the "Type II class" of SKUs.

* **SAP Cloud Appliance Library (CAL)**: SAP CAL offers deployment for pre-configured software appliances on different public clouds, including Azure. The primary benefit of SAP CAL is that provides an easy way to deploy and test pre-configured SAP solutions offered by SAP without having to provision underlying infrastructure. SAP CAL on Azure include support for SAP S/4HANA or BW/4HANA. 

Below is a listing of Azure VM SKUs supported for non-HANA RDBMS platforms serving SAP workloads, including VM series, VM type, VM size, SAPS ratings for 2- and 3-tier configurations, as well as required Azure Storage type for all database related files:

|    VM Series    |    VM Type    |    VM Size    |    2-Tier SAPS    |    3-Tier SAPS    |    Required Azure Storage type for all   database related files    |
|-------------------|------------------------------------|---------------------------|-------------------|-------------------|--------------------------------------------------------------------|
|    A-series    |    Standard_A5    |    2CPU, 14   GiB    |    1,500    |    12,000    |    Standard    |
|    A-series    |    Standard_A6    |    4CPU, 28   GiB    |    3,000    |    25,000    |    Standard    |
|    A-series    |    Standard_A7    |    8CPU, 56   GiB    |    6,000    |    50,000    |    Standard    |
|    A-series    |    Standard_A8   / Standard_A10    |    8CPU, 56   GiB    |    11,000    |    No support    |    Standard    |
|    A-series    |    Standard_A9   / Standard_A11    |    16 CPU,   112 GiB    |    22,000    |    No support    |    Standard    |
|    D-series    |    Standard_D11    |    2CPU, 14   GiB    |    2,325    |    (*)    |    Standard    |
|    D-series    |    Standard_D12    |    4CPU, 28   GiB    |    4,650    |    (*)    |    Standard    |
|    D-series    |    Standard_D13    |    8CPU, 56   GiB    |    9,300    |    (*)    |    Standard    |
|    D-series    |    Standard_D14    |    16 CPU,   112 GiB    |    18,600    |    (*)    |    Standard    |
|    DS-series    |    Standard_DS11    |    2CPU, 14   GiB    |    2,325    |    (*)    |    Premium    |
|    DS-series    |    Standard_DS12    |    4CPU, 28   GiB    |    4,650    |    48,750    |    Premium    |
|    DS-series    |    Standard_DS13    |    8CPU, 56   GiB    |    9,300    |    91,050    |    Premium    |
|    DS-series    |    Standard_DS14    |    16 CPU,   112 GiB    |    18,600    |    (*)    |    Premium    |
|    DS-series    |    Standard_DS11_v2    |    2CPU, 14 GiB    |    3,530    |    (*)    |    Premium    |
|    DS-series    |    Standard_DS12_v2    |    4CPU, 28   GiB    |    6,680    |    (*)    |    Premium    |
|    DS-series    |    Standard_DS13_v2    |    8CPU, 56   GiB    |    12,300    |    (*)    |    Premium    |
|    DS-series    |    Standard_DS14_v2    |    16 CPU,   112 GiB    |    24,180    |    (*)    |    Premium    |
|    DSv2-series    |    Standard_DS15_v2    |    20 CPU,   140 GiB    |    30,430    |    (*)    |    Premium    |
|    DSv3-series    |    Standard_D2s_v3    |    2CPU, 8GiB    |    2,178    |    (*)    |    Premium    |
|    DSv3-series    |    Standard_D4s_v3    |    4CPU, 16   GiB    |    4,355    |    (*)    |    Premium    |
|    DSv3-series    |    Standard_D8s_v3    |    8CPU, 32   GiB    |    8,710    |    (*)    |    Premium    |
|    DSv3-series    |    Standard_D16s_v3    |    16 CPU, 64   GiB    |    17,420    |    (*)    |    Premium    |
|    DSv3-series    |    Standard_D32s_v3    |    32 CPU,   128 GiB    |    34,840    |    (*)    |    Premium    |
|    DSv3-series    |    Standard_D64s_v3    |    64 CPU,   256 GiB    |    69,680    |    (*)    |    Premium    |
|    Esv3-series    |    Standard_E2s_v3    |    2CPU, 16   GiB    |    2,178    |    (*)    |    Premium    |
|    Esv3-series    |    Standard_E4s_v3    |    4CPU, 32   GiB    |    4,355    |    (*)    |    Premium    |
|    Esv3-series    |    Standard_E8-4s_v3    |    4CPU, 64   GiB    |    4,378    |    (*)    |    Premium    |
|    Esv3-series    |    Standard_E8s_v3    |    8CPU, 64   GiB    |    8,710    |    (*)    |    Premium    |
|    Esv3-series    |    Standard_E16s_v3    |    16 CPU,   128 GiB    |    17,420    |    (*)    |    Premium    |
|    Esv3-series    |    Standard_E20s_v3    |    20 CPU,   160 GiB    |    21,775    |    (*)    |    Premium    |
|    Esv3-series    |    Standard_E32s_v3    |    32 CPU,   256 GiB    |    34,840    |    (*)    |    Premium    |
|    Esv3-series    |    Standard_E64is_v3    |    64 CPU,   432 GiB    |    70,050    |    (*)    |    Premium    |
|    Esv3-series    |    Standard_E64s_v3    |    64 CPU,   432 GiB    |    70,050    |    (*)    |    Premium    |
|    GS-series    |    Standard_GS1    |    2CPU, 28   GiB    |    3,580    |    34,415    |    Premium    |
|    GS-series    |    Standard_GS2    |    4CPU, 56   GiB    |    6,900    |    78,620    |    Premium    |
|    GS-series    |    Standard_GS3    |    8CPU, 112   GiB    |    11,870    |    137,520    |    Premium    |
|    GS-series    |    Standard_GS4    |    16 CPU,   224 GiB    |    22,680    |    247,880    |    Premium    |
|    GS-series    |    Standard_GS5    |    32 CPU,   448 GiB    |    41,670    |    (*)    |    Premium    |
|    M-series    |    Standard_M8ms    |    8CPU, 219   GiB    |    8,616    |    (*)    |    Premium    |
|    M-series    |    Standard_M16ms    |    16 CPU,   438 GiB    |    17,232    |    (*)    |    Premium    |
|    M-series    |    Standard_M32ts    |    32 CPU,   192 GiB    |    33,670    |    (*)    |    Premium    |
|    M-series    |    Standard_M32ls    |    32 CPU,   256 GiB    |    33,670    |    (*)    |    Premium    |
|    M-series    |    Standard_M32ms    |    32 CPU,   875 GiB    |    34,465    |    (*)    |    Premium    |
|    M-series    |    Standard_M64ls    |    64 CPU,   512 GiB    |    66,600    |    (*)    |    Premium    |
|    M-series    |    Standard_M64s    |    64 CPU,   1024 GiB    |    67,315    |    (*)    |    Premium    |
|    M-series    |    Standard_M64ms    |    64 CPU,   1792 GiB    |    68,930    |    (*)    |    Premium    |
|    M-series    |    Standard_M128s    |    128 CPU,   2048 GiB    |    134,630    |    (*)    |    Premium    |
|    M-series    |    Standard_M128ms    |    128 CPU,   3892 GiB    |    134,630    |    (*)    |    Premium    |
|    M-series    |    Standard_M208s_v2    |    208 CPU,   2.85 TiB    |    259,950    |    (*)    |    Premium    |
|    M-series    |    Standard_M208ms_v2    |    208 CPU,   5.7 TiB    |    259,950    |    (*)    |    Premium    |


(*) SAPS are available directly from SAP 


## Azure VMs for SAP NetWeaver (A)SCS and SAP NetWeaver app server

Azure VM SKUs supported for SAP NetWeaver (A)SCS and SAP NetWeaver application server/dialog instances include the following:

|    VM Series    |    VM Type    |    VM Size    |    2-Tier SAPS    |
|-------------------|------------------------|-------------------------|-------------------|
|    Dv2-series    |    Standard_D11_v2    |    2 CPU, 14   GiB    |    3,530    |
|    Dv2-series    |    Standard_D12_v2    |    4 CPU, 28   GiB    |    6,680    |
|    Dv2-series    |    Standard_D13_v2    |    8 CPU, 56   GiB    |    12,300    |
|    Dv2-series    |    Standard_D14_v2    |    16 CPU,   112 GiB    |    24,180    |
|    Dv2-series    |    Standard_D15_v2    |    20 CPU,   140 GiB    |    30,430    |
|    Dv3-series    |    Standard_D2_v3    |    2 CPU, 8   GiB    |    2,178    |
|    Dv3-series    |    Standard_D4_v3    |    4 CPU, 16   GiB    |    4,355    |
|    Dv3-series    |    Standard_D8_v3    |    8 CPU, 32   GiB    |    8,710    |
|    Dv3-series    |    Standard_D16_v3    |    16 CPU, 64   GiB    |    17,420    |
|    Dv3-series    |    Standard_D32_v3    |    32 CPU,   128 GiB    |    34,840    |
|    Dv3-series    |    Standard_D64_v3    |    64 CPU,   256 GiB    |    69,680    |
|    Ev3-series    |    Standard_E2_v3    |    2 CPU, 16   GiB    |    2,178    |
|    Ev3-series    |    Standard_E4_v3    |    4 CPU, 32   GiB    |    4,355    |
|    Ev3-series    |    Standard_E8_v3    |    8 CPU, 64   GiB    |    8,710    |
|    Ev3-series    |    Standard_E16_v3    |    16 CPU, 128   GiB    |    17,420    |
|    Ev3-series    |    Standard_E32_v3    |    32 CPU,   256 GiB    |    34,840    |
|    Ev3-series    |    Standard_E64_v3    |    64 CPU,   432 GiB    |    70,050    |
|    G-series    |    Standard_G1    |    2 CPU, 28   GiB    |    3,580    |
|    G-series    |    Standard_G2    |    4 CPU, 56   GiB    |    6,900    |
|    G-series    |    Standard_G3    |    8 CPU, 112   GiB    |    11,870    |
|    G-series    |    Standard_G4    |    16 CPU,   224 GiB    |    22,680    |
|    G-series    |    Standard_G5    |    32 CPU,   448 GiB    |    41,670    |

 

Microsoft Azure offers Constrained vCPU capable VM sizes with a reduced number of vCPUs. The vCPU count can be constrained to one half or one quarter of the original VM size. These new VM sizes have a suffix that specifies the number of active vCPUs. 

## SAP HANA on Azure (Large Instances) SKUs 
SAP HANA on Azure (Large Instances) SKUs are available in US West, US East, Australia East, Australia Southeast, West Europe, North Europe, Japan East, and Japan West) and consist of the following offerings:

|    SAP solution    |    CPU    |    Memory    |    Storage    |    Availability    |
|--------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|------------------------------|---------------|------------------------------|
|    Optimized   for OLAP: SAP BW, BW/4HANA or SAP HANA for generic OLAP workload    |    SAP HANA   on Azure S72 – 2 x Intel® Xeon® Processor E7-8890 v3 36 CPU cores and 72 CPU   threads    |    768 GB    |    3 TB    |    Not   offered anymore     |
|    ---    |    SAP HANA   on Azure S144 – 4 x Intel® Xeon® Processor E7-8890 v3 72 CPU cores and 144   CPU threads    |    1.5 TB    |    6 TB    |    Not   offered anymore     |
|    ---    |    SAP HANA   on Azure S192 – 4 x Intel® Xeon® Processor E7-8890 v4 96 CPU cores and 192   CPU threads    |    2.0 TB    |    8 TB    |    Available     |
|    ---    |    SAP HANA   on Azure S384 – 8 x Intel® Xeon® Processor E7-8890 v4 192 CPU cores and 384   CPU threads    |    4.0 TB    |    16 TB    |    Available     |
|    Optimized   for OLTP: SAP Business Suite on SAP HANA or S/4HANA (OLTP), generic OLTP    |    SAP HANA   on Azure S72m – 2 x Intel® Xeon® Processor E7-8890 v3 36 CPU cores and 72 CPU   threads 1.5 TB 6 TB    |    Not   offered anymore     |         |         |
|    ---    |    SAP HANA   on Azure S144m – 4 x Intel® Xeon® Processor E7-8890 v3 72 CPU cores and 144   CPU threads    |    3.0 TB    |    12 TB    |    Not   offered anymore     |
|    ---    |    SAP HANA   on Azure S192m – 4 x Intel® Xeon® Processor E7-8890 v4 96 CPU cores and 192   CPU threads    |    4.0 TB    |    16 TB    |    Available     |
|    ---    |    SAP HANA   on Azure S384m – 8 x Intel® Xeon® Processor E7-8890 v4 192 CPU cores and 384   CPU threads    |    6.0 TB    |    18 TB    |    Available     |
|    ---    |    SAP HANA   on Azure S384xm – 8 x Intel® Xeon® Processor E7-8890 v4 192 CPU cores and 384   CPU threads    |    8.0 TB    |    22 TB    |    Available     |
|    ---    |    SAP HANA   on Azure S576m – 12 x Intel® Xeon® Processor E7-8890 v4 288 CPU cores and 576   CPU threads    |    12.0 TB    |    28 TB    |    Available     |
|    ---    |    SAP HANA   on Azure S768m – 16 x Intel® Xeon® Processor E7-8890 v4 384 CPU cores and 768   CPU threads    |    16.0 TB    |    36 TB    |    Available     |
|    ---    |    SAP HANA   on Azure S960m – 20 x Intel® Xeon® Processor E7-8890 v4 480 CPU cores and 960   CPU threads    |    20.0 TB    |    46 TB    |    Available    |



## SAP HANA TDIv5 customer-specific sizing  for server configurations 
According to the terms of SAP HANA TDIv5, SAP allows customer-specific sizing and customer-specific projects for server configurations which are not listed as certified in:

* SAP HANA Certified Appliances
* SAP HANA certified IaaS platforms

In many cases, these customer-specific server configurations carry more memory than the server units certified with SAP. Customers have the option to work directly with SAP to certify their customer-specific sized server configurations. In Azure the following HANA Large Instance standard SKUs are available and in the Microsoft price list for such TDIv5 customer-specific sizing projects:

|    SKU    |    CPU    |    Memory    |    Storage    |    Availability    |
|---------------------------------|-------------------------------------------------------------------------------------------------------------|---------------|---------------|--------------------|
|    S96    |    SAP HANA on Azure S96 – 2 x Intel® Xeon® Processor E7-8890   v4 48 CPU cores and 96 CPU threads    |    768 GB    |    3 TB    |    Available     |
|    S192m can be extended to    |    SAP HANA on Azure S192xm – 4 x Intel® Xeon® Processor   E7-8890 v4 96 CPU cores and 192 CPU threads    |    6.0 TB    |    16 TB    |    Available     |
|    S384xm can be extended to    |    SAP HANA on Azure S384xxm – 8 x Intel® Xeon® Processor   E7-8890 v4 192 CPU cores and 384 CPU threads    |    12.0 TB    |    28 TB    |    Available     |
|    S576m can be extended to    |    SAP HANA on Azure S576xm – 12 x Intel® Xeon® Processor   E7-8890 v4 288 CPU cores and 576 CPU threads    |    18.0 TB    |    41 TB    |    Available     |
|    S768m can be extended to    |    SAP HANA on Azure S768xm – 16 x Intel® Xeon® Processor   E7-8890 v4 384 CPU cores and 768 CPU threads    |    24.0 TB    |    56 TB    |    Available    |



CPU cores represent the sum of non-hyper-threaded CPU cores of the sum of the processors of the server unit. CPU threads represent the sum of compute threads provided by hyper-threaded CPU cores of the sum of the processors of the server unit. 