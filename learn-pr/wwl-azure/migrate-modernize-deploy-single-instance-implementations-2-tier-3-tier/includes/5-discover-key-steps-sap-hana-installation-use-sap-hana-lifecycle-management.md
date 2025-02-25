This section lists the key steps for a manual, single-instance SAP HANA installation when you use SAP HANA database lifecycle management (HLM) to perform a distributed SAP NetWeaver 7.5 installation.

1. Create an Azure virtual network.
2. Deploy two Azure VMs using Azure Resource Manager deployment model. This example uses SUSE Linux Enterprise Server for SAP Applications 12 SP3.
3. Attach Standard or Premium data disks to the application server VM.
4. Attach Premium data disks to the HANA DB server VM.
5. Create striped volumes using the attached disk. Use either logical volume management (LVM) or a multiple-devices administration (mdadm) tool at the OS level inside the VM.
6. Create XFS file systems on the attached disks or logical volumes.
7. Mount the new volumes at the OS level. Use separate volumes for the SAP binaries, **/sapmnt** directory, and backups. On the SAP HANA DB server, mount the XFS file systems on the premium storage disks as **/hana** and **/usr/sap**. This process is necessary to prevent the root file system from filling up. The root file system isn't large on Linux Azure VMs.
8. Add entries representing Azure VMs to the **/etc/hosts** file.
9. Add the nofail parameter to the **/etc/fstab** file.
10. Set Linux kernel parameters according to the Linux OS release you use.
11. Add swap space.
12. Optionally, install a graphical desktop on the test VMs. Otherwise, use a remote SAPinst installation.
13. Download the SAP software from the SAP Service Marketplace.
14. Create a group, **sapsys**, with group ID 1001, on the HANA DB server VM.
15. Install SAP HANA on the DB server VM by using HANA database lifecycle manager.
16. Install the SAP ASCS instance on the app server VM.
17. Share the **/sapmnt** directory using NFS. The application server VM is the NFS server.
18. Install the database instance by using SWPM on the DB server VM.
19. Install the primary application server (PAS) on the application server VM.
20. Start SAP Management Console (SAP MC). Connect with SAP GUI or HANA Studio.
