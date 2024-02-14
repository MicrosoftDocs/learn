The following tables outline Azure supported configurations and the growing list of SAP certifications.

## SAP HANA certifications

| SAP Product | Supported OS | Azure Offerings |
|-|-|-|
| Business One on HANA | SUSE Linux Enterprise | [SAP HANA Certified IaaS Platforms](https://www.sap.com/dmc/exp/2014-09-02-hana-hardware/enEN/#/solutions?filters=iaas;ve:24;v:120) |
| SAP S/4 HANA | Red Hat Enterprise Linux, SUSE Linux Enterprise | [SAP HANA Certified IaaS Platforms](https://www.sap.com/dmc/exp/2014-09-02-hana-hardware/enEN/#/solutions?filters=iaas;ve:24) |
| Suite on HANA, OLTP | Red Hat Enterprise Linux, SUSE Linux Enterprise | [SAP HANA Certified IaaS Platforms](https://www.sap.com/dmc/exp/2014-09-02-hana-hardware/enEN/#/solutions?filters=iaas;ve:24;v:125) |
| HANA Enterprise for BW, OLAP | Red Hat Enterprise Linux, SUSE Linux Enterprise | [SAP HANA Certified IaaS Platforms](https://www.sap.com/dmc/exp/2014-09-02-hana-hardware/enEN/#/solutions?filters=iaas;ve:24;v:105) |
| SAP BW/4 HANA | Red Hat Enterprise Linux, SUSE Linux Enterprise | [SAP HANA Certified IaaS Platforms](https://www.sap.com/dmc/exp/2014-09-02-hana-hardware/enEN/#/solutions?filters=iaas;ve:24;v:105) |

Be aware that SAP uses the term 'clustering' in SAP HANA Certified IaaS Platforms as a synonym for 'scale-out' and NOT for high availability 'clustering'.

## SAP NetWeaver certifications

Microsoft Azure is certified for the following SAP products, with full support from Microsoft and SAP.

| SAP Product | Guest OS | RDBMS | Virtual Machine Types |
|-|-|-|-|
| SAP Business Suite Software | Windows, SUSE Linux Enterprise, Red Hat Enterprise Linux, Oracle Linux | SQL Server, Oracle (Windows and Oracle Linux only), DB2, SAP ASE | [SAP Note \#1928533: SAP Applications on Azure: Supported Products and Azure Virtual Machine types](https://me.sap.com/notes/1928533) |
| SAP Business All-in-One | Windows, SUSE Linux Enterprise, Red Hat Enterprise Linux, Oracle Linux | SQL Server, Oracle (Windows and Oracle Linux only), DB2, SAP ASE | [SAP Note \#1928533: SAP Applications on Azure: Supported Products and Azure Virtual Machine types](https://me.sap.com/notes/1928533) |
| SAP BusinessObjects BI | Windows | N/A | [SAP Note \#1928533: SAP Applications on Azure: Supported Products and Azure Virtual Machine types](https://me.sap.com/notes/1928533) |
| SAP NetWeaver | Windows, SUSE Linux Enterprise, Red Hat Enterprise Linux, Oracle Linux | SQL Server, Oracle (Windows and Oracle Linux only), DB2, SAP ASE | [SAP Note \#1928533: SAP Applications on Azure: Supported Products and Azure Virtual Machine types](https://me.sap.com/notes/1928533) |

## Other SAP workloads supported on Azure

| SAP Product | Guest OS | RDBMS | Virtual Machine Types |
|-|-|-|-|
| SAP Business One on SQL Server | Windows | SQL Server | All NetWeaver certified virtual machine types: [SAP Note \#928839](https://me.sap.com/notes/928839) |
| SAP BPC 10.01 MS SP08 | Windows and Linux | | All NetWeaver Certified virtual machine types: [SAP Note \#2451795](https://me.sap.com/notes/2451795)
| SAP Business Objects BI platform | Windows and Linux | | [SAP Note \#2145537](https://me.sap.com/notes/2145537) |
| SAP Data Services 4.2 | | | [SAP Note \#2288344](https://me.sap.com/notes/2288344) |
| SAP Hybris Commerce Platform | Windows | SQL Server, Oracle | All NetWeaver certified virtual machine types: [Hybris Documentation](https://help.sap.com/viewer/a74589c3a81a4a95bf51d87258c0ab15/6.7.0.0/en-US/8c71300f866910149b40c88dfc0de431.html) |
| SAP Hybris Commerce Platform | SLES 12 or more recent | SAP HANA | All NetWeaver certified virtual machine types: [Hybris Documentation](https://help.sap.com/viewer/a74589c3a81a4a95bf51d87258c0ab15/6.7.0.0/en-US/8c71300f866910149b40c88dfc0de431.html) |
| SAP Hybris Commerce Platform | RHEL 7 or more recent | SAP HANA | All NetWeaver certified virtual machine types: [Hybris Documentation](https://help.sap.com/viewer/a74589c3a81a4a95bf51d87258c0ab15/6.7.0.0/en-US/8c71300f866910149b40c88dfc0de431.html) |
| SAP (Hybris) Commerce Platform 1811 and later | Windows, SLES, or RHEL | SQL Azure DB | All NetWeaver certified virtual machine types: [Hybris Documentation](https://help.sap.com/viewer/a74589c3a81a4a95bf51d87258c0ab15/1811/en-US/8c71300f866910149b40c88dfc0de431.html) |

> [!IMPORTANT]
> Both Microsoft and SAP have documentation on what is certified, but SAP should be the single source of truth for their solutions configurations, which consist of combinations of SAP product, operating system, RDBMS, and Azure Virtual Machine SKU.
