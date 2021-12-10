Upgrading existing domains and an existing forest so that domain controllers are running Windows Server 2022 requires you perform the following general tasks:

- Add new member servers running Windows Server 2022 to each domain in the forest

- Prepare the forests and domains using adprep. Even though the promotion of a Windows Server 2022 computer to domain controller performs this task, best practice is to perform it manually in complex topologies and allow replication to prefer.

- Promote member servers running Windows Server 2022 to become domain controllers

- Transfer Flexible Single Master Operations (FSMO) roles from existing domain controllers to the new Windows Server 2022 domain controllers

- Demote all domain controllers running prior versions of Windows Server to member server

- Upgrade the domain and forest functional levels if they are not already set to Windows Server 2016

## Add new member servers running Windows Server 2022

Adding member servers running Windows Server 2022 to an existing domain is a straightforward operation. Just ensure that domains and forests are running at the Windows Server 2008 domain and forest functional level or higher. You need to perform this check because few organizations have historically introduced new domain controllers that run newer versions of the Windows Server operating system, but never upgraded the domain functional level. For example, some organizations have domain controllers running Windows Server 2016 but the domain and forest functional levels are set to Windows Server 2003. You can check the domain and forest functional level using the **Get-ADDomain** and **Get-ADForest** PowerShell cmdlets.

> [!NOTE]
> You should plan to add at least two member servers running Windows Server 2022 to each domain in the forest as you should always have at least two domain controllers in each domain in case one of them fails. 

Configure the Windows Server 2022 members servers that you intend to promote to domain controllers with static IP addresses. Domain controllers are critical parts of an on-premises network infrastructure. While you can configure a DHCP reservation to ensure these computers always had the same IP address, statically assigning IP addresses reduces the number of dependencies each domain controller has on other systems to function. Assign the computers that will host the domain controller roles with meaningful domain controller names rather than the random names assigned by the Windows Server installation process.

> [!NOTE]
> While you can perform an in-place upgrade of existing domain controllers to Windows Server 2022, best practice is to deploy fresh servers to function as new domain controllers.

## Prepare the forests and domains

There are two phases to preparing the forest and domains. The first is to verify that you are not using FRS for sysvol replication. Since Windows Server 2008, all all Windows Server domain controllers have supported DFS for sysvol replication. However, a few organizations that have used the same Active Directory deployment since Windows 2000 Server or Windows Server 2003 were hosting Active Directory may never have switched the sysvol replication mechanism as this was always a manual process. You can check if FRS is in use using the command `dfsmig /getglobalstate` from an elevated command prompt or PowerShell session on a domain controller. A status of Eliminated indicates that file replication service (FRS) isn't in use.

The second phase is preparing the forest and the domain using adprep. While the adprep routines will run automatically when you promote a member server running Windows Server 2022 to become a domain controller, in complex topologies you should consider updating the forest and domain and waiting for replication to occur prior to promoting the first Windows Server 2022 computer to become a domain controller. To prepare the forest, you must be a member of Enterprise Admins and Schema Admins. To prepare a domain, you must be a member of Domain Admins.

To prepare the forest, run:

Adprep /forestprep

To prepare each domain in the AD DS forest, run:

Adprep /domainprep

## Promote member servers to domain controllers

Once you have performed the forest and domain preparation steps and replication has occurred across your forest, you can promote the Windows Server 2022 member server to domain controller. Promote them by running the following PowerShell commands:

```powershell
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

Install-ADDSDomainController -CreateDnsDelegation:$false -InstallDns:$true -DomainName "tailwindtraders.com" -SiteName "Default-First-Site-Name" -ReplicationSourceDC "DC01.tailwindtraders.com" -DatabasePath "C:\Windows\NTDS" -LogPath "C:\Windows\NTDS" -SysvolPath "C:\Windows\SYSVOL" -Force:$true

```

The first command installs the necessary role services. The relevant parts that you want to customize of the second command are the domain name, site name and replication source domain controller.

## Transfer FSMO roles from existing domain controllers

Before you remove domain controllers running previous versions of Windows Server, you need to understand how they're being used. The most common task you’ll need to perform is transferring the FSMO roles. To locate the domain and forest specific FSMO roles, run the following PowerShell commands:

```powershell
Get-ADDomain | Select-Object InfrastructureMaster, RIDMaster, PDCEmulator

Get-ADForest | Select-Object DomainNamingMaster, SchemaMaster

```

To move the FSMO roles to a new domain controller, use the following command:

```powershell
Move-ADDirectoryServerOperationMasterRole -Identity TargetDC -OperationMasterRole SchemaMaster, DomainNamingMaster, PDCEmulator, RIDMaster, InfrastructureMaster

```

> [!NOTE]
> You should distribute FSMO roles across multiple domain controllers in each domain rather than locating them all on a single domain controller.

Plan for updating any clients using those servers for services other than Windows authentication. For example, if an application is configured to use a specific domain controller for Lightweight Directory Access Protocol (LDAP) authentication, you must reconfigure the application to use a different domain controller. DNS is another common service provided by domain controllers that you should consider where removing a computer that functioned as a domain controller.

> [!NOTE]
> Once you remove the existing domain controllers running earlier versions of the Windows Server operating system, you can assign the IP addresses of the earlier domain controller to the new domain controllers running Windows Server 2022.

## Demote all domain controllers running prior versions of Windows Server

Once you have promoted the Windows Server 2022 domain controllers, you should demote the existing domain controllers running earlier versions of the Windows Server operating system. Demoting a domain controller removes this role from the computer, returning it to a standard member server role. If the domain controller you need to demote has the Windows Server 2008 R2 or earlier operating system installed, you will need to use the dcpromo wizard to remove Active Directory Domain Services. If the domain controller you need to demote is running the Windows Server 2012 or later operating system, you can run the following PowerShell command:

```powershell
Uninstall-ADDSDomainController -DemoteOperationMasterRole -RemoveApplicationPartition

```

## Upgrade the domain and forest functional level

Once you have removed the existing domain controllers running earlier versions of the Windows Server operating systems, you should raise the domain and forest functional level. Even though Windows Server 2022 is the most recent version of Windows Server, Windows Server 2016 is the highest domain and forest functional level presently supported by Active Directory. Windows Server 2022 and Windows Server 2019 do not introduce new domain and forest functional levels.

> [!NOTE]
> Even if you have Windows Server 2016 domain controllers, you should update your domain controllers to Windows Server 2022. This is because it is best security practice to always have domain controllers running latest version of the Windows Server operating system.

To upgrade the domain and forest functional level, run the following PowerShell commands:

```powershell
Set-ADDomainMode -identity tailwindtraders.com -DomainMode Windows2016Domain

Set-ADForestMode -Identity tailwindtraders.com -ForestMode Windows2016Forest

```

