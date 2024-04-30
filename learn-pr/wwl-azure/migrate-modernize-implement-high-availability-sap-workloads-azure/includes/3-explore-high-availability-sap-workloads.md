Resource redundancy is the general theme in highly available infrastructure solutions. For enterprises that have a less stringent SLA, single-instance Azure VMs offer an uptime SLA. In a distributed installation of the SAP application, the base installation is replicated to achieve high availability and disaster recovery. For each layer of the architecture, the high availability and disaster recovery design varies.

High availability of SAP workloads on Azure VMs can be analyzed in two different contexts:

## High availability of SAP workloads

In the case of NetWeaver-based deployments, this solution includes:

- SAP application servers
- SAP ASCS/SCS instance
- DBMS server

## High availability capabilities of Azure infrastructure

Capabilities include:

- Azure VM restart capability (playing an important role in single-VM scenarios)
- High availability of compute (VMs), network, and storage, based on:

  - Availability Sets
  - Availability Zones
