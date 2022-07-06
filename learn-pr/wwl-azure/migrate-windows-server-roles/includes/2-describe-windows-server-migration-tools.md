Windows Server Migration Tools are a set of Windows PowerShell cmdlets that migrate configuration information and data from a source server to a destination server. This is done primarily to migrate server roles and features from a server being retired to a new server running a newer operating system.

Roles and features that you can migrate include:

- Active Directory Certificate Services

- DHCP

- DNS

- Network Policy Server

- Remote Access

- IP configuration

- Local users and groups

> [!IMPORTANT]
> Although Windows Server Migration Tools can also be used to migrate file shares, you should use the Storage Migration Service instead.
Source servers must be running Windows Server 2008 or newer. However, you can't migrate from a server core installation of Windows Server that doesn't have the Microsoft .NET Framework. For example, Windows Server 2008 Server Core.

> [!WARNING]
> The language on the source and destination servers must match.
