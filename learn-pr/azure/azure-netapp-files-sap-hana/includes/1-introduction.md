SAP HANA workloads are performance demanding and require sub-millisecond latency and high throughput numbers. These performance requirements coupled with the detailed system architecture of SAP HANA systems make it difficult to shift SAP HANA workloads to the cloud. 

Azure NetApp Files has been designed to shift even the most difficult workloads to the cloud, but SAP HANA still presented difficulties. With the introduction of application volume groups for Azure NetApp Files, there is now a solution to streamline SAP HANA deployments. Instead of having to create individual volumes (data, log, shared, log-backup, file-backup) individually, and configure their specific placements, application volume groups enable you to create these volumes in a single “atomic” operation. 

Azure NetApp Files application volume groups offer:

* Low latency and high performance
* Simplified, one-step configuration for all SAPA HANA volumes
* Configuration for data replication using cross-region replication or HANA system replication

This guide explains key concepts for planning to use SAP HANA with Azure NetApp Files including proximity placement groups to help you prepare for deploying your SAP HANA system to Azure NetApp Files.
