

In addition to migrating on-premises VMs, Contoso IT staff are also planning how best to migrate storage. They've asked you to research the Windows Server Migration Service.

The Windows Server Storage Migration Service is part of Windows Admin Center (WAC). This service automates the process of migrating from legacy Windows Server versions to supported platforms, whether on-premises or to Azure.

Storage migration has always been a difficult process to perform because the most vital data is usually the data that is changing most frequently. Trying to move data while it is being accessed requires careful planning and management.

## Why use Storage Migration Service?

You'll want to use Storage Migration Service if you have a server (or multiple servers) that you want to migrate to newer hardware or VMs. Storage Migration Service is designed to help with this by:

- Inventorying multiple servers and their data.
- Rapidly transferring files, file shares, and security configuration from the source servers.
- Optionally, taking over the identity of the source servers (also known as *cutting over*) so that users and apps don't have to change anything to access existing data.
- Managing one or multiple migrations from the WAC user interface.

## How the Storage Migration Service process works

Migration is a three-step process:

1. Inventory servers to gather information about their files and configuration.
2. Transfer (copy) data from the source servers to the destination servers.
3. Perform cutting over to the new servers (optional).

The destination servers assume the source servers' former identities so that apps and users don't have to change anything. The source servers enter a maintenance state where they still contain the same files they always have (you never remove files from the source servers) but are unavailable to users and apps. You can then decommission the servers at your convenience.

## Requirements

To use Storage Migration Service, you need the following:

- A source server or failover cluster from which to migrate files and data.
- A destination server running Windows Server 2019 or Windows Server 2022 (clustered or standalone) to migrate to. You can also use Windows Server 2016 or even Windows Server 2012 R2, but both are around 50 percent slower than Windows Server 2019 or Windows Server 2022.
- An Orchestrator server running Windows Server 2019 or Windows Server 2022 to manage the migration.

> [!TIP]
> If you're migrating only a few servers and one of the servers is running Windows Server 2019 or Windows Server 2022, you can use that as the Orchestrator. If you're migrating more servers, we recommend using a separate server to function as the Orchestrator server.

- A PC or server running WAC to run the Storage Migration Service user interface, unless you prefer using Windows PowerShell to manage the migration. 

> [!NOTE]
> Microsoft strongly recommends that the Orchestrator and destination computers have at least two cores or two virtual CPUs (vCPUs), and at least 2 gigabytes (GB) of memory. Inventory and transfer operations are significantly faster with more processors and memory.

### Security requirements, the Storage Migration Service proxy service, and firewall ports

The following is the security requirements, Storage Migration Service proxy service, and firewall port settings for using the Storage Migration Service:

- You must have a migration account that is an administrator on the source computers and the Orchestrator computer.
- You must have a migration account that is an administrator on the destination computers and the Orchestrator computer.
- The Orchestrator computer must have the File and Printer Sharing (SMB-In) firewall rule enabled inbound.
- The source and destination computers must have the following firewall rules enabled inbound (though you might already have them enabled):
  - File and Printer Sharing (SMB-In)
  - Netlogon Service (NP-In)
  - Windows Management Instrumentation (DCOM-In)
  - Windows Management Instrumentation (WMI-In)
- If the computers belong to an AD DS domain, they should all belong to the same forest. The destination server must also be in the same domain as the source server if you want to transfer the source's domain name to the destination when cutting over. Cutover technically works across domains, but the fully-qualified domain name (FQDN) of the destination will be different from the source.

### Requirements for source servers

The source server must run the Windows Server OS, from Windows Server 2003 to Windows Server 2022. This includes Small Business Server versions. Note, however, that Windows Small Business Server and Windows Server Essentials are domain controllers. Storage Migration Service can't yet cut over from domain controllers, but can inventory and transfer files from them.

If the Orchestrator is running Windows Server, version 1903 or later, or if the Orchestrator is running an earlier version of Windows Server with KB4512534 installed, you can migrate the following additional source types:

- Failover clusters running Windows Server 2012, Windows Server 2012 R2, Windows Server 2016, Windows Server 2019, or Windows Server 2022
- Linux servers that use Samba. The following have been tested:
  - CentOS 7
  - Debian GNU/Linux 8
  - RedHat Enterprise Linux 7.6
  - SUSE Linux Enterprise Server (SLES) 11 SP4
  - Ubuntu 16.04 LTS and 12.04.5 LTS
  - Samba 4.8, 4.7, 4.3, 4.2, and 3.6

### Requirements for destination servers

The destination server must run one of the following operating systems:

- Windows Server, Semi-Annual Channel
- Windows Server 2022
- Windows Server 2019
- Windows Server 2016
- Windows Server 2012 R2

## Azure VM migration

WAC enables you to deploy Azure VMs, and integrate VM deployment into Storage Migration Service. Instead of manually building new servers and VMs in the Azure portal prior to deploying your workload—and possibly missing required steps and configuration—WAC can deploy the Azure VM, configure its storage, join it to your domain, install roles, and then set up your distributed system for you. 