## Single-SID deployment with two clusters

- One dedicated cluster is used for the SAP ASCS/SCS instance.
- One dedicated cluster is used for the DBMS instance.
- SAP Application Server instances are deployed in their own dedicated VMs.

## Single-SID deployment with a single cluster

- One dedicated cluster is used for both the SAP ASCS/SCS instance and the DBMS.
- SAP Application Server instances are deployed in their own dedicated VMs.

## Multi-SID deployment

- One dedicated cluster is used for both the SAP ASCS/SCS SID1 instance and the SAP ASCS/SCS SID2 instance (one cluster).
- One dedicated cluster is used for DBMS SID1, and another dedicated cluster is used for DBMS SID2 (two clusters).
- SAP Application Server instances for the SAP system SID1 have their own dedicated VMs.
- SAP Application Server instances for the SAP system SID2 have their own dedicated VMs.
