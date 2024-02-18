In general, customers have options when deploying SAP products in Azure:

- **Azure Virtual Machines**: There's a growing number of Azure Virtual Machine SKUs certified for hosting SAP HANA including GS5 and several M family virtual machine sizes (with M208ms\_v2, featuring 5.7 TiB of memory and with M128s supporting scale-out configuration). There's also a larger selection of Azure Virtual Machine SKUs that support non-HANA workloads (NetWeaver and non-NetWeaver products).
  
:::image type="content" source="../media/sap-on-azure-deployment-options-feb35243.png" alt-text="Diagram of deployment options for S A P on Azure.":::

- **SAP Cloud Appliance Library (CAL)**: SAP CAL allows you to deploy preconfigured software appliances on different public clouds, including Azure. The primary benefit of SAP CAL is that it provides an easy way to deploy and test preconfigured SAP solutions offered by SAP without having to provision underlying infrastructure. SAP CAL on Azure includes support for SAP S/4HANA or BW/4HANA. For more information, see [Deploy SAP S/4HANA or BW/4HANA on Azure](/azure/virtual-machines/workloads/sap/cal-s4h).

- **RISE with SAP S/4HANA Cloud**, private edition and SAP Enterprise Cloud Services are SAP managed services of your SAP landscape, in an Azure subscription owned by SAP. For more information, see [Integrating Azure with SAP RISE managed workloads](/azure/virtual-machines/workloads/sap/sap-rise-integration)
