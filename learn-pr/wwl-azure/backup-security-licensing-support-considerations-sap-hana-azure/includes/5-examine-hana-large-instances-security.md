## Encryption of data in transit

Data transferred between HANA Large Instance and VMs are not encrypted. As an alternative, you have the option of enabling application-level encryption between the HANA DBMS and JDBC/ODBC-based applications.

## Encryption of data at rest

The storage used for HANA Large Instance allows transparent encryption of the data as it's stored on the disks. When a HANA Large Instance unit is deployed, you can enable this kind of encryption. You also can change to encrypted volumes after the deployment takes place. The move from non-encrypted to encrypted volumes is transparent and doesn't require downtime.

With the Type I class of SKUs, the volume the boot LUN is stored on is encrypted. For the Type II class of SKUs of HANA Large Instance, you need to encrypt the boot LUN with OS methods.

 -  By default, HANA Large Instances use storage encryption based on transparent data encryption (TDE) for the data at rest.
 -  Data in transit between HANA Large Instances and the virtual machines are not encrypted. To encrypt the data transfer, enable application-specific encryption. See [SAP Note \#2159014](https://launchpad.support.sap.com/#/notes/2159014).
 -  Isolation provides security between the tenants in the multi-tenant HANA Large Instance environment. Tenants are isolated using their own VLAN.
 -  Azure network security best practices provide helpful guidance.
 -  As with any deployment, operating system hardening is recommended.
 -  For physical security, access to Azure datacenters is limited to authorized personnel only. No customers can access the physical servers.
