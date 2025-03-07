Upgrading existing domains and an existing forest so that domain controllers are running Windows Server 2025 requires you perform the following general tasks:

- Ensure that the domain is running at the Windows Server 2016 functional level. This is necessary because you can't promote a Windows Server 2025 member server to domain controller if the domain is below the Windows Server 2016 functional level. The exception to this rule is that you can perform an in-place upgrade of a Windows Server 2012 R2 domain controller to Windows Server 2025 at the Windows Server 2012 R2 domain functional level
- Add new member servers running Windows Server 2025 to each domain in the forest
- Prepare the forests and domains using adprep. Even though the promotion of a Windows Server 2025 computer to domain controller performs this task, best practice is to perform it manually in complex topologies and allow replication to occur. If you're performing an in-place upgrade of a domain controller running Windows Server 2012 R2 to Windows Server 2025 as a way of upgrading, you'll need to prepare forests and domains using adprep before attempting the upgrade. This is the only scenario in which you may have a Windows Server 2012 R2 domain functional level with Windows Server 2025 domain controllers and you should upgrade the domain functional level to a minimum of Windows Server 2016 as soon as all Windows Server 2012 R2 domain controllers are no longer present
- Promote member servers running Windows Server 2025 to become domain controllers
- Transfer Flexible Single Master Operations (FSMO) roles from existing domain controllers to the new Windows Server 2025 domain controllers
- Demote all domain controllers running prior versions of Windows Server to member server
- Upgrade the domain and forest functional levels to Windows Server 2025

## Add new member servers running Windows Server 2025

Adding member servers running Windows Server 2025 to an existing domain is a straightforward operation. You can add a Windows Server 2025 member server to a Windows Server 2012 R2 functional level domain, but this member server cannot be promoted to domain controller unless the domain functional level is at a minimum level of Windows Server 2016. You need to perform functional level checks because some organizations have historically introduced new domain controllers that run newer versions of the Windows Server operating system, but never upgraded the domain functional level. For example, some organizations have domain controllers running Windows Server 2016 but the domain and forest functional levels are set to Windows Server 2003. You can check the domain and forest functional level using the **Get-ADDomain** and **Get-ADForest** PowerShell cmdlets.

> [!NOTE]
> You should plan to add at least two member servers running Windows Server 2025 to each domain in the forest as you should always have at least two domain controllers in each domain in case one of them fails.

Configure the Windows Server 2025 members servers that you intend to promote to domain controllers with static IP addresses. Domain controllers are critical parts of an on-premises network infrastructure. While you can configure a DHCP reservation to ensure these computers always had the same IP address, statically assigning IP addresses reduces the number of dependencies each domain controller has on other systems to function. Assign the computers that will host the domain controller roles with meaningful domain controller names rather than the random names assigned by the Windows Server installation process.

> [!NOTE]
> While you can perform an in-place upgrade of existing domain controllers to Windows Server 2025, best practice is to deploy fresh servers to function as new domain controllers. Windows Server 2025 supports in place upgrade from Windows Server 2012 R2, Windows Server 2016, Windows Server 2019, and Windows Server 2022.

## Prepare the forests and domains

There are two phases to preparing the forest and domains. The first is to verify that you are not using FRS for sysvol replication. Since Windows Server 2008, all Windows Server domain controllers have supported DFS for sysvol replication. However, a few organizations that have used the same Active Directory deployment since Windows 2000 Server or Windows Server 2003 were hosting Active Directory may never have switched the sysvol replication mechanism as this was always a manual process. You can check if FRS is in use using the command `dfsrmig /getglobalstate` from an elevated command prompt or PowerShell session on a domain controller. A status of Eliminated indicates that file replication service (FRS) isn't in use.

The second phase is preparing the forest and the domain using adprep. While the adprep routines will run automatically when you promote a member server running Windows Server 2025 to become a domain controller, in complex topologies you should consider updating the forest and domain and waiting for replication to occur prior to promoting the first Windows Server 2025 computer to become a domain controller. To prepare the forest, you must be a member of Enterprise Admins and Schema Admins. To prepare a domain, you must be a member of Domain Admins.

To prepare the forest, run:

Adprep /forestprep

To prepare each domain in the AD DS forest, run:

Adprep /domainprep

Adprep.exe is located in the \support\adprep folder of the Windows Server installation media

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

Once you have promoted the Windows Server 2025 domain controllers, you should demote the existing domain controllers running earlier versions of the Windows Server operating system. Demoting a domain controller removes this role from the computer, returning it to a standard member server role. If the domain controller you need to demote has the Windows Server 2008 R2 or earlier operating system installed, you will need to use the dcpromo wizard to remove Active Directory Domain Services. If the domain controller you need to demote is running the Windows Server 2012 or later operating system, you can run the following PowerShell command:

```powershell
Uninstall-ADDSDomainController -DemoteOperationMasterRole -RemoveApplicationPartition
```

## Upgrade the domain and forest functional level

Once you have removed the existing domain controllers running earlier versions of the Windows Server operating systems, you should raise the domain and forest functional level. Windows Server 2025 is the highest domain and forest functional level presently supported by Active Directory and require that all domain controllers in the domain and forest only run the Windows Server 2025 operating system. 

To upgrade the domain and forest functional level, run the following PowerShell commands:

```powershell
Set-ADDomainMode -identity tailwindtraders.com -DomainMode Windows2025Domain
Set-ADForestMode -Identity tailwindtraders.com -ForestMode Windows2025Forest
```

