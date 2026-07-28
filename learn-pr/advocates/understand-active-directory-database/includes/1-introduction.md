To understand how Active Directory domain controllers store and replicate directory data and SYSVOL, you need to first understand that a domain controller maintains two operational data stores:

- A local directory database managed by the Extensible Storage Engine (ESE).
- A domain-scoped file hierarchy called the system volume (SYSVOL).

The stores support one domain but aren't one database. They use different data models, client protocols, and replication engines. A healthy result in one store doesn't prove a healthy result in the other.

:::image type="content" source="../media/two-store-architecture.svg" alt-text="Diagram showing directory clients and file clients interacting with the domain controller.":::

In this module, you'll:

- Distinguish the logical directory, local ESE database, hosted replicas, and domain-scoped SYSVOL hierarchy.
- Explain local commit, soft recovery, logical directory replication, and Distributed File System Replication (DFSR).
- Trace client access to SYSVOL and distinguish writable and read-only domain-controller behavior.
- Connect a GPO to its GPC and GPT, then classify the failing store or access path.
- Recognize supported backup, virtualization, recovery-escalation, and Windows Server 2025 database-format boundaries.
