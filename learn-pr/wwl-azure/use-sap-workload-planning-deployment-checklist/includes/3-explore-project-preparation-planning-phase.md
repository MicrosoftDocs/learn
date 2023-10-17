

This phase should produce the following set of items:

## High-level design document containing

- An inventory of the planned (and, in the migration scenario, the existing) SAP landscape.
- A Responsibility Assignment Matrix (RACI) that defines the responsibilities and assignments of all parties involved in project delivery.
- A high-level solution architecture.
- Selection of target Azure regions. Note that resource availability isn't consistent across regions.
- Networking architecture that provides connectivity between on-premises and Azure. You should consider aligning your design with the Virtual Datacenter blueprint for Azure.
- Security principles for running high business impact data in Azure. You should consider referencing Azure Security Documentation.

## Technical design document containing

- **A solution block diagram**.
- **Sizing of compute, storage, and networking components in Azure**. For SAP sizing of Azure VMs, consult [SAP Note \#1928533](https://launchpad.support.sap.com/#/notes/1928533).
- **High Availability and Disaster Recovery architecture**.

  - The architecture should be based on the business provided RTO and RPO.
  - For high availability within the same zone, identify the capabilities of the target DBMS product. Most DBMS offer synchronous hot standby, recommended for production systems. In addition, check the SAP related documentation for the different databases starting with [Considerations for Azure Virtual Machines DBMS deployment for SAP workload](/azure/virtual-machines/workloads/sap/dbms_guide_general) . Note that using Windows Failover Cluster Service with shared disk configuration for the DBMS layer is NOT supported. Instead, consider solutions such as:

    - SQL Server Always On
    - Oracle Data Guard
    - HANA System Replication
  - For disaster recovery of the DBMS tier, across Azure regions, identify product-specific options offered by the DBMS vendors. Most of them support asynchronous replication or log-shipping.
  - For the SAP application layer, define whether you'll run your business regression test systems (which should match your production systems), in the same Azure region or the DR region. In the latter case, you could leverage the regression systems as the DR targets for production.
  - If you decide not to leverage the regression test systems as the DR targets, consider using Azure Site Recovery as the method of replicating the SAP application layer into the Azure DR region. For more information, refer to the Microsoft doc [Set up disaster recovery for a multi-tier SAP NetWeaver app deployment](/azure/site-recovery/site-recovery-sap).
  - If you decide to use a combined HA/DR configuration that leverages Azure Availability Zones, ensure that the Azure region you select supports Availability Zones. Note that cross zone latency is higher comparing with latency between Azure VMs that are part of the same availability set.
- **Detailed inventory of OS, DB, Kernel, and SAP support pack versions**. SAP support for a given configuration in on-premises scenarios does not imply that the same configuration is supported by Azure VMs. Depending on the outcome, you might have to upgrade some of the software components. For details regarding supported configuration, refer to the following SAP Notes:

  - [SAP Note \#1928533](https://launchpad.support.sap.com/#/notes/1928533). The note also provides SAP sizing of SAP-supported Azure VM SKUs.
  - [SAP Note \#2039619](https://launchpad.support.sap.com/#/notes/2039619). The note provides the Oracle support matrix on Azure, based on which, Oracle only supports Windows and Oracle Linux as guest OS in Azure VMs. This support statement applies to the SAP application layer running SAP instances as well. However, Oracle does not support high availability for SAP Central Services in Oracle Linux through Pacemaker. If you require high availability for ASCS on Oracle Linux, you need to leverage SIOS Protection Suite for Linux. For detailed SAP certification data, check [SAP Note \#1662610](https://launchpad.support.sap.com/#/notes/1662610). For Windows, the SAP supported Windows Failover Cluster Failover solution for SAP Central Services is supported in conjunction with Oracle as DBMS layer.
  - [SAP Note \#2235581](https://launchpad.support.sap.com/#/notes/2235581), which provides the support matrix for SAP HANA on the different OS releases.
  - The [SAP HANA Hardware Directory](https://www.sap.com/dmc/exp/2014-09-02-hana-hardware/enEN/#/solutions?filters=iaas).
- **3-Tier designs for SAP production systems** (strongly recommended over 2-Tier designs). Combining (A)SCS and application servers on the same Azure VM isn't recommended. Using multi-SID cluster configurations for SAP Central Services is supported with Windows as guest OS on Azure. Whereas SAP Central Services multi-SID cluster configurations are not supported with Linux operating systems on Azure. Documentation for the Windows guest OS case can be found in the following articles:

  - [SAP ASCS/SCS instance multi-SID high availability with Windows Server Failover Clustering and shared disk on Azure](/azure/virtual-machines/workloads/sap/sap-ascs-ha-multi-sid-wsfc-shared-disk)
  - [SAP ASCS/SCS instance multi-SID high availability with Windows Server Failover Clustering and file share on Azure](/azure/virtual-machines/workloads/sap/sap-ascs-ha-multi-sid-wsfc-file-share)

## An inventory of all SAP interfaces

Include all SAP and non-SAP interfaces.

## Design of foundational services, including

- Authentication and name resolution services (Active Directory and DNS).
- Network topology.
- Resource Group topology.
- Role-based access controls for management of infrastructure and applications.
- Tagging strategy.
- Naming Convention for infrastructure components, including Azure VMs.

## Microsoft Premier Support Contract reference

Microsoft Premier Support Contract reference – including direct contact with MS Technical Account Manager (TAM). For SAP support requirements, refer to [SAP Note \#2015553](https://launchpad.support.sap.com/#/notes/2015553).

## List of Azure subscriptions

The list of Azure subscriptions and their respective core quotas. If necessary, open support requests to increase quotas of Azure subscriptions.

## Data reduction and data migration plan

Data reduction and data migration plan for transferring SAP data into Azure (in migration scenarios). For SAP NetWeaver systems, SAP offers guidelines on how to keep the volume of many data limited.

## Automated deployment approach

The goal of automation in infrastructure deployments on Azure is to ensure deterministic results. Many customers use PowerShell or Azure CLI based scripts and Azure Resource Manager templates. But there are other open-source technologies (such as Terraform and Ansible) that can be used to deploy Azure infrastructure for SAP and even install SAP software. Examples can be found on GitHub at:

- [SAP on Azure Deployment Automation Framework](https://github.com/Azure/sap-automation)
  
> [!NOTE]
> Define a regular design and deployment review cadence between you as a customer, system integrator, Microsoft, and other involved parties.
