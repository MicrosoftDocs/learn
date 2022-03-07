HANA Large Instances support a variety of architectural patterns to account for a wide range of business requirements. The supported scenarios include:

 -  **Single node with one SID**: This topology supports one node in a scale up configuration with one SID.
 -  **Single node MCOS**: This topology supports one node in a scale up configuration with multiple SIDs.
 -  **Single node with disaster recovery (Normal)**: This topology supports one node in a scale up configuration with one or multiple SIDs with the storage-based replication to the disaster recovery (DR) site for a primary SID.
 -  **Single node with DR (Multipurpose)**: This topology supports one node in a scale up configuration with one or multiple SIDs with the storage-based replication to the DR site for a primary SID. At the DR site, HLI unit is used for QA instance while production operations are running from the primary site. At the time of DR failover (or failover test), QA instance at DR site is taken down.
 -  **HANA System Replication with STONITH**: This topology support two nodes for the HANA System Replication (HSR) configuration. This configuration is only supported for single HANA instances on a node, which means that MCOS scenarios are not supported. At the time of authoring, this architecture is available only on Linux SUSE.
 -  **HSR with DR (Normal / Multipurpose)**: This topology support two nodes for the HANA System Replication (HSR) configuration. Both the normal and multipurpose DR is supported. These configurations are only supported for single HANA instances on a node, which means that MCOS scenarios are not supported.
 -  **Host auto failover (1+1)**: This topology supports two nodes in a host auto failover configuration. There is one node with leading/worker role and other as a standby. SAP Supports this scenario only for S/4 HANA. For details, refer to OSS note “2408419 - SAP S/4HANA - Multi-Node Support”
 -  **Scale-out with standby**: This topology supports multiple nodes in a scale-out configuration. There is one node with leading role, one or more nodes with worker role, and one or more nodes as standby.
 -  **Scale-out without standby**: This topology supports multiple nodes in a scale-out configuration. There is one node with leading role, and one or mode nodes with worker role.
 -  **Scale-out with DR**: This topology supports multiple nodes in a scale-out with a DR. Both normal and multipurpose DR are supported. You can request this topology with or without the standby node.

These patterns focus on infrastructure, so customers should consult SAP or their implementation partners regarding HANA deployment. The patterns are fully compliant with the TDI (Tailored Data Integration) design and supported by SAP. Each pattern focuses on two infrastructure components:

 -  **Ethernet**: each physical server is pre-configured with several ethernet interfaces:
    
     -  **A**: This interface is used for/by the client access.
     -  **B**: This interface is used for the node to node communication. This interface is configured on all the servers (irrespective of the topology requested) but only used for the scale-out scenarios.
     -  **C**: This interface is used for the node to the storage connectivity.
     -  **D**: This interface is used for the Node to ISCSI device connection for STONITH setup. This interface is only configured when the HSR setup is requested.
    
    You use the interfaces based on the topology configured on the HLI unit. For example, the interface “B” is set up for node to node communication, which is useful when you have a scale-out topology configured. In the case of single node scale-up configuration, this interface is not used. If needed, you can define additional NIC cards on your own. However, the configuration on the existing NICs cannot be changed.
 -  **Storage**: Storage is preconfigured based on the topology requested. The volume sizes and mountpoint vary based on the number of servers, SKUs, and topology configured. As mentioned earlier, if more storage is required, you can purchase it in 1-TB increments.
