The three-tier SAP Azure Resource Manager templates referenced earlier support high availability scenarios. To prepare a highly available infrastructure, when deploying the templates, set the **SYSTEMAVAILABILITY** parameter to **HA**.

The templates create:

- Azure VMs (and, if applicable, their managed disks)
- Network cards for all virtual machines, with associated IP addresses
- Availability groups for:

  - SAP Application Server virtual machines
  - SAP ASCS/SCS cluster virtual machines
  - DBMS cluster virtual machines

- Azure internal load balancer:

  - With all ports for the ASCS/SCS instance and IP address
  - With all ports for the SQL Server DBMS and IP address
  
- Network security group with an open external Remote Desktop Protocol (RDP) port to the first SAP Application Server virtual machine

All IP addresses of the network cards and Azure internal load balancers are dynamic by default. You need to change them to static IP addresses.
