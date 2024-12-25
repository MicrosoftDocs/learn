SAP-certified operating systems supported for SAP products on Azure Virtual Machines are listed in [SAP Note \#1928533](https://me.sap.com/notes/1928533) and, at the time of authoring, include:

- Microsoft Windows Server 2008 R2, 2012 (R2), 2016, 2019, and 2022 (including Azure Edition for Windows Server as of May 2024)
- SUSE Linux Enterprise Server 12 (SLES12) and higher
- SUSE SLES for SAP Applications (based on SLES12) and higher
- Red Hat Enterprise Linux 7 (RHEL7) and higher
- Red Hat RHEL for SAP (based on RHEL7) and higher
- Red Hat RHEL for SAP HANA (based on RHEL7) and higher
- Oracle Linux 7 (OL7)

When running SAP products on Linux, you should also review the following SAP Notes:

- [SAP Note \#2243692 - Linux on Microsoft Azure (IaaS) virtual machine SAP license issues](https://me.sap.com/notes/2243692)
- [SAP Note \#2513384 - SUSE Linux Enterprise Server for SAP Applications on Azure](https://me.sap.com/notes/2513384)
- [SAP Note \#2694118 - Red Hat Enterprise Linux HA Add-On on Azure](https://me.sap.com/notes/2694118)

> [!NOTE]
> Using multi-SID cluster configurations for SAP Central Services is supported with Windows Server as guest operating system on Azure Virtual Machines, but it's not supported with any of the Linux distributions.
