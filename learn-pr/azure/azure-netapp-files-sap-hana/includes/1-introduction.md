SAP HANA workloads are performance demanding and require submillisecond latency and high throughput numbers. These performance requirements coupled with the detailed system architecture of SAP HANA systems require thorough planning to shift SAP HANA workloads to the cloud. 

Azure NetApp Files is designed to enable shifting even the most demanding workloads to the cloud, but SAP HANA still presents challenges. With the introduction of Azure NetApp Files application volume groups for SAP HANA, there's now a solution to streamline storage volume deployments for SAP HANA. Instead of having to create storage volumes (data, log, shared, log-backup, file-backup) individually, and configure their specific placements, the application volume group feature enables you to create these volumes in a single “atomic” operation. 

Using Azure NetApp Files application volume groups for SAP HANA offers:

* Low latency and high performance volume placement over multiple storage endpoints to meet strict throughput and latency requirements as defined by SAP HANA KPIs
* Simplified, one-step deployment for all SAPA HANA volumes
* Configuration for data replication using cross-region replication and/or HANA system replication

This guide explains key concepts for planning to use SAP HANA with Azure NetApp Files including proximity placement groups to help you prepare for deploying your SAP HANA system with Azure NetApp Files.
