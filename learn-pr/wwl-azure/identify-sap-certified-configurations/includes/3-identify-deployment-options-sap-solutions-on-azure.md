In general, customers have options when deploying SAP products in Azure:

- **Azure Virtual Machines**: There's a growing number of Azure Virtual Machine SKUs certified for hosting SAP HANA including GS5 and several M family virtual machine sizes (with M208ms\_v2, featuring 5.7 TiB of memory and with M128s supporting scale-out configuration). There's also a larger selection of Azure Virtual Machine SKUs that support non-HANA workloads (NetWeaver and non-NetWeaver products).
  
:::image border="false" type="content" source="../media/sap-on-azure-deployment-options-feb35243.png" alt-text="Diagram showing deployment options for S A P on Azure.":::

- **SAP Cloud Appliance Library (CAL)**: SAP CAL allows you to deploy preconfigured software appliances on different public clouds, including Azure. The primary benefit of SAP CAL is that it provides an easy way to deploy and test preconfigured SAP solutions offered by SAP without having to provision underlying infrastructure. SAP CAL on Azure includes support for SAP S/4HANA or BW/4HANA. For more information, see [Deploy SAP S/4HANA or BW/4HANA on Azure](/azure/virtual-machines/workloads/sap/cal-s4h).

- **RISE with SAP S/4HANA Cloud**, private edition, and SAP Enterprise Cloud Services are SAP managed services of your SAP landscape, in an Azure subscription owned by SAP. For more information, see [Integrating Azure with SAP RISE managed workloads](/azure/virtual-machines/workloads/sap/sap-rise-integration)

## Choose Azure VM types

SAP lists which [Azure VM types that you can use for production scenarios](https://www.sap.com/dmc/exp/2014-09-02-hana-hardware/enEN/#/solutions?filters=v:deCertified;iaas;ve:24). For nonproduction scenarios, a wider variety of native Azure VM types is available.

>[!NOTE]
> For non-production scenarios, use the VM types that are listed in the [SAP note #1928533](https://launchpad.support.sap.com/#/notes/1928533). For the usage of Azure VMs for production scenarios, check for SAP HANA certified VMs in the SAP published [Certified IaaS Platforms list](https://www.sap.com/dmc/exp/2014-09-02-hana-hardware/enEN/#/solutions?filters=v:deCertified;ve:24;iaas;v:125;v:105;v:99;v:120).

Deploy the VMs in Azure by using:

- The Azure portal.
- Azure PowerShell cmdlets.
- The Azure CLI.

You also can deploy a complete installed SAP HANA platform on the Azure VM services through the [SAP Cloud platform](https://cal.sap.com). The installation process is described in [Deploy SAP S/4HANA or BW/4HANA on Azure](/azure/sap/workloads/cal-s4h).

>[!IMPORTANT]
> In order to use M208xx_v2 VMs, you need to be careful selecting your Linux image. For more information, see [Memory optimized virtual machine sizes](/azure/virtual-machines/mv2-series).
