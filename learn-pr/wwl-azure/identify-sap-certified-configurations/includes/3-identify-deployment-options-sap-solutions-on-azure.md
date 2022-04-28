In general, customers have three options when deploying SAP products in Azure:

 -  **Azure VMs**: There is a growing number of Azure VM SKUs certified for hosting SAP HANA including GS5 and several M family VM sizes (with M208ms\_v2, featuring 5.7 TiB of memory and with M128s supporting scale-out configuration). There's also a much larger selection of Azure VM SKUs that support non-HANA workloads (NetWeaver and non-NetWeaver products).
 -  **SAP HANA on Azure (Large Instances)**: There are several SKUs ranging from 2 TiB per node (S192 with scale-out support) to 20 TiB per node (S960m). Two different classes of hardware divide the SKUs into:
    
     -  S72, S72m, S96, S144, S144m, S192, S192m, S192xm, and S224m, S224oo, S224om, S224ooo, S224oom, which are referred to as the "Type I class" of SKUs.
     -  S384, S384m, S384xm, S384xxm, S576m, S576xm, S768m, S768xm, and S960m, which are referred to as the "Type II class" of SKUs.
 -  **SAP Cloud Appliance Library (CAL)**: SAP CAL allows you to deploy pre-configured software appliances on different public clouds, including Azure. The primary benefit of SAP CAL is that provides an easy way to deploy and test pre-configured SAP solutions offered by SAP without having to provision underlying infrastructure. SAP CAL on Azure includes support for SAP S/4HANA or BW/4HANA. For more information, see [Deploy SAP S/4HANA or BW/4HANA on Azure](/azure/virtual-machines/workloads/sap/cal-s4h).

:::image type="content" source="../media/sap-on-azure-deployment-options-feb35243.png" alt-text="Deployment options for SAP on Azure":::
