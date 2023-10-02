The following principles apply to maximizing high availability of the SAP NetWeaver system in Azure:

- The complete system is deployed on Azure (required - DBMS layer, (A)SCS instance and complete application layer need to run in the same location).
- The complete system runs within one Azure subscription (required).
- The complete system runs within one Azure Virtual Network (required).
- Each layer (for example DBMS, ASCS, Application Servers) must use a dedicated Availability Set.
- All VMs running DBMS instances of one SAP system are in one Availability Set. Native DBMS high availability features, such as SQL Server Always On or Oracle Data Guard, allow for running more than one VM hosting DBMS instances per system.
- All VMs use managed disks.
- DBMS data and log files are replicated using DBMS high availability functions that synchronize the data.
- (A)SCS instance files and SAP global folder are either stored on a highly available file share or synchronously replicated between disks of two Azure VMs that are part of the same Availability Set (for example, by using SIOS DataKeeper).

## Azure VM high availability options

High availability of Azure VMs should be considered in the following three main scenarios:

- Single Azure VMs (99.9% uptime SLA)
- Two or more VMs in the same Availability Set (99.95% uptime SLA)
- Two or more VMs in different Availability Zones in the same Azure region (99.99% uptime SLA)

For all virtual machines that have two or more instances deployed in the same Availability Set, Azure guarantees the virtual machine connectivity to at least one instance at least 99.95% of the time. When two or more VMs are part of the same Availability Set, each virtual machine in the Availability Set is assigned an update domain and a fault domain by the underlying Azure platform.

- Update domains guarantee that multiple VMs aren't rebooted at the same time during the planned maintenance of an Azure infrastructure. Only one VM is rebooted at a time.
- Fault domains guarantee that VMs are deployed on hardware components that don't share a common power source and network switch. When servers, a network switch, or a power source undergo an unplanned downtime, only one VM is affected.

Availability Sets can be used in the following scenarios in SAP systems:

- High-availability architecture for SAP application servers
- High-availability architecture for an SAP ASCS/SCS instance on Windows &amp; Linux
- High-availability DBMS instance

Considerations while setting up an Availability Set:

- Each virtual machine in an Availability Set is assigned an update domain and a fault domain by the underlying Azure platform.
- Each Availability Sets can have two or three Fault domains; know when to use each (match your application topology). and 20 update domains.
- When more than five virtual machines are configured within a single Availability Set, the sixth virtual machine is placed into the same update domain as the first virtual machine. The seventh virtual machine is placed into the same update domain as the second virtual machine, and so on.
- VMs are also aligned with disk fault domains. This alignment ensures that all the managed disks attached to a VM are within the same fault domains.
- Know the difference in SLA between Availability Set clusters, non-Availability Set clusters, and Availability Zones.
- Be sure to understand the interplay with Proximity Placement Groups.

## Single-VM scenario

In a single-VM scenario, you create an Azure VM for the SAP deployment. You use Azure Premium Storage to host the operating system disk and all your data disks. The Azure uptime SLA of 99.9 percent and the SLAs of other Azure components are enough for you to fulfill your availability SLAs for your customers. In this scenario, you have no need to use an Azure Availability Set. Instead, you rely on two different features:

- Azure VM automatic restart (also referred to as Azure service healing)
- SAP automatic restart

Azure VM auto restart, or service healing, is a functionality in Azure that works on two levels:

- The server host checks the health of its guest VMs.
- The Azure fabric controller monitors the health and availability of the server host.

A health check functionality monitors the health of every VM that is hosted on an Azure server host. If a VM falls into an unhealthy state, a reboot of the VM can be initiated by the Azure host agent that checks the health of the VM. The fabric controller checks the health of the host by checking many different parameters that might indicate issues with the host hardware. It also checks on the accessibility of the host via the network. An indication of problems with the host can lead to the following events:

- If the host signals a bad health state, a reboot of the host and a restart of the VMs that were running on the host is triggered.
- If the host isn't in a healthy state after successful reboot, a redeployment of the VMs that were originally on the now unhealthy node onto a healthy host server is initiated. In this case, the original host is marked as not healthy. It's not used for further deployments until it's cleared or replaced.
- If the unhealthy host has problems during the reboot process, an immediate restart of the VMs on a healthy host is triggered.

With the host and VM monitoring provided by Azure, Azure VMs that experience host issues are automatically restarted on a healthy Azure host.

Azure service healing won't restart Linux VMs where the guest OS is in a kernel panic state. Instead, Azure keeps the OS in kernel panic state to allow attaching a kernel debugger for analysis. Assumption is that such occurrences are rare. You can overwrite the default behavior to enable a restart of the VM. To change the default behavior, enable the parameter 'kernel.panic' in /etc/sysctl.conf. The time you set for this parameter is in seconds. Common recommended values are to wait for 20-30 seconds before triggering the reboot. For more information, see [https://gitlab.com/procps-ng/procps/blob/master/sysctl.conf](https://gitlab.com/procps-ng/procps/blob/master/sysctl.conf)

With SAP HANA, you can configure automatic restart of HANA service after the VM reboots. While it's potentially possible to configure a cold failover node (in the SAP HANA documentation, this setup is called host auto-failover), such configuration makes sense in an on-premises deployment situation where the server hardware is limited and you dedicate a single-server node as the host auto-failover node for a set of production hosts. However, in Azure, where the underlying infrastructure of Azure provides a healthy target server for a successful VM restart, it doesn't make sense to deploy SAP HANA host auto-failover. Because of Azure service healing, there's no reference architecture that foresees a standby node for HANA host auto-failover.

## SAP Autostart

SAP Autostart offers the functionality to start SAP instances immediately after the start of the OS within the VM. However, SAP doesn't recommend using this setting anymore because it doesn't provide any control over the order of instance restarts, assuming more than one VM has been restarted. For more information, see [Utilize Azure infrastructure VM restart to achieve “higher availability” of an SAP system](/azure/virtual-machines/workloads/sap/sap-higher-availability-architecture-scenarios).

In addition, while the parameter triggers the start of an SAP ABAP or Java instance when the related Windows/Linux service of the instance is started, there are scenarios where automatic restart should be avoided. For example, restarts of SAP services are common when using SAP Software Lifecycle Management features such as SUM or during updates and upgrades. In these scenarios, restarts can be disruptive. The Autostart parameter also shouldn't be used for SAP instances that are clustered.
