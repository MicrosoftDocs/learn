This section lists the key steps for a manual, single-instance SAP HANA installation when you use SAP SWPM to perform a distributed SAP NetWeaver 7.5 installation.

1. Create an Azure virtual network.
2. Deploy two Azure Virtual Machines using the Azure Resource Manager deployment model. This example uses SUSE Linux Enterprise Server for SAP Applications 12 SP3.
3. Attach Standard or Premium data disks to the application server virtual machine.
4. Attach Premium data disks to the HANA DB server virtual machine.
5. Create striped volumes using the attached disk. Use either logical volume management (LVM) or the multiple-devices administration (MDADM) tool at the OS level inside the virtual machine.
6. Create XFS file systems on the attached disks or logical volumes.
7. Mount the new volumes at the OS level. Use separate volumes for the SAP binaries, **/sapmnt** directory, and backups. On the SAP HANA DB server, mount the XFS file systems on the premium storage disks as **/hana** and **/usr/sap**. This process is necessary to prevent the root file system from filling up. The root file system isn't large on Linux Azure Virtual Machines.
8. Add entries representing Azure Virtual Machines to the **/etc/hosts** file.
9. Add the `nofail` parameter to the **/etc/fstab** file.
10. Set Linux kernel parameters according to the Linux OS release you use.
11. Add swap space.
12. Optionally, install a graphical desktop on the test virtual machines. Otherwise, use a remote SAPinst installation.
13. Download the SAP software from the SAP Service Marketplace.
14. Install the SAP ASCS instance on the app server virtual machine.
15. Share the **/sapmnt** directory using NFS. The application server virtual machine is the NFS server.
16. Install the database instance by using SWPM on the DB server virtual machine.
17. Install the primary application server (PAS) on the application server virtual machine.
18. Start SAP Management Console (SAP MC). Connect with SAP GUI or HANA Studio.
