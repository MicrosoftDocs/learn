Manual single-instance implementation does not differ significantly from the process for on-premises deployments. 

For NetWeaver AnyDB deployments, you follow the standard (2-tier) or distributed (3-tier) NetWeaver installation options in SAP Software Provisioning Manager (SWPM) .

For HANA-based NetWeaver deployments, use one of the following methods: 

* **SAP Software Provisioning Manager (SWPM)** as part of the standard (2-tier) or distributed (3-tier) NetWeaver installation, followed by HANA installation.

* **SAP HANA database lifecycle manager (HDBLCM) tool**, and then install NetWeaver.

Installation begins by provisioning an ASCS instance. As part of the ASCS instance installation, the /sapmnt share which includes the SAP profile directory, must be shared with the SAP DB server VM. The DB installation step requires access to the directory. Depending on the operating system of the DB server VM, the best way to provide access is either by using SMB or NFS, . 

For Linux OS, the /sapmnt directory is shared using NFS with the rw and no_root_squash options. The defaults are ro and root_squash. In the final step, the installation provisions the primary application server instance. After the primary application server instance is installed, you  use tools such as SAP GUI to verify that the installation has finished.

You can manually install SAP HANA on Azure VMs in the following ways:

* **SAP Software Provisioning Manager (SWPM)** as part of a distributed NetWeaver installation in the "install database instance" step.

* **SAP HANA database lifecycle manager (HDBLCM) tool** followed by the installation of NetWeaver.

For details regarding this procedure, refer to **Quickstart: Manual installation of single-instance SAP HANA on Azure Virtual Machines** at [https://docs.microsoft.com/azure/virtual-machines/workloads/sap/hana-get-started](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/hana-get-started) 

> [!NOTE]
> Regardless of the configuration and deployment methodology, it is essential that the final VM infrastructure is verified using SAP HANA H/W Configuration Check Tool (HWCCT). These results should be validated to ensure the VMs are capable of operating production workloads and thereby certified by SAP as well.
