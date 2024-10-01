Resource redundancy is the general theme in highly available infrastructure solutions. For enterprises that have a less stringent SLA, single-instance Azure Virtual Machines offer an uptime SLA. In a distributed installation of the SAP application, the base installation is replicated to achieve high availability and disaster recovery. For each layer of the architecture, the high availability and disaster recovery design varies.

High availability of SAP workloads on Azure Virtual Machines can be analyzed in two different contexts:

## High availability of SAP workloads

In the case of NetWeaver-based deployments, this solution includes:

- SAP application servers
- SAP ASCS/SCS instance
- DBMS server

## High availability capabilities of Azure infrastructure

Capabilities include:

- Azure Virtual Machine restart capability (playing an important role in single-virtual machine scenarios)
- High availability of compute, network, and storage, based on:

  - Availability Sets
  - Availability zones
