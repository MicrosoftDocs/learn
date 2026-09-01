The HANA System Replication (HSR) functionality enables SAP HANA databases to synchronously or asynchronously replicate from a primary SAP HANA system to a secondary SAP HANA system. HSR uses application-level synchronization. The primary and the secondary SAP HANA systems have the same storage requirements, except for the following differences:

- Both the primary and the secondary SAP HANA databases have the same SAP ID (SID), but their volume names need to be different.
- The secondary SAP HANA system might be in a different location, typically a different zone, or region. As such, the proximity placement group (PPG, availability set) is different.

The following diagram illustrates the concept of HSR:

:::image type="content" source="../media/hana-system-replication-architecture.png" alt-text="Diagram showing SAP HANA System Replication architecture with primary and secondary nodes, each with five storage volumes." border="true" lightbox="../media/hana-system-replication-architecture.png":::

To enable HSR, the configuration of the secondary SAP HANA system must be identical to the primary SAP HANA system. That is, if the primary system is a single-host HANA system, then the secondary SAP HANA system also needs to be a single-host system. The same applies for multiple-host systems.

The workflow for creating a secondary SAP HANA system is similar to the workflow for creating the primary SAP HANA system. However, a key difference is that you need to select the **HSR secondary** option in the SAP HANA tab to indicate that you're creating a replication secondary system for the SAP HANA system.
