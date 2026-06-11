Distributed File Systems Namespaces, commonly referred to as DFS Namespaces or DFS-N, is a Windows Server role that is widely used to simplify the deployment and maintenance of SMB file shares in production. DFS-N enables you to provide a layer of indirection between the UNC path of your file shares and the actual file shares themselves.

If you already have a DFS Namespace in place, no special steps are required to use it with Azure NetApp Files. This functionality applies to the SMB side of Azure NetApp Files dual-protocol volumes.

| File share type | SMB | NFS | dual-protocol |
| --- | --- | --- | --- |
| Azure NetApp Files | Yes | No | Yes |

### Namespace types

DFS Namespaces provides three namespace types:

- **Domain-based namespace**:
  A namespace hosted as part of your Windows Server AD domain. Namespaces hosted as part of AD have a UNC path containing the name of your domain, for example, \\contoso.com\shares\myshare, if your domain is contoso.com. Domain-based namespaces support larger scale limits and built-in redundancy through AD. Domain-based namespaces can't be a clustered resource on a failover cluster.

- **Standalone namespace**:
  A namespace hosted on an individual server or a Windows Server failover cluster, not hosted as part of Windows Server AD. Standalone namespaces have a name based on the name of the standalone server, such as \\MyStandaloneServer\shares\myshare, where your standalone server is named MyStandaloneServer. Standalone namespaces support lower scale targets than domain-based namespaces but can be hosted as a clustered resource on a failover cluster.

- **Standalone namespace with root consolidation**:
  One or more namespaces hosted on an individual server or on a Windows Server failover cluster, not hosted as part of Windows Server AD. Standalone namespaces with root consolidation have a UNC path that matches the name of the old file server you would like to take over, such as \\oldserver, where your namespace is named #oldserver. Standalone namespaces support lower scale targets than domain-based namespaces but can be hosted as a clustered resource on a Windows Server failover cluster.

### Requirements

To use DFS Namespaces with Azure NetApp Files, you must have the following resources:

- An Active Directory domain. This domain can be hosted anywhere you like: an on-premises environment, an Azure virtual machine (VM), or even in another cloud.
- A Windows Server that can host the namespace. For domain-based namespaces, a common deployment pattern is to use the Active Directory domain controller to host the namespaces, however the namespaces can be set up from any server with the DFS Namespaces server role installed. DFS Namespaces are available on all supported Windows Server versions.
- For namespace root consolidation, Active Directory domain controllers can't be used to host the namespace. It's required to use a dedicated standalone Windows Server or a Windows Server failover cluster to host the namespace(s).
- One or more Azure NetApp Files SMB file shares hosted in a domain-joined environment.

### Configure a DFS Namespace with Azure NetApp Files SMB volumes

If you don't need to take over an existing legacy file server, a domain-based namespace is recommended. Domain-based namespaces are hosted as part of AD and have a UNC path containing the name of your domain, for example, `\\contoso.com\corporate\finance`, if your domain is contoso.com. The following image shows an example of this architecture.

:::image type="content" source="../media/dfs-namespace-architecture.png" alt-text="Diagram that shows a DFS Namespace with Azure NetApp Files Architecture." border="true" lightbox="../media/dfs-namespace-architecture.png":::

### Configure folders and folder targets

For a namespace to be useful, it must have folders and folder targets. Each folder can have one or more folder targets, which are pointers to the SMB file share(s) that host that content. When users browse a folder with folder targets, the client computer receives a referral that transparently redirects the client computer to one of the folder targets. You can also have folders without folder targets to add structure and hierarchy to the namespace.

### Take over existing server names with root consolidation

An important use for DFS Namespaces is to take over an existing server name for the purposes of refactoring the physical layout of the file shares.

Traditionally, end user familiarity and document-linking limit your ability to consolidate file shares from disparate file servers together on one host, but the DFS Namespace root consolidation feature allows you to stand-up a single server or failover cluster to take over multiple server names and route to the appropriate Azure NetApp Files share name(s).

Although useful for various datacenter migration scenarios, root consolidation is especially useful for adopting Azure NetApp Files shares because Azure NetApp Files shares don't allow you to keep existing on-premises server names.

Root consolidation may only be used with standalone namespaces. If you already have an existing domain-based namespace for your file shares, you don't need to create a root consolidated namespace.

For a highly available architecture please work with your Microsoft technical team to configure Windows Server failover clustering and an Azure Load Balancer as required. The following image shows an example of a highly available architecture.

:::image type="content" source="../media/root-consolidation-high-availability.png" alt-text="Diagram that shows a highly available architecture for Azure DFS Namespace Migration to Azure NetApp Files share name." border="true" lightbox="../media/root-consolidation-high-availability.png":::
