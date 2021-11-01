Licensing, support, and pricing provisions differ to some extent depending on whether SAP software is running on Azure VMs or on SAP HANA on Azure (Large Instances).

## Azure VMs

Regarding SAP licensing, as per [SAP Note \#1380654](https://launchpad.support.sap.com/#/notes/1380654), customers must procure appropriate licenses for SAP software to be deployed to Azure. Pricing of Azure resources and licensing of the non-SAP software follows the standard Azure pricing and licensing rules.

Support requirements are outlined in [SAP Note \#2015553](https://launchpad.support.sap.com/#/notes/2015553), which states that when operating SAP systems on Microsoft Azure VMs, customers can choose one of two support options:

 -  **Professional Direct**, which provides the bare minimum support level, appropriate if you only require support from Microsoft for Azure itself.
 -  **Microsoft Premier Support**, which is recommended if SAP workloads are based on Windows Server and/or SQL Server. This offers the best enterprise-level support for Azure, Windows and/or SQL Server.

In addition, when running SAP software on Linux Azure VMs, customers should satisfy the separate support requirements SAP has for operating SAP systems on the corresponding Linux distributions.

## SAP HANA on Azure (Large Instances)

The use of SAP HANA on Azure (Large Instances) requires a Microsoft Premier support contract. For specific information related to running SAP in Azure, see [SAP Note \#2015553](https://launchpad.support.sap.com/#/notes/2015553). If you use HANA Large Instance units with 384 and more CPUs, you also need to extend the Premier support contract to include Azure Rapid Response.

## Raise support requests for Azure virtual machines

As per SAP document [Frequently Asked Questions: Microsoft Azure](https://wiki.scn.sap.com/wiki/display/VIRTUALIZATION/Frequently+Asked+Questions%3A+Microsoft+Azure), to raise a support ticket at SAP when contacting Microsoft Azure support, open an OSS ticket at component **BC-OP-NT-AZR** for Windows and **BC-OP-LNX-AZR** for Linux.
