As documented in the Azure virtual machines planning guide, there are two basic methods for connecting into Azure VMs:

- Connect through public endpoints on a Jumpbox VM.
- Connect through a VPN or Azure ExpressRoute.

Site-to-site connectivity via VPN or ExpressRoute is necessary for production scenarios. This type of connection is also needed for nonproduction scenarios that feed into production scenarios where SAP software is being used.

## Azure Automation

Azure Automation offers the desired state configuration functionality via a cloud-based, managed DSC Pull Server in the Azure cloud. It provides rich reports that inform you of important events such as when nodes have deviated from their assigned configuration. You can monitor and automatically update machine configuration across physical and virtual machines, Windows or Linux, in the cloud or on-premises. Azure Automation also includes a built-in solution that starts and stops Azure VMs on user-defined schedules.

## SAP Landscape Management (LaMa)

SAP LaMa is used by many customers to operate, monitor, and refresh their SAP landscape. Since SAP LaMa 3.0 SP05, it ships with a connector to Azure by default. You can use this connector to deallocate and start virtual machines, copy and relocate managed disks, and delete managed disks. With these basic operations, you can relocate, copy, clone, and refresh SAP systems using SAP LaMa.
