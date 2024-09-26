Besides the deployment considerations described earlier, manual single-instance implementation is straightforward and doesn't differ significantly from the process applicable to on-premises deployments:

- For NetWeaver AnyDB deployments, you can follow the standard (2-tier) or distributed (3-tier) NetWeaver installation options in **SAP Software Provisioning Manager (SWPM)**.
- For HANA-based NetWeaver deployments, you can use one of the following two methods:

  - Use **SAP Software Provisioning Manager (SWPM)** as part of the standard (2-tier) or distributed (3-tier) NetWeaver installation, followed by HANA installation.
  - Use the **SAP HANA Database Lifecycle Manager (HDBLCM) tool**, and then install NetWeaver.

Regardless of the approach, the installation starts by provisioning an ASCS instance. As part of the ASCS instance installation, the **/sapmnt** share, which includes the SAP profile directory, must be shared with the SAP DB server virtual machine. The DB installation step needs access to this directory. The best way to provide access is to use either SMB or NFS, depending on the operating system of the DB server virtual machine.

For a Linux OS, the **/sapmnt** directory is shared via NFS by using the rw and no\_root\_squash options. The defaults are ro and root\_squash, which might lead to problems when you install the database instance. In the final step, the installation builds the primary application server instance. After the primary application server instance is installed, you can use tools such as SAP GUI to verify that the installation finished correctly.

The walkthrough in [Installation of SAP HANA on Azure Virtual Machines](/azure/virtual-machines/workloads/sap/hana-get-started) demonstrates setting up a single-instance SAP HANA on Azure Virtual Machines when you install SAP NetWeaver 7.5 and SAP HANA 1.0 SP12 manually.

> [!NOTE]
> Regardless of the configuration and deployment methodology, it's essential that the final virtual machine infrastructure is verified by using the SAP HANA hardware and cloud measurement tools (HCMT). These results should be validated with relevant subject matter experts to ensure the virtual machines are capable of operating production workloads and are thus certified by SAP as well. Prior to August 1st, 2019, the verification was carried out using the SAP HANA Hardware Configuration Check Tool (HWCCT). The HWCCT has now been replaced by the HCMT for deployment of SAP HANA 2.0 or higher. For more information, see [SAP Note \#2493172](https://me.sap.com/notes/2493172).
