Licensing, support, and pricing provisions differ to some extent depending on whether SAP software is running on Azure VMs or on SAP HANA on Azure (Large Instances).

## Azure VMs

Users must procure appropriate licenses for SAP software to be deployed to Azure. Pricing of Azure resources and licensing of the non-SAP software follows the standard Azure pricing and licensing rules. 

SAP recommends that users should choose one of the following support options when operating SAP systems on Microsoft Azure VMs:

* **Professional Direct:** Provides the bare minimum support level, appropriate if you only require support from Microsoft for Azure itself. 

* **Microsoft Premier Support:** Recommended if SAP workloads are based on Windows Server and/or SQL Server. This offers the best enterprise-level support for Azure, Windows and/or SQL Server. 

In addition, when running SAP software on Linux Azure VMs, users should satisfy the separate support requirements SAP has for operating SAP systems on the corresponding Linux distributions.

## SAP HANA on Azure (Large Instances)

The use of SAP HANA on Azure (Large Instances) requires Microsoft Premier support contract.  If  HANA Large Instance units with 384 or more CPUs are used, then it is recommended that the Premier support include Azure Rapid Response.

For licensing SUSE Linux Enterprise and Red Hat Enterprise Linux the following must be considered to for deployment:

* **Licenses for SUSE Linux Enterprise Server 12 for SAP Applications**: The operating system delivered by Microsoft is not registered with SUSE. It is not connected to a Subscription Management Tool instance. To remediate this it is necessary to deploy SUSE Linux Subscription Management Tool in an Azure VM. This tool provides the capability for SAP HANA on Azure (Large Instances) to be registered and respectively updated by SUSE

* **Licenses for Red Hat Enterprise Linux 6.7 or 7.x for SAP HANA**: The operating system delivered by Microsoft is not registered with Red Hat. It is not connected to a Red Hat Subscription Manager instance. To remediate this it is necessary to deploy Red Hat Subscription Manager deployed in an Azure VM. The Red Hat Subscription Manager provides the capability for SAP HANA on Azure (Large Instances) to be registered and respectively updated by Red Hat.

SAP requires you to have a support contract with your Linux provider as well. This requirement isn't removed by the solution of HANA Large Instance or the fact that you run Linux in Azure. Unlike with some of the Linux Azure gallery images, the service fee is not included in the solution offer of HANA Large Instance. It's your responsibility to fulfill the requirements of SAP regarding support contracts with the Linux distributor.