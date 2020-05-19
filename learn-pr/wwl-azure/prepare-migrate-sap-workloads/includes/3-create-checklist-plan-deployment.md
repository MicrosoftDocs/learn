
In this section, you will review a checklist designed for customers moving SAP NetWeaver and S/4HANA applications to Azure infrastructure as a service. Throughout the duration of the project, customers should frequently review the checklist. It's important to note that many of the checkpoints are completed at the beginning of the project and during the planning phase.

Review the checklist at key milestones during your project. Doing so allows you to detect small problems before they become large problems. You will also have opportunities to re-engineer and test the necessary changes. Do not consider this checklist complete. Depending on your situation, you might need to perform additional checks.

The checklist does not include tasks that are independent of Azure. For example, SAP application interfaces may change during the transition to the Azure platform or to a hosting provider.

This checklist can also be used for systems that are already deployed. New features, like Write Accelerator and Availability Zones, and new VM types might have been added since you deployed. So it's useful to review the checklist periodically to ensure you're aware of new features in the Azure platform.

In general, when initiating a project to deploy SAP workloads to Azure, you should divide it into the following six phases:

* Project preparation and planning

* Pilot

* Non-production

* Production preparation

* Go Live

* Post production

### Project preparation and planning phase

This phase should produce the following set of items: 

1. High-Level Design Document containing:

    * An inventory of the planned (and, in the migration scenario, the existing) SAP landscape.

    * A Responsibility Assignment Matrix (RACI) which defines the responsibilities and assignments of all parties involved in project delivery.

    * A high-level solution architecture.

    * Selection of target Azure regions. Resource availability is not consistent across regions.

    * Networking architecture that provides connectivity between on-premises and Azure. Consider aligning your design with Virtual Datacenter blueprint for Azure.

    * Security principles for running high business impact data in Azure. Consider referencing Azure Security Documentation.

2. Technical Design Document containing:

    * **A solution block diagram**

    * **Sizing of compute, storage and networking components in Azure**. For SAP sizing of Azure VMs, consult SAP support note #1928533

    * **High Availability and Disaster Recovery architecture**

        * The architecture should be based on the business provided RTO and RPO 

        * For high availability within the same zone, identify the capabilities of the target DBMS product. Most DBMS offer synchronous hot standby, recommended for production systems. Using Windows Failover Cluster Service with shared disk configuration for the DBMS layer is NOT supported. Instead consider solutions such as 

            * SQL Server AlwaysOn

            * Oracle Data Guard

            * HANA System Replication

        * For disaster recovery of the DBMS tier, across Azure regions, identify product-specific options offered by the DBMS vendors. Most of them support asynchronous replication or log-shipping.

        * For the SAP application layer, define whether you will run your business regression test systems (which should match your production systems), in the same Azure region or the DR region. In the latter case, you could leverage the regression systems as the DR targets for production.

        * If you decide not to leverage the regression test systems as the DR targets, consider using Azure Site Recovery as the method of replicating the SAP application layer into the Azure DR region. 

        * If you decide to use a combined HA/DR configuration that leverages Azure Availability Zones, ensure that the Azure region you select supports Availability Zones. Cross zone latency is higher comparing with latency between Azure VMs that are part of the same availability set. 

    * **Detailed inventory of OS, DB, Kernel, and SAP support pack versions**. SAP support for a given configuration in on-premises scenarios does not imply that the same configuration is supported by in Azure VMs. Depending on the outcome, you might have to upgrade some of the software components. For details regarding supported configuration, refer to the following SAP Notes:
        * SAP Note #1928533 (as described in the previous module). The note also provides SAP sizing of SAP-supported Azure VM SKUs.

        * SAP Note #2039619 (as described in the previous module). The note provides the Oracle support matrix on Azure, based on which, Oracle only supports Windows and Oracle Linux as guest OS in Azure VMs. This support statement applies for the SAP application layer running SAP instances as well. However, Oracle does not support high availability for SAP Central Services in Oracle Linux through Pacemaker. 

    * **3-Tier designs for SAP production systems** (strongly recommended over 2-Tier designs). Combining (A)SCS and application servers on the same Azure VM is not recommended. Using multi-SID cluster configurations for SAP Central Services is supported with Windows as guest OS on Azure. Whereas SAP Central Services multi-SID cluster configurations are not supported with Linux operating systems on Azure. 

3. An inventory of all SAP interfaces (SAP and non-SAP).

4. Design of Foundational Services, including：

    * Authentication and name resolution services (Active Directory and DNS)

    * Network topology

    * Resource Group topology

    * Role-based access controls for management of infrastructure and applications

    * Tagging strategy

    * Naming Convention for infrastructure components, including Azure VMs

5. Microsoft Premier Support Contract reference – Including direct contact with MS Technical Account Manager (TAM). 

6. The list of Azure subscriptions and their respective core quotas. If necessary, open support requests to increase quotas of Azure subscriptions.

7. Data reduction and data migration plan for transferring SAP data into Azure (in migration scenarios). For SAP NetWeaver systems, SAP offers guidelines on how to keep the volume of many data limited.

8. Automated deployment approach. The goal of automation in infrastructure deployments on Azure is to ensure deterministic results. Many customers use PowerShell or Azure CLI-based scripts and Azure Resource Manager templates. But there are other open-source technologies (such as Terraform and Ansible) that can be used to deploy Azure infrastructure for SAP and even install SAP software. 
