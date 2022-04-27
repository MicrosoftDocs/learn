The console for Storage Migration Service is a desktop computer or server running Windows Admin Center. Windows Admin Center provides the user interface for configuring Storage Migration Service but doesn't manage the work. Alternatively, you can configure Storage Migration Service by using Windows PowerShell cmdlets.

## Orchestrator server

To manage the migration work, you need an orchestrator server running Windows Server 2022 or Windows Server 2019. This is the server you install the Storage Migration Service feature on. If you're migrating only one server, you can use the destination server as the orchestrator server. If you're migrating multiple servers, you should use a dedicated orchestrator server.

The orchestrator server should be in the same Active Directory Domain Services (AD DS) domain as the source and destination computers. The cutover process works across domains, but the source fully qualified domain name (FQDN) can't be migrated to a different domain.

Note: To support migrating data to or from a Windows failover cluster, you must install the Failover Clustering tools on the orchestrator server.

The minimum recommended hardware requirements for an orchestrator server are:

- 2 CPU cores

- 2 GB of memory

## Source servers

Source servers can be running Windows Server 2003 or newer versions of Windows Server. This includes Windows Small Business Server and Windows Server Essentials. However, because Windows Small Business Server and Windows Server Essentials are domain controllers, data migration is supported but server name migration isn't. Windows Server 2012 or newer failover clusters are also supported sources.

Linux servers configured with Samba are also supported sources. Tested Samba versions include 3.6, 4.2, 4.3, 4.7, and 4.8 with multiple Linux distributions.

## Destination servers

Destination servers can be running Windows Server 2012 R2 or newer. However, migration performance is approximately doubled when using Windows Server 2019 or later with the Storage Migration Service proxy installed. If you're migrating to an Azure virtual machine (VM), Storage Migration service can create the VM automatically based on specifications that you provide.

The minimum recommended hardware requirements for a destination server are:

- 2 CPU cores

- 2 GB of memory

## Security

To migrate data, the necessary firewall rules must be enabled. These firewall rules might be enabled already, but you should verify this. On the orchestrator server, you must enable the File and Printer Sharing (SMB-In) firewall rule. On source and destination servers, the following firewall rules must be enabled:

- File and Printer Sharing (SMB-In)

- Netlogon Service (NP-In)

- Windows Management Instrumentation (DCOM-In)

- Windows Management Instrumentation (WMI-In)

You can perform migrations by using a single account that is an administrator on the source, destination, and orchestrator servers. Alternatively, you can have a source migration account and a destination migration account. The source migration account is an administrator on the source and orchestrator servers. The destination migration account is an administrator on the destination and orchestrator servers.

