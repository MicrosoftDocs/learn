You can also prepare the infrastructure and configure SAP for multi-SID. For example, you can add an extra SAP ASCS/SCS instance into an existing cluster configuration. If you want to create a new multi-SID cluster, you can use the multi-SID quickstart templates on GitHub. To create a new multi-SID cluster, you must deploy the following three templates:

- ASCS/SCS template
- Database template
- Application servers template

## ASCS/SCS template

The ASCS/SCS template deploys two virtual machines that you can use to create a Windows Server failover cluster that hosts multiple ASCS/SCS instances.

The template deploys one Azure load balancer instance, which supports multiple SAP systems:

- The ASCS instances are configured for instance number 00, 10, 20...
- The SCS instances are configured for instance number 01, 11, 21...
- The ASCS Enqueue Replication Server (ERS) (Linux only) instances are configured for instance number 02, 12, 22...
- The SCS ERS (Linux only) instances are configured for instance number 03, 13, 23...

The load balancer contains 1 VIP(s) (2 for Linux), 1x VIP for ASCS/SCS, and 1x VIP for ERS (Linux only).

The following list contains all load balancing rules (where x is the number of the SAP system, for example, 1, 2, 3...):

- Windows-specific ports for every SAP system: 445, 5985
- ASCS ports (instance number x0): 32x0, 36x0, 39x0, 81x0, 5x013, 5x014, 5x016
- SCS ports (instance number x1): 32x1, 33x1, 39x1, 81x1, 5x113, 5x114, 5x116
- ASCS ERS ports on Linux (instance number x2): 33x2, 5x213, 5x214, 5x216
- SCS ERS ports on Linux (instance number x3): 33x3, 5x313, 5x314, 5x316

The load balancer is configured to use the following probe ports (where x is the number of the SAP system, for example, 1, 2, 3...):

- ASCS/SCS internal load balancer probe port: 620x0
- ERS internal load balancer probe port (Linux only): 621x2

## Database template

The database template deploys one or two virtual machines that you can use to install the relational database management system (RDBMS) for one SAP system. For example, if you deploy an ASCS/SCS template for five SAP systems, you need to deploy this template five times. The template supports SQL Server and SAP HANA.

## Application servers template

The application servers template deploys two or more virtual machines that can be used as SAP Application Server instances for one SAP system. For example, if you deploy an ASCS/SCS template for five SAP systems, you need to deploy this template five times.
